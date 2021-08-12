//
//  JSONSerializationHelper.h
//  PixelSDKFramework
//
//  Created by Josh Bernfeld on 1/2/20.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONSerializationHelper : NSObject
+ (id)JSONObjectByRemovingKeysWithNullValues:(id)JSONObject readingOptions:(NSJSONReadingOptions)readingOptions;
@end

NS_ASSUME_NONNULL_END
