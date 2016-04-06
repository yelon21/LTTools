//
//  LTLocalNotification.h
//  LToolRepoLib
//
//  Created by yelon on 15/7/22.
//  Copyright (c) 2015年 yelon21. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTLocalNotification : NSObject
/**
 *  @author yelon
 *
 *  添加本地通知
 *
 *注意：由于iOS 8对API进行更改，使用本地通知需要注册用户设置
 *iOS8注册本地通知
 *if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
 *{
 *  [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
 *}
 *
 *  @param noticeDic 参数字典
 *  fireDate 必选
 *  alertBody 必选
 *  userInfo
 *  soundName
 
 */
+ (void)addLocalNoticefication:(NSDictionary *)noticeDic;

@end

extern NSString *const LTLocalNotificationKey_fireDate;
extern NSString *const LTLocalNotificationKey_alertBody;
extern NSString *const LTLocalNotificationKey_soundName;
extern NSString *const LTLocalNotificationKey_userInfo;
