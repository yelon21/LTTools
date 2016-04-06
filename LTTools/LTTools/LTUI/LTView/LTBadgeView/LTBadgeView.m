//
//  LTBadgeView.m
//  YJNew
//
//  Created by yelon on 16/3/16.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTBadgeView.h"

@interface LTBadgeView ()

@property(nonatomic,strong) UILabel *badgeLabel;
@end

@implementation LTBadgeView

-(instancetype)init{

    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.badgeLabel = [[UILabel alloc]init];
        self.badgeLabel.font = [UIFont boldSystemFontOfSize:10.0];
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeLabel.layer.borderWidth = 1.5;
        
        
        self.badgeColor = [UIColor redColor];
        self.badge = @"";
        self.badgeTextColor = [UIColor whiteColor];
        
//        self.badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIView *superView = self;
        [superView addSubview:self.badgeLabel];
        
//        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeLabel
//                                                              attribute:NSLayoutAttributeTop
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:superView
//                                                              attribute:NSLayoutAttributeTop
//                                                             multiplier:1.0
//                                                               constant:-5]];
//        
//        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeLabel
//                                                              attribute:NSLayoutAttributeRight
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:superView
//                                                              attribute:NSLayoutAttributeRight
//                                                             multiplier:1.0
//                                                               constant:5]];
        
    }
    return self;
}

-(void)setBadge:(NSString *)badge{

    self.badgeLabel.text = badge;
    if ([self.badgeLabel.text length]==0) {
        
        self.badgeLabel.hidden = YES;
    }
    else{
    
        self.badgeLabel.hidden = NO;
        [self.badgeLabel sizeToFit];
        
        CGRect rect = self.badgeLabel.frame;
        rect.size.height += 5;
        rect.size.width += 5;
        self.badgeLabel.frame = rect;
        
        CGFloat height = CGRectGetHeight(self.badgeLabel.bounds);
        CGFloat width = CGRectGetWidth(self.badgeLabel.bounds);
        
        self.badgeLabel.center = CGPointMake(CGRectGetWidth(self.bounds)-5, 5);
        
        CGFloat radius = MIN(height,width)/2.0;
        
        self.badgeLabel.layer.cornerRadius = radius;
        self.badgeLabel.layer.masksToBounds = YES;
    }
}

-(void)setBadgeColor:(UIColor *)badgeColor{

    self.badgeLabel.backgroundColor = badgeColor;
}

-(void)setBadgeTextColor:(UIColor *)badgeTextColor{

    self.badgeLabel.textColor = badgeTextColor;
    self.badgeLabel.layer.borderColor = badgeTextColor.CGColor;
    
}
@end
