//
//  LTContactsInfo.m
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTContactsInfo.h"

@implementation LTContactsInfo

-(instancetype)init{
    
    if (self = [super init]) {
        
        self.name   = @"";
        self.tel    = @"";
        self.tels   = @[];
        self.email  = @"";
        self.emails = @[];
    }
    return self;
}
@end
