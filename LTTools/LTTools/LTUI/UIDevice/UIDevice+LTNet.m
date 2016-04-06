//
//  UIDevice+LTNet.m
//  YJBM
//
//  Created by yelon on 15/12/7.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "UIDevice+LTNet.h"

#import "NSString+LTJson.h"
#import "NSString+LTRex.h"
//local
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
//#import <socket>
#import <objc/runtime.h>

@implementation UIDevice (LTNet)
static void *ltIPaddress = "lt_IPaddress";
//static NSString *ip = @"0.0.0.0";
static NSDate *refreshDate = nil;

static dispatch_queue_t ip_operation_readwrite_queue() {
    static dispatch_queue_t lt_ip_readwrite_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lt_ip_readwrite_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    });
    return lt_ip_readwrite_queue;
}

+(void)load{

//    ip = @"0.0.0.0";
    
    refreshDate = [NSDate distantPast];
    [[UIDevice currentDevice] lt_setLTIPaddress:nil];
    
    [UIDevice LT_setIpStringTB];
}

- (void)lt_setLTIPaddress:(NSString *)address{

    if (!address) {
        
        address = @"0.0.0.0";
    }
    else{
    
        refreshDate = [NSDate date];
    }
    objc_setAssociatedObject(self, ltIPaddress, address, OBJC_ASSOCIATION_RETAIN);
}
- (NSString *)ltIPaddress{
    
    NSString *ipAddress = objc_getAssociatedObject(self, ltIPaddress);
    if (!ipAddress||![ipAddress lt_isIpString]) {
        
        ipAddress = @"0.0.0.0";
    }
    return ipAddress;
}
//从ip138获取ip
+ (void)LT_setIpString138{

    dispatch_barrier_async(ip_operation_readwrite_queue(), ^{
        NSError *error = nil;
        NSURL *ipURL = [NSURL URLWithString:@"http://1111.ip138.com/ic.asp"];
        NSString *html = [[NSString alloc]initWithContentsOfURL:ipURL
                                                       encoding:NSASCIIStringEncoding error:&error];
        if (!error&&[html length]>0) {
            
            NSString *reg = @"\\d{1,3}(.\\d{1,3}){3}";
            
            NSRegularExpression *regex = [NSRegularExpression
                                          regularExpressionWithPattern:reg
                                          options:0
                                          error:&error];
            
            if (!error) { // 如果没有错误
                // 获取特特定字符串的范围
                NSTextCheckingResult *match = [regex firstMatchInString:html
                                                                options:0
                                                                  range:NSMakeRange(0, [html length])];
                if (match) {
                    // 截获特定的字符串
                    NSString *result = [html substringWithRange:match.range];
                    //                NSLog(@"%@",result);
//                    ip = result;
//                    refreshDate = [NSDate date];
                    [[UIDevice currentDevice]lt_setLTIPaddress:result];
                    NSLog(@"138更新时间");
                }
            } else { // 如果有错误，则把错误打印出来
                NSLog(@"error - %@", error);
            }
        }
    });
}
//从taobao.com获取ip
+ (void)LT_setIpStringTB{

    dispatch_barrier_async(ip_operation_readwrite_queue(), ^{
        
        NSString *urlString = @"http://ip.taobao.com/service/getIpInfo.php?ip=myip";
        
        NSError *error = nil;
        NSString *ipJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
//        NSString *ipString = @"0.0.0.0";
        if (error||!ipJson) {

            NSLog(@"error==%@",error);
        }
        NSDictionary *dic = [ipJson lt_jsonObject];
//        NSLog(@"dic==%@",dic);
        NSInteger code = [dic[@"code"] integerValue];
        
        if (code == 0) {
            
            NSString *ipString = dic[@"data"][@"ip"];
            if (ipString&&[ipString isKindOfClass:[NSString class]]){
            
                if ([ipString lt_isIpString]) {
                    
                    refreshDate = [NSDate date];
                    NSLog(@"TB更新时间");
                    [[UIDevice currentDevice]lt_setLTIPaddress:ipString];
                }

            }
        }
    });
}
//读取ip
+ (NSString *)LT_getIpString{

    __block NSString *ipString;
    dispatch_sync(ip_operation_readwrite_queue(), ^{
        
        ipString = [[UIDevice currentDevice]ltIPaddress];
    });
    return ipString;
}
//读取ip
+(NSString *)LT_ipWWWAddress{
    
    NSString *ip = [UIDevice LT_getIpString];
    if (!ip||![ip isKindOfClass:[NSString class]]||[ip isEqualToString:@"0.0.0.0"]) {
        
        [UIDevice LT_setIpStringTB];
        return @"0.0.0.0";
    }
    NSTimeInterval delt = [refreshDate timeIntervalSinceNow];
//    NSLog(@"timeIntervalSinceNow== %@",@(delt));
    if (delt<-10.0*60) {
        
        [UIDevice LT_setIpStringTB];
    }
    NSLog(@"lt_getLocalAddress==%@",[UIDevice LT_localWiFiIPAddress]);
    return ip;
}
//本地ip
+ (NSString *)LT_getLocalAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
//            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]
                   || [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en1"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
//本地无线ip
+ (NSString *)LT_localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}
@end
