//
//  NSString+LTEncryption.h
//  YJNew
//
//  Created by yelon on 16/3/4.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTEncryption)

- (NSString *)lt_md5;
- (NSString *)lt_MD5;

- (NSString *)lt_getFileMD5;
@end
