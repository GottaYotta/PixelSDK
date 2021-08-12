//
//  Orientation.h
//  PixelSDKFramework
//
//  Created by Josh Bernfeld on 12/7/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OrientationHelper : NSObject

+ (UIDeviceOrientation)deviceOrientationWithCurrentDeviceOrientation:(UIDeviceOrientation)deviceOrientation angle:(double)angle z:(double)z;

@end
