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
    
    return [[NSDate date] lt_dateString:@"yyyyMMdd"];
}

+ (NSString *)LT_currentTimeString{
    
    return [[NSDate date] lt_dateString:@"HHmmss"];
}

- (NSString *)lt_dateString:(NSString *)formatterStr{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    [formatter setDateFormat:formatterStr];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

+ (NSDate *)LT_date:(NSString *)dateString formatter:(NSString *)formatterStr{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}
@end
