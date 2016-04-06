//
//  UIView+LTCommon.h
//  Pods
//
//  Created by yelon on 15/7/21.
//
//

#import <UIKit/UIKit.h>

@interface UIView (LTCommon)

@property(nonatomic,assign) CGFloat ltWidth;
@property(nonatomic,assign) CGFloat ltHeight;

- (void)lt_setCornerRadius:(CGFloat)radius;
- (void)lt_setBorder:(CGFloat)borderWidth color:(UIColor *)color;
@end
