//
//  NSString+LTJson.h
//  YJBM
//
//  Created by yelon on 15/12/7.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LTJson)

- (id)lt_jsonObject;

@end

@interface NSString (LTJson)

- (id)lt_jsonObject;

@end

@interface NSDictionary (LTJson)

- (NSString *)lt_jsonString;

@end

@interface NSArray (LTJson)

- (NSString *)lt_jsonString;

@end