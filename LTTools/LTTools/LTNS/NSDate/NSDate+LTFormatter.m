//
//  NSDate+LTFormatter.m
//  DeviceDemo
//
//  Created by yelon on 16/1/8.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSDate+LTFormatter.h"

@implementation NSDate (LTFormatter)

+ (NSString *)LT_currentDateString{
    
    return [self LT_dateString:[NSDate date] formatter:@"yyyyMMdd"];
}

+ (NSString *)LT_currentTimeString{
    
    return [self LT_dateString:[NSDate date] formatter:@"HHmmss"];
}

+ (NSString *)LT_dateString:(NSDate *)date formatter:(NSString *)formatterStr{
    
    NSTimeZone* GTMzone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:GTMzone];
    [formatter setDateFormat:formatterStr];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
@end
