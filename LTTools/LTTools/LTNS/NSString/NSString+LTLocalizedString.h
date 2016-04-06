//
//  NSString+LTLocalizedString.h
//  YJNew
//
//  Created by yelon on 16/1/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LTLanguageType) {
    
    LTLanguageTypeDefault,
    LTLanguageType_zh_Hans = LTLanguageTypeDefault,
    LTLanguageType_zang,
};

@interface NSString (LTLocalizedString)

NSString *LTLocalizedString(NSString *key,NSString *comment);
NSString *LTLocalizedStringDefaultValue(NSString *key,NSString *common,NSString *value);

+ (void)LT_setLanguageType:(LTLanguageType)type;

+ (void)LT_setLanguage:(NSString *)language;
+ (NSString *)LT_language;

@end

extern NSString *const LTLanguageTypeDidChangedNotification;
