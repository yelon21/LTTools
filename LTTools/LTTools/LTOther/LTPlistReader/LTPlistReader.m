//
//  LTPlistReader.m
//  YJNew
//
//  Created by yelon on 16/3/5.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTPlistReader.h"

@implementation LTPlistReader

+ (NSDictionary *)LT_getDictionary:(NSString *)plistName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

+ (id)LT_getDictionary:(NSString *)plistName forKey:(NSString *)keyName{
    
    return [[LTPlistReader LT_getDictionary:plistName] objectForKey:keyName];
}

//+ (void)TEST{
//
//    NSPropertyListSerialization
//}

@end
