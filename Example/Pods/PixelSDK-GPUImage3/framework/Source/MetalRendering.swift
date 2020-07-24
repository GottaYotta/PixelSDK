import Foundation
import Metal

// OpenGL uses a bottom-left origin while Metal uses a top-left origin.
// [TopLeft.x, TopLeft.y, TopRight.x, TopRight.y, BottomLeft.x, BottomLeft.y, BottomRight.x, BottomRight.y]
public let standardImageVertices:[Float] = [-1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0]

extension MTLCommandBuffer {
    public func clear(with color: Color, outputTexture: Texture) {
        let renderPass = MTLRenderPassDescriptor()
        renderPass.colorAttachments[0].texture = outputTexture.texture
        renderPass.colorAttachments[0].clearColor = MTLClearColorMake(Double(color.redComponent), Double(color.greenComponent), Double(color.blueComponent), Double(color.alphaComponent))
        renderPass.colorAttachments[0].storeAction = .store
        renderPass.colorAttachments[0].loadAction = .clear
        
        Log.info("Clear color: \(renderPass.colorAttachments[0].clearColor)")
        
        guard let renderEncoder = self.makeRenderCommandEncoder(descriptor: renderPass) else {
            Log.error("Could not create render encoder")
            return
        }
//        renderEncoder.setRenderPipelineState(sharedMetalRenderingDevice.passthroughRenderState)

//        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 0)

        renderEncoder.endEncoding()
    }
    
    public func renderQuad(pipelineState:MTLRenderPipelineState, uniformSettings:ShaderUniformSettings? = nil, inputTextures:[UInt:Texture], useNormalizedTextureCoordinates:Bool = true, imageVertices:[Float] = standardImageVertices, outputTexture:Texture, outputOrientation:ImageOrientation = .portrait) {
        let vertexBuffer = sharedMetalRenderingDevice.device.makeBuffer(bytes: imageVertices,
                                                                        length: imageVertices.count * MemoryLayout<Float>.size,
                                                                        options: [])!
        vertexBuffer.label = "Vertices"
        
        
        let renderPass = MTLRenderPassDescriptor()
        renderPass.colorAttachments[0].texture = outputTexture.texture
        renderPass.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 1)
        renderPass.colorAttachments[0].storeAction = .store
        renderPass.colorAttachments[0].loadAction = .clear
        
        guard let renderEncoder = self.makeRenderCommandEncoder(descriptor: renderPass) else {
            Log.error("Could not create render encoder")
            return
        }
        renderEncoder.setFrontFacing(.counterClockwise)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        for textureIndex in 0..<inputTextures.count {
            let currentTexture = inputTextures[UInt(textureIndex)]!
            
            let inputTextureCoordinates = currentTexture.textureCoordinates(for:outputOrientation, normalized:useNormalizedTextureCoordinates)
            let textureBuffer = sharedMetalRenderingDevice.device.makeBuffer(bytes: inputTextureCoordinates,
                                                                             length: inputTextureCoordinates.count * MemoryLayout<Float>.size,
                                                                             options: [])!
            textureBuffer.label = "Texture Coordinates"

            renderEncoder.setVertexBuffer(textureBuffer, offset: 0, index: 1 + textureIndex)
            renderEncoder.setFragmentTexture(currentTexture.texture, index: textureIndex)
        }
        uniformSettings?.restoreShaderSettings(renderEncoder: renderEncoder, vertexBufferIndex: 1 + inputTextures.count)
        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        renderEncoder.endEncoding()
    }
}

public func generateRenderPipelineState(device:MetalRenderingDevice, vertexFunctionName:String, fragmentFunctionName:String, operationName:String, shaderLibrary:MTLLibrary? = nil) -> (MTLRenderPipelineState, [String:(Int, MTLStructMember)], Int) {
    let shaderLibrary = shaderLibrary ?? device.shaderLibrary
    
    guard let vertexFunction = shaderLibrary.makeFunction(name: vertexFunctionName) else {
        fatalError("\(operationName): could not compile vertex function \(vertexFunctionName)")
    }
    
    guard let fragmentFunction = shaderLibrary.makeFunction(name: fragmentFunctionName) else {
        fatalError("\(operationName): could not compile fragment function \(fragmentFunctionName)")
    }
    
    let descriptor = MTLRenderPipelineDescriptor()
    descriptor.colorAttachments[0].pixelFormat = MTLPixelFormat.bgra8Unorm
    descriptor.rasterSampleCount = 1
    descriptor.vertexFunction = vertexFunction
    descriptor.fragmentFunction = fragmentFunction
    descriptor.label = operationName
    
    do {
        var reflection:MTLAutoreleasedRenderPipelineReflection?
        let pipelineState = try device.device.makeRenderPipelineState(descriptor: descriptor, options: [.bufferTypeInfo, .argumentInfo], reflection: &reflection)

        var uniformLookupTable:[String:(Int, MTLStructMember)] = [:]
        var bufferSize: Int = 0
        if let fragmentArguments = reflection?.fragmentArguments {
            for fragmentArgument in fragmentArguments where fragmentArgument.type == .buffer {
                if
                  (fragmentArgument.bufferDataType == .struct),
                  let members = fragmentArgument.bufferStructType?.members.enumerated() {
                    bufferSize = fragmentArgument.bufferDataSize
                    for (index, uniform) in members {
                        uniformLookupTable[uniform.name] = (index, uniform)
                    }
                }
            }
        }
        
        return (pipelineState, uniformLookupTable, bufferSize)
    } catch {
        fatalError("Could not create render pipeline state for vertex:\(vertexFunctionName), fragment:\(fragmentFunctionName), error:\(error)")
    }
}
