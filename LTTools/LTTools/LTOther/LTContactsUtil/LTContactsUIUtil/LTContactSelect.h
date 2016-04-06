//
//  LTContactSelect.h
//  ABContacts
//
//  Created by yelon on 16/3/14.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTContactSelect : NSObject

+ (BOOL)checkAuthorizationStatus;
    
- (void)showAddressBookUIFromVC:(UIViewController *)viewCon
                      didSelect:(void(^)(NSString *name,NSArray *tels))didSelectPerson;
@end
