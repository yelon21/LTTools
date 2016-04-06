//
//  LTContactsUtil.h
//
//
//  Created by yelon on 15/10/15.
//  Copyright © 2015年 Bison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface LTContactsUtil : NSObject

@property (nonatomic, assign) NSMutableArray *contactsArray;
@property (nonatomic, assign) NSMutableArray *allMobileNoArray;

-(NSMutableArray *)getContacts;

-(void)sendSMSMessage:(NSString *)message
          phoneNumber:(NSString *)phoneNumber
             delegate:(id<MFMessageComposeViewControllerDelegate>)delegate;

-(void)sendSMSMessage:(NSString *)message
         phoneNumbers:(NSArray *)phoneNumbers
             delegate:(id<MFMessageComposeViewControllerDelegate>)delegate;

+ (BOOL)LT_checkAuthorizationStatus;
@end

@interface ContactsInfo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSArray *emails;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSArray *tels;

@property NSInteger sectionNumber;
@property NSInteger recordID;

@end
