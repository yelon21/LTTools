//
//  LTContactsUIUtil.h
//  ABContacts
//
//  Created by yelon on 16/3/14.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTContactsUIUtil : NSObject

@property(nonatomic,assign) BOOL telOnlyNumber;

+ (BOOL)checkAuthorizationStatus;

- (void)showAddressBookUIFromVC:(UIViewController *)viewCon
                      didSelect:(void(^)(NSString *name,NSString *tel))didSelectPerson;
@end
