//
//  NSString+LTTransform.h
//  YJNew
//
//  Created by yelon on 16/3/4.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTTransform)

//转换特殊字符
- (NSString *)lt_escapedValue;
+ (NSString *)LT_stringValue:(id)value;
@end
