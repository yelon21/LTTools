//
//  LTAddressBookSelect.h
//  ABContacts
//
//  Created by yelon on 16/3/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTAddressBookSelect : NSObject

+ (BOOL)checkAuthorizationStatus;

- (void)showAddressBookUIFromVC:(UIViewController *)viewCon
                              didSelect:(void(^)(NSString *name,NSArray *tels))didSelectPerson;
@end
