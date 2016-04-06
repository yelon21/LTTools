//
//  NSDate+LTFormatter.h
//  DeviceDemo
//
//  Created by yelon on 16/1/8.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTFormatter)

+ (NSString *)LT_currentDateString;

+ (NSString *)LT_currentTimeString;

- (NSString *)lt_dateString:(NSString *)formatterStr;

+ (NSDate *)LT_date:(NSString *)dateString formatter:(NSString *)formatterStr;
@end
