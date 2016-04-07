//
//  LTAddressBookStore.m
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTAddressBookStore.h"
#import <AddressBook/AddressBook.h>

#import <UIKit/UIKit.h>

@interface LTAddressBookStore ()

@property (nonatomic, strong) NSMutableArray *personArray;

@end

@implementation LTAddressBookStore

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
-(NSMutableArray <LTContactsInfo *>*)getContacts
{
    
    if (self.personArray == nil) {
        self.personArray = [NSMutableArray array];
    }
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        //获取通讯录权限
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
            
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else{
        
        addressBooks = ABAddressBookCreate();
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        LTContactsInfo *contactsInfo = [[LTContactsInfo alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            
            nameString = (__bridge NSString *)abFullName;
        }
        else {
            
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        contactsInfo.name = nameString;
        //        contactsInfo.recordID = (int)ABRecordGetRecordID(person);
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        
        NSMutableArray *tels = [[NSMutableArray alloc] init];
        NSMutableArray *emails = [[NSMutableArray array] init];
        
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            
            for (NSInteger k = 0; k < valuesCount; k++) {
                
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                
                switch (j) {
                    case 0: {// Phone number
                        contactsInfo.tel = [[(__bridge NSString*)value stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                        [tels addObject:contactsInfo.tel];
                        break;
                    }
                    case 1: {// Email
                        contactsInfo.email = (__bridge NSString*)value;
                        [emails addObject:contactsInfo.email];
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        contactsInfo.tels = tels;
        contactsInfo.emails = emails;
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [self.personArray addObject:contactsInfo];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        
    }
    
    return self.personArray;
}

+ (BOOL)LT_checkAuthorizationStatus{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        
        if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
            
            return NO;
        }
    }
    return YES;
}
@end
