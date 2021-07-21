//
//  SessionFilterExample1.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 11/20/19.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import PixelSDK
import GPUImage

class SessionFilterExample1: SessionFilter {
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
        self.displayName = "Example 1"
        self.version = "1.0"
        self.cameraThumbnailImage = UIImage(named: "thumbnail_example.png")
        
        // self.normalizedIntensityDefault = 100 // This value gets computed
        self.normalizedIntensityRange = (0, 100)
        self.actualIntensityDefault = 1
        self.actualIntensityRange = (0, 1)
    }
    
    override public func operation() -> ImageProcessingOperation {
        let lookupFilter = LookupFilter()
        
        do {
            lookupFilter.lookupImage = try PictureInput(image: UIImage(named: "lookup_example.png")!)
        }
        catch {
            print("ERROR: Unable to create PictureInput \(error)")
        }
        
        return lookupFilter
    }
    
    override public func operationUpdateNeeded(_ op: ImageProcessingOperation) {
        let op = op as! LookupFilter
        
        op.intensity = Float(self.actualIntensity)
    }
}
