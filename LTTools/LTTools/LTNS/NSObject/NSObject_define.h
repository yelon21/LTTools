//
//  NSObject_define.h
//  YLkit
//
//  Created by yelon on 15-4-1.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef OBJC_ARC_ENABLED
#ifdef __has_feature
#define OBJC_ARC_ENABLED __has_feature(objc_arc)
#else
#define OBJC_ARC_ENABLED 0
#endif
#endif

#if OBJC_ARC_ENABLED
#define YL_Release(obj) obj
#define YL_AutoRelease(obj) obj
#define YL_SuperDealloc nil;
#else
#define YL_Release(obj) [(obj) release]
#define YL_AutoRelease(obj) [(obj) autorelease]
#define YL_SuperDealloc [super dealloc]
#endif

#define SUPPORT_ARM64 (__LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64)


#ifdef DEBUG
#define YLLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define YLLog(fmt, ...) nil
#endif

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(fmt, ...) nil
#endif

#define ClassAndMethod [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]

//#define DeviceScreen [UIScreen mainScreen]
//#define ScreenBounds [DeviceScreen bounds]

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

#define IOS_VERSION [[[UIDevice currentDevice]systemVersion] doubleValue]

@interface NSObject ()

@end
