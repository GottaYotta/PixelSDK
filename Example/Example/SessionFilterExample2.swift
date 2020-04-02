//
//  SessionFilterExample2.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 11/20/19.
//  Copyright © 2019 GottaYotta, Inc. All rights reserved.
//

import Foundation
import PixelSDK
import GPUImage

class SessionFilterExample2: SessionFilter {
    public required init() {
        super.init()
        
        self.commonInit()
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        self.commonInit()
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
    func commonInit() {
        self.displayName = "Example 2"
        self.version = "1.0"
        self.cameraThumbnailImage = UIImage(named: "thumbnail_example.png")
        
        // self.normalizedIntensityDefault = 100 // This value gets computed
        self.normalizedIntensityRange = (0, 100)
        self.actualIntensityDefault = 1
        self.actualIntensityRange = (0, 1)
    }
    
    override public func operation() -> ImageProcessingOperation {
        return ExampleOperation()
    }
    
    override public func operationUpdateNeeded(_ op: ImageProcessingOperation) {
        let op = op as! ExampleOperation
        
        op.intensity = Float(self.actualIntensity)
    }
}

class ExampleOperation: OperationGroup {
    let lookupFilter = LookupFilter()
    let brightnessAdjustment = BrightnessAdjustment()
    let sharpenAdjustment = Sharpen()
    
    var intensity: Float = 1  {
        didSet {
            // 1 is default for intensity
            lookupFilter.intensity = self.intensity.translateFromRangeToRange(oldMin: 0, oldMax: 1, newMin: 0, newMax: 1)
            // 0 is default for brightness
            brightnessAdjustment.brightness = self.intensity.translateFromRangeToRange(oldMin: 0, oldMax: 1, newMin: 0, newMax: 0.025)
            // 0 is default for sharpness
            sharpenAdjustment.sharpness = self.intensity.translateFromRangeToRange(oldMin: 0, oldMax: 1, newMin: 0, newMax: 0.25)
        }
    }
    
    public override init() {
        super.init()
        
        do {
            lookupFilter.lookupImage = try PictureInput(image: UIImage(named: "lookup_example.png")!)
        }
        catch {
            print("ERROR: Unable to create PictureInput \(error)")
        }
        
        self.configureGroup { (input, output) in
            input --> lookupFilter --> brightnessAdjustment --> sharpenAdjustment --> output
        }
    }
}
