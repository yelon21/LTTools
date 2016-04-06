//
//  NSString+number.h
//  ipos
//
//  Created by yelon on 14-5-12.
//
//

#import <Foundation/Foundation.h>

@interface NSString (number)

+ (NSString *)stringWithInt:(int)intNum;

//是否为数据
- (BOOL)isNumberMathsString;
//是否为正整数
- (BOOL)isNumberIntegerString;
- (BOOL)isNumberString;
@end
