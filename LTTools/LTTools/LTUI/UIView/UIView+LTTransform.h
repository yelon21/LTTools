//
//  UIView+LTTransform.h
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTTransform)

- (void)lt_resetTransform;

- (void)lt_resetTransform:(BOOL)animated;

- (void)lt_resetTransform:(BOOL)animated
               completion:(void (^ __nullable)(BOOL finished))completion;

- (void)lt_setTransform:(CGAffineTransform)transform
               animated:(BOOL)animated;

- (void)lt_setTransform:(CGAffineTransform)transform
               animated:(BOOL)animated
             completion:(void (^ __nullable)(BOOL finished))completion;

- (void)lt_setAlpha:(CGFloat)alpha
           animated:(BOOL)animated;

- (void)lt_setAlpha:(CGFloat)alpha
           animated:(BOOL)animated
         completion:(void (^ __nullable)(BOOL finished))completion;
@end
