//
//  NSString+LTRex.h
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTRex)
//包含数字
- (BOOL)lt_containNumber;
//包含大写字母
- (BOOL)lt_containcUppercaseLetter;
//包含小写字母
- (BOOL)lt_containcLowercaseLetter;
//包含字母
- (BOOL)lt_containcLetters;
//密码:（6-16）位字符
- (BOOL)lt_vaidPassword;

//银行卡号
- (BOOL)lt_isBankCardNumber;
//银行卡有效期
- (BOOL)lt_isCardDate;

//电话格式检查
- (BOOL)lt_isPhoneNumberString;
//mail地址格式检查
- (BOOL)lt_isEmailString;

//身份证号
- (BOOL)lt_isIDCardNumber;
//15位身份证号
- (BOOL)lt_isIDCardNumber15;
//18位身份证号
- (BOOL)lt_isIDCardNumber18;
//是否为数学数据
- (BOOL)lt_isMathsNumber;
//是否为正整数
- (BOOL)lt_isMathsNumberIntegerString;
//全数字字符串
- (BOOL)lt_isNumberString;
//ip
- (BOOL)lt_isIpString;
@end
