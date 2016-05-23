//
//  UIBarButtonItem+Item.h
//  YJPay
//
//  Created by yelon on 15/5/11.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LTItem)

+(UIBarButtonItem *)LT_item:(NSString *)imageName
               highlight:(NSString *)imageNameH
                  target:(NSObject *)target
                     sel:(SEL)sel;

+(UIBarButtonItem *)LT_itemImage:(UIImage *)image
                       highlight:(UIImage *)imageH
                          target:(NSObject *)target
                             sel:(SEL)sel;

+(UIBarButtonItem *)LT_item:(NSString *)title
                   color:(UIColor *)titleColor
                  target:(NSObject *)target
                     sel:(SEL)sel;
@end
