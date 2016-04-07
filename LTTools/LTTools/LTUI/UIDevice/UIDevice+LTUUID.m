//
//  UIDevice+LTUUID.m
//  YJQB
//
//  Created by yelon on 15/12/2.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "UIDevice+LTUUID.h"
#import <SSKeychain.h>

@implementation UIDevice (LTUUID)

+ (NSString *)LT_appUUID{
    
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *retrieveuuid = [SSKeychain passwordForService:bundleId
                                                    account:@"_uuid"];
    if (retrieveuuid == nil || [retrieveuuid isEqualToString:@""]){
        
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        retrieveuuid = [NSString stringWithFormat:@"%@", uuidStr];
        CFRelease(uuidStr);
        [SSKeychain setPassword:retrieveuuid
                     forService:bundleId
                        account:@"_uuid"];
    }
    
    return retrieveuuid;
}
@end
