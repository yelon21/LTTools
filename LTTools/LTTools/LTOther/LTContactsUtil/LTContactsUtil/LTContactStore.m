//
//  LTContactStore.m
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTContactStore.h"
#import <Contacts/Contacts.h>

@interface LTContactStore ()

@property (nonatomic, strong) NSMutableArray *personArray;
@end

@implementation LTContactStore

-(NSMutableArray <LTContactsInfo *>*)allMobileNoArray{
    
    NSMutableArray *mobileNos = [NSMutableArray array];
    
    NSArray *allContacts = [self contactsArray];
    
    for (LTContactsInfo *info in allContacts) {
        
        for (NSString *phone in info.tels) {
            
            LTContactsInfo *contactsInfo = [[LTContactsInfo alloc] init];
            contactsInfo.tel = phone;
            contactsInfo.name = info.name;
            
            [mobileNos addObject:contactsInfo];
        }
        
    }
    return mobileNos;
}

-(NSMutableArray <LTContactsInfo *>*)contactsArray{
    
    if (self.personArray) {
        
        return self.personArray;
    }
    else{
        
        return [self getContacts];
    }
}

- (NSMutableArray <LTContactsInfo *>*)getContacts{

    if (self.personArray == nil) {
        
        self.personArray = [NSMutableArray array];
    }
    
    NSArray *keys = @[CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactFamilyNameKey];
    
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keys];
    
    NSError *error;
    
    CNContactStore *contactStore = [[CNContactStore alloc]init];
    
    BOOL succeed = [contactStore enumerateContactsWithFetchRequest:request
                                                   error:&error
                                              usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                
                                                  LTContactsInfo *info = [[LTContactsInfo alloc]init];
                                                  
                                                  NSString *fullName = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
                                                  
                                                  info.name = fullName;
                                                  
                                                  NSArray *phones = contact.phoneNumbers;
                                                  
                                                  NSMutableArray *tels = [[NSMutableArray alloc] init];
                                                  
                                                  for(CNLabeledValue *value in phones) {
                                                      
                                                      CNPhoneNumber *phoneNumber = value.value;
                                                      NSString *phone = phoneNumber.stringValue;
                                                      
                                                      [tels addObject:phone];
                                                  }
                                                  
                                                  info.tels = tels;
                                                  
                                                  [self.personArray addObject:info];
                                              }];
    
    if (!succeed || error) {
        
        NSLog(@"error=%@",error);
    }
    return self.personArray;
}

+(BOOL)LT_checkAuthorizationStatus{

    return [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized;
}
@end
