//
//  LTContactsUtil.m
//
//
//  Created by yelon on 15/10/15.
//  Copyright © 2015年 Bison. All rights reserved.
//

#import "LTContactsUtil.h"

#import "LTContactStore.h"
#import "LTAddressBookStore.h"

#import <UIKit/UIKit.h>

@interface LTContactsUtil ()

@property(nonatomic,strong) LTContactsBase *store;
@end

@implementation LTContactsUtil

-(instancetype)init{

    if (self = [super init]) {
        
        
    }
    return self;
}

-(LTContactsBase *)store{

    if (!_store) {
        
        Class class = NSClassFromString(@"CNContactStore");
        
        if (class) {
            
            _store = [[LTContactStore alloc]init];
        }
        else{
            
            _store = [[LTAddressBookStore alloc]init];
        }
    }
    return _store;
}

-(NSMutableArray <LTContactsInfo *>*)allMobileNoArray{

    return self.store.allMobileNoArray;
}

-(NSMutableArray <LTContactsInfo *>*)contactsArray{

    return self.store.contactsArray;
}

+ (BOOL)LT_checkAuthorizationStatus{
    
    Class class = NSClassFromString(@"CNContactStore");
    
    if (class) {
        
        return [LTContactStore LT_checkAuthorizationStatus];
    }
    else{
        
        return [LTAddressBookStore LT_checkAuthorizationStatus];
    }
}
@end
