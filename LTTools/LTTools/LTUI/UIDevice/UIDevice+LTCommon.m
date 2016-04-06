//
//  UIDevice+LTCommon.m
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "UIDevice+LTCommon.h"
#include <sys/utsname.h>

@implementation UIDevice (LTCommon)

+ (CGSize)LT_deviceScreenSize{
    
    return [UIScreen mainScreen].bounds.size;
}

+ (NSString *)LT_deviceType{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machine_ = [NSString stringWithFormat:@"%s",systemInfo.machine];
    return machine_;
}

+ (NSString *)LT_deviceName{
    
    NSString *platform = [UIDevice LT_deviceType];
    
    NSString *deviceType = [platform lowercaseString];
    
    if ([deviceType hasPrefix:@"iphone"]) {
        
        return [UIDevice LT_deviceNameIphone];
    }
    else if ([deviceType hasPrefix:@"ipod"]){
    
        return [UIDevice LT_deviceNameIPod];
    }
    else if ([deviceType hasPrefix:@"ipad"]){
        
        return [UIDevice LT_deviceNameIPad];
    }
    
    return platform;
}

+ (NSString *)LT_deviceNameIPad{
    
    NSString *platform = [UIDevice LT_deviceType];
    NSLog(@"platform==%@",platform);
    
    if ([platform isEqualToString:@"iPad1,1"]){
        
        return @"iPad";
    }
    else if ([platform isEqualToString:@"iPad2,1"]){
        
        return @"iPad 2";
    }
    else if ([platform isEqualToString:@"iPad3,1"]){
        
        return @"iPad 3";
    }
    else if ([platform isEqualToString:@"iPad3,4"]){
        
        return @"iPad 4";
    }
    else if ([platform isEqualToString:@"iPad4,1"]){
        
        return @"iPad 5 iPad Air Wifi";
    }
    else if ([platform isEqualToString:@"iPad4,2"]){
        
        return @"iPad 5 iPad Air Cellular";
    }
    else if ([platform isEqualToString:@"iPad2,5"]){
        
        return @"iPad Mini";
    }
    else if ([platform isEqualToString:@"iPad4,4"]){
        
        return @"iPad Mini 2 Wifi";
    }
    else if ([platform isEqualToString:@"iPad4,5"]){
        
        return @"iPad Mini 2 Cellular";
    }
    else if ([platform isEqualToString:@"iPad4,7"]){
        
        return @"iPad Mini 3 Wifi";
    }
    else if ([platform isEqualToString:@"iPad5,1"]){
        
        return @"iPad Mini 4 (A1538)";
    }
    else if ([platform isEqualToString:@"iPad5,2"]){
        
        return @"iPad Mini 4 (A1550)";
    }
    return platform;
}

+ (NSString *)LT_deviceNameIPod{

    NSString *platform = [UIDevice LT_deviceType];
    NSLog(@"platform==%@",platform);
    
    if ([platform isEqualToString:@"iPod1,1"]){
        
        return @"iPod Touch";
    }
    else if ([platform isEqualToString:@"iPod2,1"]){
        
        return @"iPod Touch 2th";
    }
    else if ([platform isEqualToString:@"iPod3,1"]){
        
        return @"iPod Touch 3th";
    }
    else if ([platform isEqualToString:@"iPod4,1"]){
        
        return @"iPod Touch 4th";
    }
    else if ([platform isEqualToString:@"iPod5,1"]){
        
        return @"iPod Touch 5th";
    }
    else if ([platform isEqualToString:@"iPod7,1"]){
        
        return @"iPod Touch 6th";
    }
    
    return platform;
}

+ (NSString *)LT_deviceNameIphone{

    NSString *platform = [UIDevice LT_deviceType];
    NSLog(@"platform==%@",platform);
    
    if ([platform isEqualToString:@"iPhone1,1"]){
        
        return @"iPhone 2G";
    }
    else if ([platform isEqualToString:@"iPhone1,2"]){
        
        return @"iPhone 3G";
    }
    else if ([platform isEqualToString:@"iPhone2,1"]){
        
        return @"iPhone 3GS";
    }
    else if ([platform isEqualToString:@"iPhone3,1"]){
        
        return @"iPhone 4 (GSM)";
    }
    else if ([platform isEqualToString:@"iPhone3,2"]){
        
        return @"iPhone 4";
    }
    else if ([platform isEqualToString:@"iPhone3,3"]){
        
        return @"iPhone 4 (CDMA/Verizon/Sprint)";
    }
    else if ([platform isEqualToString:@"iPhone4,1"]){
        
        return @"iPhone 4S";
    }
    else if ([platform isEqualToString:@"iPhone5,1"]){
        
        return @"iPhone 5 (A1428)";
    }
    else if ([platform isEqualToString:@"iPhone5,2"]){
        
        return @"iPhone 5 (A1429/A1442)";
    }
    else if ([platform isEqualToString:@"iPhone5,3"]){
        
        return @"iPhone 5c (A1456/A1532)";
    }
    else if ([platform isEqualToString:@"iPhone5,4"]){
        
        return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    }
    else if ([platform isEqualToString:@"iPhone6,1"]){
        
        return @"iPhone 5s (A1453/A1533)";
    }
    else if ([platform isEqualToString:@"iPhone6,2"]){
        
        return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    }
    else if ([platform isEqualToString:@"iPhone7,1"]){
        
        return @"iPhone 6 Plus (A1522/A1524)";
    }
    else if ([platform isEqualToString:@"iPhone7,2"]){
        
        return @"iPhone 6 (A1549/A1586)";
    }
    else if ([platform isEqualToString:@"iPhone8,1"]){
        
        return @"iPhone 6s";
    }
    else if ([platform isEqualToString:@"iPhone8,2"]){
        
        return @"iPhone 6s Plus";
    }
    
    return platform;
}

@end
