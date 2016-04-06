//
//  NSData+LTCommon.m
//  YJNew
//
//  Created by yelon on 16/3/4.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSData+LTCommon.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (LTCommon)

- (NSString *)lt_stringValueUTF8{

    if (self) {
        
        return [[NSString alloc]initWithData:self
                                    encoding:NSUTF8StringEncoding];
    }
    return nil;
}

-(NSString *)lt_MD5{
    
    if (self == nil) {
        return nil;
    }
    const char* str = (const char *)[self bytes];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    NSNumber *len = @(strlen(str));
    unsigned int lenU = [len unsignedIntValue];
    CC_MD5(str, lenU, result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02X",result[i]];
    }
    
    return ret;
}

-(NSString*)lt_SHA1{
    
    if (self == nil) {
        
        return nil;
    }
    
    NSData *data = self;
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        
        [output appendFormat:@"%02X", digest[i]];
    }
    
    return output;
}

- (NSString*)lt_SHA224
{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    if (self == nil) {
        
        return nil;
    }
    
    NSData *data = self;
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)lt_SHA226{
    
    if (self == nil) {
        
        return nil;
    }
    
    NSData *data = self;
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)lt_SHA384{
    
    if (self == nil) {
        
        return nil;
    }
    
    NSData *data = self;
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)lt_SHA512{
    
    if (self == nil) {
        
        return nil;
    }
    
    NSData *data = self;
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
