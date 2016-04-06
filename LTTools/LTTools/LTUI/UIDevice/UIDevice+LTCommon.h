//
//  UIDevice+LTCommon.h
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (LTCommon)

+ (CGSize)LT_deviceScreenSize;

+ (NSString *)LT_deviceType;
+ (NSString *)LT_deviceName;

@end
