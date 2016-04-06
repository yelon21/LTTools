//
//  NSString+number.m
//  ipos
//
//  Created by yelon on 14-5-12.
//
//

#import "NSString+number.h"

@implementation NSString (number)

+ (NSString *)stringWithInt:(int)intNum{

    return [NSString stringWithFormat:@"%d",intNum];
}


//是否为数据
- (BOOL)isNumberMathsString{
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^\\d+(\\.\\d+)?$"
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

//是否为正整数
- (BOOL)isNumberIntegerString{
    
    if (self == nil) {
        
        return NO;
    }
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[1-9]d*$"
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

//是整数
- (BOOL)isNumberString{
    
    if (self == nil) {
        
        return NO;
    }
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^\\d+(\\d+)?$"
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


@end
