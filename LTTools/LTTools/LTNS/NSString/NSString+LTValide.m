//
//  NSString+LTValide.m
//  YJNew
//
//  Created by yelon on 16/1/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSString+LTValide.h"

@implementation NSString (LTValide)

BOOL LTValidePhoneNumberString(NSString *string){

    if (LTStringIsEmpty(string)) {
        
        return NO;
    }
    return [string lt_isPhoneNumberString];
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
    
    NSString * MOBILE = @"^1(3[0-9]|47|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,178
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|78|705)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176,170[7-9]
     17         */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56]|76)[0-9]|70[7-9])\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,177,170[0-2]
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|70[0-2]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//mail地址格式检查
BOOL LTValideEmailString(NSString *string){
    
    if (LTStringIsEmpty(string)) {
        
        return NO;
    }
    return [string lt_isEmailString];
}

- (BOOL)lt_isEmailString{
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0,self.length)];
    
    if(numberofMatch > 0) {
        
        return YES;
    }
    return NO;
}

BOOL LTValideIpString(NSString *string){
    
    if (LTStringIsEmpty(string)) {
        
        return NO;
    }
    return [string lt_isIpString];
}

- (BOOL)lt_isIpString{
    
    NSString *reg = @"\\d{1,3}(.\\d{1,3}){3}";
    
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:reg
                                  options:0
                                  error:&error];
    
    if (error) {
        
        NSLog(@"error==%@", error);
        return NO;
    }
    else{
        
        NSUInteger numberofMatch = [regex numberOfMatchesInString:self
                                                          options:NSMatchingReportProgress
                                                            range:NSMakeRange(0,self.length)];
        
        if(numberofMatch > 0) {
            
            return YES;
        }
        return NO;
    }
}
BOOL LTStringIsEmpty(NSString *string){
    
    if (string == nil || ![string isKindOfClass:[NSString class]]) {
        
        return YES;
    }
    
    if ([string length] == 0) {
        
        return YES;
    }
    else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        
        return YES;
    }
    return NO;
}


//- (BOOL)isBirthDate{
//
//    NSString *reg = @"";
//}

- (BOOL)lt_isVaildString:(NSString *)reg{
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    
    return [regex evaluateWithObject:self];
}

- (BOOL)lt_isIDCardNumber15{
    
    NSString *reg15 = @"/^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$/";
    BOOL vaild = [self lt_isVaildString:reg15];
    
    return vaild;
}

- (BOOL)lt_isIDCardNumber18{
    
    NSString *reg18 = @"(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";
    BOOL vaild = [self lt_isVaildString:reg18];
    return vaild;
}
BOOL LTValideIDCardNumberString(NSString *string){
    
    if (LTStringIsEmpty(string)) {
        
        return NO;
    }
    return [string lt_isIDCardNumber];
}
- (BOOL)lt_isIDCardNumber{
    
    NSString *uppercaseString = [self uppercaseString];
    
    //    if ([self length]==15) {
    //
    //        return [self isIDCardNumber15];
    //    }
    //    else
    if ([uppercaseString length]==18) {
        
        return [uppercaseString lt_isIDCardNumber18];
    }
    else{
        
        return NO;
    }
}

@end
