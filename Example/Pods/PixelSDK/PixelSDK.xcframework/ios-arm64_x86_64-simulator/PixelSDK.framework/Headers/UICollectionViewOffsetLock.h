//
//  UICollectionViewOffsetLock.h
//  PixelSDKFramework
//
//  Created by Josh Bernfeld on 12/15/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewOffsetLock : UICollectionView

- (void)lockScrolling;
- (void)unlockScrolling;

@end
