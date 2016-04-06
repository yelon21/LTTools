//
//  LTRequest.h
//  YJBM
//
//  Created by yelon on 16/1/1.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTRequest : NSOperation

@property(nonatomic,strong,readonly) NSMutableURLRequest *request;
@property(nonatomic,strong,readonly) NSURLConnection *connection;
- (void)test:(NSString *)body;

- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key;

- (NSURLRequest *)postUrl:(NSString *)urlString
                 complete:(void (^)(NSData *responseData, NSString *errorString))completeBlock;

- (NSURLRequest *)postUrl:(NSString *)urlString
                 progress:(void (^)(double currentLength, double totleLength,NSData *receiveData))progressBlock
                 complete:(void (^)(NSData *responseData, NSString *errorString))completeBlock;

@end
