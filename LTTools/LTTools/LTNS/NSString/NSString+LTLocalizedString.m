//
//  NSString+LTLocalizedString.m
//  YJNew
//
//  Created by yelon on 16/1/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSString+LTLocalizedString.h"

@implementation NSString (LTLocalizedString)

NSString *LTLocalizedStringDefaultValue(NSString *key,NSString *common,NSString *value){
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:[NSString LT_language] ofType:@"lproj"]];
    return NSLocalizedStringWithDefaultValue(key, @"Language", bundle, value, common);
}

NSString *LTLocalizedString(NSString *key,NSString *comment){
    
    return LTLocalizedStringDefaultValue(key, comment, key);
}

NSString *LTLanguageByType(LTLanguageType type){
    
    switch (type) {
            
        case LTLanguageType_zh_Hans:
            return @"zh-Hans";
        case LTLanguageType_zang:
            return @"zang";
        default:
            return @"zh-Hans";
    }
}

+ (void)LT_setLanguageType:(LTLanguageType)type{
    
    [NSString LT_setLanguage:LTLanguageByType(type)];
}

+ (void)LT_setLanguage:(NSString *)language{
    
    [[NSUserDefaults standardUserDefaults] setObject:language
                                              forKey:@"LT_LanguageType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:LTLanguageTypeDidChangedNotification
                                                       object:language];
}

+ (NSString *)LT_language{
    
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"LT_LanguageType"];
    
    if (!language || [language isEqualToString:@""]) {
        
        language = @"zh-Hans";
    }
    return language;
}

@end

NSString *const LTLanguageTypeDidChangedNotification    =   @"LT_LanguageTypeDidChanged_Notification";
