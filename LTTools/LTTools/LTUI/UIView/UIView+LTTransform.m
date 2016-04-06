//
//  UIView+LTTransform.m
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "UIView+LTTransform.h"

@implementation UIView (LTTransform)

- (void)lt_resetTransform{

    [self lt_resetTransform:NO];
}

- (void)lt_resetTransform:(BOOL)animated{

    [self lt_resetTransform:animated completion:nil];
}

- (void)lt_resetTransform:(BOOL)animated
               completion:(void (^ __nullable)(BOOL finished))completion{

    [self lt_setTransform:CGAffineTransformIdentity
                 animated:animated
               completion:completion];
}

- (void)lt_setTransform:(CGAffineTransform)transform
               animated:(BOOL)animated{

    [self lt_setTransform:transform
                 animated:animated
               completion:nil];
}

- (void)lt_setTransform:(CGAffineTransform)transform
                 animated:(BOOL)animated
               completion:(void (^ __nullable)(BOOL finished))completion{
    
    [UIView animateWithDuration:animated?0.35:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         
                         if (completion) {
                             
                             completion(finished);
                         }
                     }];
}

- (void)lt_setAlpha:(CGFloat)alpha
           animated:(BOOL)animated{

    [self lt_setAlpha:alpha animated:animated completion:nil];
}

- (void)lt_setAlpha:(CGFloat)alpha
               animated:(BOOL)animated
             completion:(void (^ __nullable)(BOOL finished))completion{
    
    [UIView animateWithDuration:animated?0.75:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.alpha = alpha;
                     }
                     completion:^(BOOL finished) {
                         
                         if (completion) {
                             
                             completion(finished);
                         }
                     }];
}

@end
