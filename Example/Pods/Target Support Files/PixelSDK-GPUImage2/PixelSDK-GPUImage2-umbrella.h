#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GPUImage-Bridging-Header.h"
#import "GPUImage.h"
#import "NSObject+Exception.h"
#import "TPCircularBuffer.h"

FOUNDATION_EXPORT double GPUImageVersionNumber;
FOUNDATION_EXPORT const unsigned char GPUImageVersionString[];

