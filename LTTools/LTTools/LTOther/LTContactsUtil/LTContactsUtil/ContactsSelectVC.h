//
//  ContactsSelectVC.h
//  YJNew
//
//  Created by yelon on 16/3/1.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ContactsSelectVC : BaseViewController

@property(nonatomic,strong) void(^mobileNoSelectedBlock)(NSString *mobileNo);

+ (void)presentFrom:(UIViewController *)vc selectedContactMobileNo:(void(^)(NSString *mobileNo))mobileNoBlock;
@end
