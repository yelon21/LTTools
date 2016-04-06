//
//  LTAlertView.h
//  DeviceDemo
//
//  Created by yelon on 16/1/8.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LTAlertView : NSObject

- (nullable instancetype)initWithAlertType:(BOOL)isAlert
                                     title:(nullable NSString *)title
                                   message:(nullable NSString *)message
                         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                         otherButtonTitles:(nullable NSArray *)otherButtonTitles;

- (nullable NSString *)showAlert;
- (nullable NSString *)showAlertFromVC:(nonnull UIViewController *)fromVC;
@end
