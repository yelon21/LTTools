//
//  LTPlistReader.m
//  YJNew
//
//  Created by yelon on 16/3/5.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTPlistReader.h"
#import <UIKit/UIKit.h>

@implementation LTPlistReader

+ (id)LT_getBundlePlist:(NSString *)plistName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    return [self LT_objectFromPath:path];
}

+ (NSDictionary *)LT_getDictionary:(NSString *)plistName forKey:(NSString *)keyName{
    
    return [[LTPlistReader LT_getBundlePlist:plistName] objectForKey:keyName];
}

+ (NSArray *)LT_getArray:(NSString *)plistName forKey:(NSString *)keyName{
    
    return [[LTPlistReader LT_getBundlePlist:plistName] objectForKey:keyName];
}

+ (id)LT_objectFromPath:(NSString *)path{

    NSPropertyListFormat format;
    NSError *error = nil;
   
    NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:path];
    
    id obj = nil;
    
    obj = [NSPropertyListSerialization propertyListWithData:plistData
                                                    options:NSPropertyListMutableContainersAndLeaves
                                                     format:&format
                                                      error:&error];
    
    if (error) {
        
        NSLog(@"error=%@",error);
    }
    return obj;
}

+ (BOOL)LT_savePlist:(id)plist toPath:(NSString *)toPath{
    
    NSError *error = nil;
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist
                                                        format:NSPropertyListXMLFormat_v1_0
                                                       options:0
                                                         error:&error];
    
    if (error) {
        
        NSLog(@"error=%@",error);
        return NO;
    }
    if (data) {
        
        return [data writeToFile:toPath atomically:YES];
    }
    else{
    
        return NO;
    }
}
@end
