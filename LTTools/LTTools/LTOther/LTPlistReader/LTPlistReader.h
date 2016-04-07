//
//  LTPlistReader.h
//  YJNew
//
//  Created by yelon on 16/3/5.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTPlistReader : NSObject

+ (id)LT_getBundlePlist:(NSString *)plistName;
+ (NSDictionary *)LT_getDictionary:(NSString *)plistName forKey:(NSString *)keyName;
+ (NSArray *)LT_getArray:(NSString *)plistName forKey:(NSString *)keyName;

+ (id)LT_objectFromPath:(NSString *)path;

+ (BOOL)LT_savePlist:(id)plist toPath:(NSString *)toPath;
@end
