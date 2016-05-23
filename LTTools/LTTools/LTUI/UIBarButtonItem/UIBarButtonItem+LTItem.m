//
//  UIBarButtonItem+Item.m
//  YJPay
//
//  Created by yelon on 15/5/11.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "UIBarButtonItem+LTItem.h"

@implementation UIBarButtonItem (LTItem)

+(UIBarButtonItem *)LT_item:(NSString *)imageName
               highlight:(NSString *)imageNameH
                  target:(NSObject *)target
                     sel:(SEL)sel{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
//    btn.backgroundColor = [UIColor blackColor];

    [btn setImage:[UIImage imageNamed:imageName]
         forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:imageNameH]
//                   forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+(UIBarButtonItem *)LT_itemImage:(UIImage *)image
                  highlight:(UIImage *)imageH
                     target:(NSObject *)target
                        sel:(SEL)sel{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    //    btn.backgroundColor = [UIColor blackColor];
    
    [btn setImage:image
         forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:imageNameH]
    //                   forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+(UIBarButtonItem *)LT_item:(NSString *)title
                   color:(UIColor *)titleColor
                  target:(NSObject *)target
                     sel:(SEL)sel{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btn setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    else{
    
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}


@end
