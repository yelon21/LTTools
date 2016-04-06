//
//  NSString+LTTransform.m
//  YJNew
//
//  Created by yelon on 16/3/4.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSString+LTTransform.h"

@implementation NSString (LTTransform)

//转换特殊字符
- (NSString *)lt_escapedValue{
    //    __bridge_transfer arc时候用(__bridge_transfer NSString *)
    return ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (__bridge CFStringRef)self,
                                                                                  NULL,
                                                                                  CFSTR("!*'();:@&=+$,/?%#[]"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));;
}

+ (NSString *)LT_stringValue:(id)value{
    
    if (!value) {
        
        return @"";
    }
    return [NSString stringWithFormat:@"%@",value];
}
@end
