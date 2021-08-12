//
//  NSObject+LoadFromNib.h
//  PixelSDKFramework
//
//  Created by Josh Bernfeld on 8/14/16.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (LoadFromNib)

+ (id)loadFromNib:(NSString *)name bundle:(NSBundle *)bundle classToLoad:(Class)classToLoad;

@end
