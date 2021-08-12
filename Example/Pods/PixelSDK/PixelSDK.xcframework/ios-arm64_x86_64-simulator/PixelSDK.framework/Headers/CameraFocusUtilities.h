//
//  CameraFocusUtilities.h
//  PixelSDKFramework
//
//  Created by Josh Bernfeld on 11/15/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, GPUImageFillMode) {
    GPUImageFillModeStretch,
    GPUImageFillModePreserveAspectRatio,
    GPUImageFillModePreserveAspectRatioAndFill
};

@interface CameraFocusUtilities : NSObject

+ (UIView *)displayFocusCircleViewWithTapPoint:(CGPoint)tapPoint view:(UIView *)view;

+ (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates
                                               inFrame:(CGRect)frame
                                       withOrientation:(UIDeviceOrientation)orientation
                                              fillMode:(GPUImageFillMode)fillMode
                                              mirrored:(BOOL)mirrored;

@end
