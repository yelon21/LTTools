//
//  NSString+LTValide.h
//  YJNew
//
//  Created by yelon on 16/1/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTValide)

//电话格式检查
BOOL LTValidePhoneNumberString(NSString *string);
- (BOOL)lt_isPhoneNumberString;

//mail地址格式检查
BOOL LTValideEmailString(NSString *string);
- (BOOL)lt_isEmailString;

//ip地址格式检查
BOOL LTValideIpString(NSString *string);
- (BOOL)lt_isIpString;

//身份证号
BOOL LTValideIDCardNumberString(NSString *string);
- (BOOL)lt_isIDCardNumber;

BOOL LTStringIsEmpty(NSString *string);

@end
