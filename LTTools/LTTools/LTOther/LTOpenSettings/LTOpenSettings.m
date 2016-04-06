//
//  LTOpenSettings.m
//  YJNew
//
//  Created by yelon on 16/1/15.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTOpenSettings.h"
#import <UIKit/UIApplication.h>

@implementation LTOpenSettings
void LTOpenSettingsURLString(NSString *urlString){
    
    if (!urlString || ![urlString isKindOfClass:[NSString class]]) {
        
        return;
    }
    if ([urlString isEqualToString:LTSettingsLocationURLString]&&
        [[[UIDevice currentDevice]systemVersion] doubleValue]>=8.0) {
        
        urlString = UIApplicationOpenSettingsURLString;
    }
    
    NSURL * url = [NSURL URLWithString:urlString];
    NSLog(@"url==%@",url);
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        NSLog(@"canOpenURL==%@",url);
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end

NSString * const LTSettingsWifiURLString        = @"prefs:root=WIFI";//WIFI
NSString * const LTSettingsLocationURLString    = @"prefs:root=LOCATION_SERVICES";//定位服务
NSString * const LTSettingsNotificationURLString   = @"prefs:root=NOTIFICATIONS_ID";//通知

NSString * const LTSettingsPhoneURLString       = @"prefs:root=Phone";//电话

NSString * const LTSettingsPhotosURLString      = @"prefs:root=Photos";//相册
NSString * const LTSettingsAirplaneModeOnURLString   = @"prefs:root=AIRPLANE_MODE";//设置？？


//NSString * const LTSettingsBrightnessURLString  = @"prefs:root=Brightness";
NSString * const LTSettingsInternetTetheringURLString     = @"prefs:root=INTERNET_TETHERING";
NSString * const LTSettingsSettingURLString = @"prefs:";//设置
NSString * const LTSettingsFaceTimeURLString    = @"prefs:root=FACETIME";//fance time

NSString * const LTSettingsGeneralURLString     = @"prefs:root=General";//设置通用
NSString * const LTSettingsAboutURLString       = @"prefs:root=General&path=About";//关于本机
NSString * const LTSettingsAutoLockURLString    = @"prefs:root=General&path=AUTOLOCK";//自动锁定
NSString * const LTSettingsKeyboardURLString    = @"prefs:root=General&path=Keyboard";//键盘
NSString * const LTSettingsAccessibilityURLString   = @"prefs:root=General&path=ACCESSIBILITY";//辅助功能
NSString * const LTSettingsBluetoothURLString   = @"prefs:root=Bluetooth";//蓝牙
//NSString * const LTSettingsNetworkURLString     = @"prefs:root=Network";
NSString * const LTSettingsDateTimeURLString    = @"prefs:root=General&path=DATE_AND_TIME";//日期时间

NSString * const LTSettingsProfileURLString   = @"prefs:root=General&path=ManagedConfigurationList";//描述文件与设备管理


