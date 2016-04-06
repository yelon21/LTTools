//
//  LTAddressBookSelect.m
//  ABContacts
//
//  Created by yelon on 16/3/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTAddressBookSelect.h"
#import <AddressBookUI/AddressBookUI.h>

@interface LTAddressBookSelect ()<ABPeoplePickerNavigationControllerDelegate>

@property(nonatomic,strong) void (^didSelectPerson)(NSString *name,NSArray *tels);
@end

@implementation LTAddressBookSelect

+ (BOOL)checkAuthorizationStatus{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        
        if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {

            return NO;
        }
    }
    return YES;
}

- (void)showAddressBookUIFromVC:(UIViewController *)viewCon didSelect:(void(^)(NSString *name,NSArray *tels))didSelectPerson{

    self.didSelectPerson = didSelectPerson;
    
    ABPeoplePickerNavigationController *picker =[[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    picker.displayedProperties = @[@(kABPersonPhoneProperty)];
    if ([picker respondsToSelector:@selector(setPredicateForEnablingPerson:)]) {
        
        picker.predicateForEnablingPerson = [NSPredicate predicateWithFormat:@"phoneNumbers.@count > 0"];
    }
    if ([picker respondsToSelector:@selector(setPredicateForSelectionOfPerson:)]) {
        
        picker.predicateForSelectionOfPerson = [NSPredicate predicateWithFormat:@"phoneNumbers.@count == 1"];
    }

    [viewCon presentViewController:picker
                       animated:YES
                     completion:nil];
}

//
- (void)didSelectPerson:(ABRecordRef)person{
    
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
    NSString *name = nameString;
    
    ABPropertyID multiProperties[] = {
        kABPersonPhoneProperty
    };
    
    NSMutableArray *tels = [[NSMutableArray alloc] init];
    
    NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
    
    for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
        
        ABPropertyID property = multiProperties[j];
        ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
        NSInteger valuesCount = 0;
        if (valuesRef != nil){
            
            valuesCount = ABMultiValueGetCount(valuesRef);
        }
        else{
            
            if (self.didSelectPerson) {
                
                self.didSelectPerson(nil,nil);
            }
            
            return;
        }
        
        if (valuesCount == 0) {
            CFRelease(valuesRef);
            continue;
        }
        //获取电话号码和email
        
        for (NSInteger k = 0; k < valuesCount; k++) {
            
            CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
            
            switch (j) {
                case 0: {// Phone number
                    NSString *tel = [[(__bridge NSString*)value stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                    NSLog(@"tel=%@",tel);
                    [tels addObject:tel];
                    break;
                }
                case 1: {// Email
                    NSString *email = (__bridge NSString*)value;
                    NSLog(@"email=%@",email);
                    break;
                }
            }
            CFRelease(value);
        }
        CFRelease(valuesRef);
    }
    
    NSLog(@"tels=%@",tels);
    
    if (abName) CFRelease(abName);
    if (abLastName) CFRelease(abLastName);
    if (abFullName) CFRelease(abFullName);
    
    if (self.didSelectPerson) {
        
        self.didSelectPerson(name,tels);
    }
}

#pragma mark ABPeoplePickerNavigationControllerDelegate
// Called after a person has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker
                         didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0){
    
    [self didSelectPerson:person];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

// Called after a property has been selected by the user.
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker
//                         didSelectPerson:(ABRecordRef)person
//                                property:(ABPropertyID)property
//                              identifier:(ABMultiValueIdentifier)identifier NS_AVAILABLE_IOS(8_0){
//    
//    [self didSelectPerson:person];
//}

// Called after the user has pressed cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消");
}


// Deprecated, use predicateForSelectionOfPerson and/or -peoplePickerNavigationController:didSelectPerson: instead.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0){
    
    [self didSelectPerson:person];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

// Deprecated, use predicateForSelectionOfProperty and/or -peoplePickerNavigationController:didSelectPerson:property:identifier: instead.
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
//      shouldContinueAfterSelectingPerson:(ABRecordRef)person
//                                property:(ABPropertyID)property
//                              identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0){
//    
//    return NO;
//}

@end
