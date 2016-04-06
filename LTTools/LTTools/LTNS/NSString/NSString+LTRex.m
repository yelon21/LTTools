//
//  NSString+LTRex.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSString+LTRex.h"

@implementation NSString (LTRex)

- (BOOL)isEmpty{
    
    if (self == nil) {
        
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        
        NSString *temp = (NSString *) self;
        if (temp == nil) {
            
            return YES;
        }
        else if ([temp length] == 0) {
            
            return YES;
        }
        else if ([[temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            
            return YES;
        }
        return NO;
    }
    else {
        
        return YES;
    }
}

- (BOOL)evaluate:(NSString *)rex{
    
    if ([self isEmpty]) {
        
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rex];
    
    return [predicate evaluateWithObject:self];
}
//包含数字
- (BOOL)lt_containNumber{
    
    NSString *rex = @"^.*\\d+.*$";
    
    return [self evaluate:rex];
}
//包含大写字母
- (BOOL)lt_containcUppercaseLetter{
    
    NSString *rex = @"^.*[A-Z]+.*$";
    
    return [self evaluate:rex];
}
//包含小写字母
- (BOOL)lt_containcLowercaseLetter{
    
    NSString *rex = @"^.*[a-z]+.*$";
    
    return [self evaluate:rex];
}
//包含字母
- (BOOL)lt_containcLetters{
    
    NSString *rex = @"^.*[a-zA-Z]+.*$";
    
    return [self evaluate:rex];
}
//密码:（6-16）位字符
- (BOOL)lt_vaidPassword{
    
    NSString *rex = @"^\\S{6,16}$";
    
    return [self evaluate:rex];
}

//银行卡号
- (BOOL)lt_isBankCardNumber{
    NSString *rex = @"^([0-9]{16}|[0-9]{19})$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//银行卡有效期
- (BOOL)lt_isCardDate{
    
    NSString *rex = @"^([0][1-9]|[1][0-2])([1][6-9]|[2][0-9])$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//电话格式检查
- (BOOL)lt_isPhoneNumberString{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    //    中国移动：134（不含1349）、135、136、137、138、139、147、150、151、152、157、158、159、182、183、184、187、188
    //    中国联通：130、131、132、145（上网卡）、155、156、185、186
    //    中国电信：133、1349（卫星通信）、153、180、181、189
    //    未知号段：140、141、142、143、144、146、148、149、154
    
    NSString * MOBILE = @"^1(3[0-9]|47|5[0-35-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,178
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|78)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,177
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    if ([self evaluate:MOBILE]
        || [self evaluate:CM]
        || [self evaluate:CU]
        || [self evaluate:CT]){
        
        return YES;
    }
    else {
        
        return NO;
    }
}
//mail地址格式检查
- (BOOL)lt_isEmailString{
    
    NSString *rex = @"^\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//身份证号
- (BOOL)lt_isIDCardNumber{
    
    if ([self length]==15) {
        
        return [self lt_isIDCardNumber15];
    }
    else if ([self length]==18) {
        
        return [self lt_isIDCardNumber18];
    }
    else{
        
        return NO;
    }
}
//15位身份证号
- (BOOL)lt_isIDCardNumber15{
    
    NSString *rex = @"^[1-9]\\d{7}((0[1-9])|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//18位身份证号
- (BOOL)lt_isIDCardNumber18{
    
    NSString *rex = @"^\\d{10}((0[1-9])|(1[0-2]))((0[1-9])|([1-2]\\d)|(3[0-1]))\\d{3}([0-9]|X|x)$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

//是否为数学数据
- (BOOL)lt_isMathsNumber{
    
    NSString *rex = @"^(\\+|-)?\\d+(\\.\\d+)?$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

//是否为正整数
- (BOOL)lt_isMathsNumberIntegerString{
    
    NSString *rex = @"^[1-9]\\d*$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

//全数字字符串
- (BOOL)lt_isNumberString{
    
    NSString *rex = @"^\\d+$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//ip
- (BOOL)lt_isIpString{
    
    NSString *rex = @"\\d{1,3}(.\\d{1,3}){3}";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
@end
