//
//  ContactsUIUtilVC.m
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "ContactsUIUtilVC.h"

#import "LTContactsUIUtil.h"

@interface ContactsUIUtilVC ()

@property(nonatomic,strong) LTContactsUIUtil *contactsUIUtil;
@end

@implementation ContactsUIUtilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(LTContactsUIUtil *)contactsUIUtil{

    if (!_contactsUIUtil) {
        
        _contactsUIUtil = [[LTContactsUIUtil alloc]init];
    }
    return _contactsUIUtil;
}

- (IBAction)contactClick:(id)sender {

    self.contactsUIUtil.telOnlyNumber = YES;
    
    [self.contactsUIUtil showAddressBookUIFromVC:self
                                  didSelect:^(NSString *name, NSString *tel) {
                                      
                                      NSLog(@"name=%@",name);
                                      NSLog(@"tel=%@",tel);
                                  }];
}

@end
