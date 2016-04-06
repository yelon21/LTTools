//
//  LTPlistReader.h
//  YJNew
//
//  Created by yelon on 16/3/5.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTPlistReader : NSObject

+ (NSDictionary *)LT_getDictionary:(NSString *)plistName;
+ (id)LT_getDictionary:(NSString *)plistName forKey:(NSString *)keyName;

@end
