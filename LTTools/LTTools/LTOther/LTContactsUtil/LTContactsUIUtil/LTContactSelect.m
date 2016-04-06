//
//  LTContactSelect.m
//  ABContacts
//
//  Created by yelon on 16/3/14.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTContactSelect.h"
#import <ContactsUI/ContactsUI.h>

@interface LTContactSelect ()<CNContactPickerDelegate>

@property(nonatomic,strong) void (^didSelectPerson)(NSString *name,NSArray *tels);

@end

@implementation LTContactSelect

+ (BOOL)checkAuthorizationStatus{

    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    return status == CNAuthorizationStatusAuthorized;
}

- (void)showAddressBookUIFromVC:(UIViewController *)viewCon didSelect:(void(^)(NSString *name,NSArray *tels))didSelectPerson{
    
    self.didSelectPerson = didSelectPerson;
    
    CNContactPickerViewController *pickerViewController = [[CNContactPickerViewController alloc]init];
    pickerViewController.displayedPropertyKeys = @[CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactMiddleNameKey,CNContactFamilyNameKey];
    pickerViewController.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count > 0"];
    pickerViewController.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count == 1"];
    pickerViewController.delegate = self;
    [viewCon presentViewController:pickerViewController animated:YES completion:nil];
}

#pragma mark CNContactPickerDelegate
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}

/*!
 * @abstract Singular delegate methods.
 * @discussion These delegate methods will be invoked when the user selects a single contact or property.
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    NSString *fullName = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    
    NSArray *phones = contact.phoneNumbers;
    
    if ([phones count]>0) {
        
        CNLabeledValue *value = [phones firstObject];
        CNPhoneNumber *phoneNumber = value.value;
        NSString *phone = phoneNumber.stringValue;
        
        NSLog(@"%@=%@",fullName,phone);
        
        if (self.didSelectPerson) {
            
            self.didSelectPerson(fullName,@[phone]);
        }
    }else {
    
        if (self.didSelectPerson) {
            
            self.didSelectPerson(fullName,[NSArray array]);
        }
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    CNContact *contact = contactProperty.contact;
    
    NSString *fullName = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString *phone = phoneNumber.stringValue;
    
    NSLog(@"%@=%@",fullName,phone);
    
    if (self.didSelectPerson) {
        
        self.didSelectPerson(fullName,@[phone]);
    }
}

/*!
 * @abstract Plural delegate methods.
 * @discussion These delegate methods will be invoked when the user is done selecting multiple contacts or properties.
 * Implementing one of these methods will configure the picker for multi-selection.
 */
//- (void)contactPicker:(CNContactPickerViewController *)picker
//    didSelectContacts:(NSArray<CNContact*> *)contacts{
//
//    if ([contacts count]>0) {
//
//        CNContact *contact = [contacts firstObject];
//        NSArray *phones = contact.phoneNumbers;
//        if ([phones count]>0) {
//
//            CNLabeledValue *value = [phones firstObject];
//            NSLog(@"label=%@",value.label);
//            if ([value.label isEqualToString:@"_$!<Mobile>!$_"]) {
//                CNPhoneNumber *number = value.value;
//                NSLog(@"number=%@",number.stringValue);
//            }
//        }
//    }
//
//}
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
//
//    CNContactProperty *contactProperty = [contactProperties firstObject];
//
//}


@end
