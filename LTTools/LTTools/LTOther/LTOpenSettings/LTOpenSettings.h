//
//  LTOpenSettings.h
//  YJNew
//
//  Created by yelon on 16/1/15.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
@interface LTOpenSettings : NSObject

void LTOpenSettingsURLString(NSString *urlString);

@end
//

extern NSString * const LTSettingsWifiURLString;//WIFI
extern NSString * const LTSettingsLocationURLString;//定位服务
extern NSString * const LTSettingsNotificationURLString;//通知
extern NSString * const LTSettingsBluetoothURLString;//蓝牙

extern NSString * const LTSettingsPhoneURLString;//电话
extern NSString * const LTSettingsPhotosURLString;//相册
extern NSString * const LTSettingsAirplaneModeOnURLString;//设置？？
extern NSString * const LTSettingsInternetTetheringURLString;//热点
extern NSString * const LTSettingsSettingURLString;//设置
extern NSString * const LTSettingsFaceTimeURLString;//fance time
extern NSString * const LTSettingsGeneralURLString;//设置通用
extern NSString * const LTSettingsAboutURLString;//关于本机
extern NSString * const LTSettingsAutoLockURLString;//自动锁定
extern NSString * const LTSettingsKeyboardURLString;//键盘
extern NSString * const LTSettingsAccessibilityURLString;//辅助功能
extern NSString * const LTSettingsDateTimeURLString;//日期时间
extern NSString * const LTSettingsProfileURLString;//描述文件与设备管理

