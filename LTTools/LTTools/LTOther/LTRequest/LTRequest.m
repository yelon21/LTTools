//
//  LTRequest.m
//  YJBM
//
//  Created by yelon on 16/1/1.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTRequest.h"

#import "NSString+LTJson.h"
#import "NSString+LTTransform.h"

//#ifdef DEBUG
//#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
#define NSLog(fmt, ...) nil
//#endif

static NSOperationQueue *sharedQueue = nil;

@interface LTRequest ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>{

    double expectedContentLength;
}
@property(nonatomic,strong,readwrite)NSMutableURLRequest *request;
@property(nonatomic,strong,readwrite)NSURLConnection *connection;
@property(nonatomic,strong) NSMutableData *receiveData;
@property(nonatomic,strong) NSMutableArray *postData;

@property(nonatomic,strong) void (^CompleteBlock)(NSData *, NSString *);
@property(nonatomic,strong) void (^ProgressBlock)(double, double,NSData *);
@end

@implementation LTRequest

-(instancetype)init{

    if (self = [super init]) {
        
        sharedQueue = [[NSOperationQueue alloc] init];
        [sharedQueue setMaxConcurrentOperationCount:5];
    }
    return self;
}

- (void)test:(NSString *)body{

}

- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key{

    if (!self.postData) {
        
        self.postData = [[NSMutableArray alloc]init];
    }
    [[self postData] addObject:@{@"key":key,@"value":[value description]}];
}

- (NSURLRequest *)postUrl:(NSString *)urlString complete:(void (^)(NSData *responseData, NSString *errorString))completeBlock{

    return [self postUrl:urlString
         progress:nil
         complete:completeBlock];
}

- (NSURLRequest *)postUrl:(NSString *)urlString
                 progress:(void (^)(double currentLength, double totleLength,NSData *receiveData))progressBlock
                 complete:(void (^)(NSData *responseData, NSString *errorString))completeBlock{
    
    if (!urlString||![urlString isKindOfClass:[NSString class]]) {
        
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url) {
        
        return nil;
    }
    
    expectedContentLength = 0;
    
    [sharedQueue addOperation:self];
    self.CompleteBlock = completeBlock;
    self.ProgressBlock = progressBlock;
    
    NSMutableArray *postArgs = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.postData) {
        
        NSString *argString = [NSString stringWithFormat:@"%@=%@",[dic[@"key"] lt_escapedValue],[dic[@"value"] lt_escapedValue]];
        [postArgs addObject:argString];
    }
    NSLog(@"postArgs==%@",postArgs);
    NSString *postBodyString = [postArgs componentsJoinedByString:@"&"];
    NSLog(@"postBodyString==%@",postBodyString);
    NSData *postBodyData = [postBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    self.request = [[NSMutableURLRequest alloc]initWithURL:url];
    self.request.HTTPMethod = @"POST";
    self.request.HTTPBody = postBodyData;
    self.connection = [[NSURLConnection alloc]initWithRequest:_request
                                                     delegate:self
                                             startImmediately:NO];
    [self.connection start];
    return self.request;
}
#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error==%@",error);
    if (self.CompleteBlock) {
        self.CompleteBlock(nil,[error localizedDescription]);
    }
}
//认证
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    
    return NO;
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"challenge==%@",challenge);
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    NSLog(@"protectionSpace==%@",protectionSpace);
    return NO;
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"challenge==%@",challenge);
}
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"challenge==%@",challenge);
}

#pragma mark NSURLConnectionDataDelegate

- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response{

    NSLog(@"request==%@",request);
    NSLog(@"response==%@",response);
    
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response==%@",response);
    NSLog(@"suggestedFilename==%@",response.suggestedFilename);
    NSLog(@"textEncodingName==%@",response.textEncodingName);
    NSLog(@"MIMEType==%@",response.MIMEType);
    NSLog(@"expectedContentLength==%@",@(response.expectedContentLength));
    
    expectedContentLength = [@(response.expectedContentLength) doubleValue];
    self.receiveData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    NSLog(@"[data length]==%@",@([data length]));
    [self.receiveData appendData:data];

    double receiveDataLength = [@([self.receiveData length]) doubleValue];
    NSLog(@"receiveDataLength==%@",@(receiveDataLength));
    
    if (self.ProgressBlock) {
        
        self.ProgressBlock(receiveDataLength,expectedContentLength,self.receiveData);
    }
}

//- (nullable NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request{
//    NSLog(@"request==%@",request);
//}
- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    
    NSLog(@"bytesWritten==%@",@(bytesWritten));
    NSLog(@"totalBytesWritten==%@",@(totalBytesWritten));
    NSLog(@"totalBytesExpectedToWrite==%@",@(totalBytesExpectedToWrite));
}

- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    
    NSLog(@"cachedResponse==%@",cachedResponse);
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"[self.receiveData length]==%@",@([self.receiveData length]));
    
    if (self.CompleteBlock) {
        self.CompleteBlock(self.receiveData,nil);
    }
}

@end
