//
//  AVCaptureDeviceFormat+Additions.h
//  PixelSDKFramework
//
//  Created by Josh Bernfeld on 11/27/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AVCaptureDevice (Additions)

- (void)setFrameRate:(int)frameRate withSize:(CGSize)size;
// Calling this will lock focus and exposure.
- (void)setFocusAndExposure:(CGPoint)focusPointOfIntereset;
// If you need to reenable auto focus/exposure call this.
- (void)enableContinuousAutoFocusAndExposure;

@end
