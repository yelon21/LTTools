//
//  LTLocalNotification.m
//  LToolRepoLib
//
//  Created by yelon on 15/7/22.
//  Copyright (c) 2015年 yelon21. All rights reserved.
//

#import "LTLocalNotification.h"

NSString *const LTLocalNotificationKey_fireDate     =   @"fireDate_";
NSString *const LTLocalNotificationKey_alertBody    =   @"alertBody_";
NSString *const LTLocalNotificationKey_soundName    =   @"soundName_";
NSString *const LTLocalNotificationKey_userInfo     =   @"userInfo_";

@implementation LTLocalNotification

+ (void)addLocalNoticefication:(NSDictionary *)noticeDic{
    
    NSDate *fireDate = noticeDic[LTLocalNotificationKey_fireDate];
//    NSLog(@"timeIntervalSinceDate == %lf",[[NSDate date] timeIntervalSinceDate:fireDate]);
    if (!fireDate || [[NSDate date] timeIntervalSinceDate:fireDate]>0) {
        
        return;
    }
    NSString *alertBody = noticeDic[LTLocalNotificationKey_alertBody];
    if (!alertBody) {
        
        return;
    }
    
    NSString *soundName = noticeDic[LTLocalNotificationKey_soundName];
    if (!soundName) {
        
        soundName = UILocalNotificationDefaultSoundName;
    }
    
    NSDictionary *userInfo = noticeDic[LTLocalNotificationKey_userInfo];
    
    UILocalNotification *localNoticefication = [[UILocalNotification alloc]init];
    
    localNoticefication.fireDate = fireDate;
    
    localNoticefication.repeatInterval = 0;
    localNoticefication.timeZone = [NSTimeZone defaultTimeZone];
    localNoticefication.alertBody= alertBody;
    localNoticefication.soundName =  soundName;
    if (userInfo) {
        
        localNoticefication.userInfo = userInfo;
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoticefication];
}
@end
