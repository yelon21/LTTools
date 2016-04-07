//
//  LTContactsBase.h
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTContactsInfo.h"

@interface LTContactsBase : NSObject

@property (nonatomic, assign) NSMutableArray <LTContactsInfo *> *contactsArray;
@property (nonatomic, assign) NSMutableArray <LTContactsInfo *> *allMobileNoArray;

//- (NSMutableArray <ContactsInfo *>*)getContacts;

+ (BOOL)LT_checkAuthorizationStatus;

@end
