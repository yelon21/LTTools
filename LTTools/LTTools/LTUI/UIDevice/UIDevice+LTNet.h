//
//  UIDevice+LTNet.h
//  YJBM
//
//  Created by yelon on 15/12/7.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (LTNet)
//外网ip
+ (NSString *)LT_ipWWWAddress;
//内网ip
+ (NSString *)LT_localWiFiIPAddress;
//本地ip
+ (NSString *)LT_getLocalAddress;
@end
