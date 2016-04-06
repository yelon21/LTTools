//
//  NSData+LTCommon.h
//  YJNew
//
//  Created by yelon on 16/3/4.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LTCommon)

- (NSString *)lt_stringValueUTF8;

- (NSString *)lt_MD5;

- (NSString *)lt_SHA1;

- (NSString *)lt_SHA224;

- (NSString *)lt_SHA226;

- (NSString *)lt_SHA384;

- (NSString *)lt_SHA512;
@end
