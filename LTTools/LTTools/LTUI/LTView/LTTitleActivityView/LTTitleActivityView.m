//
//  LTTitleActivityView.m
//  YJNew
//
//  Created by yelon on 16/1/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTTitleActivityView.h"

@interface LTTitleActivityView (){

    UIActivityIndicatorView *indicatorView;
    UILabel *titleLabel;
}

@end

@implementation LTTitleActivityView

-(instancetype)init{

    if (self = [self initWithFrame:CGRectMake(0.0, 0.0, 220.0, 40.0)]) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initElements:self];
    }
    return self;
}

- (void)initElements:(UIView *)superV{

    indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.frame = CGRectMake(0.0, 10, 20, 20);
    indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [superV addSubview:indicatorView];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(25, 0, CGRectGetWidth(self.bounds)-25, 40);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [superV addSubview:titleLabel];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:superV
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:titleLabel
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1.0
                                                        constant:0]];
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:superV
                                                       attribute:NSLayoutAttributeCenterX
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:titleLabel
                                                       attribute:NSLayoutAttributeCenterX
                                                      multiplier:1.0
                                                        constant:0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:titleLabel
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1.0
                                                        constant:0]];
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:titleLabel
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:-10]];
}

-(void)setFrontColor:(UIColor *)frontColor{

    indicatorView.color = frontColor;
    titleLabel.textColor = frontColor;
}

-(void)setTitle:(NSString *)title{

    titleLabel.text = title;
    [titleLabel sizeToFit];
}

- (void)stopAnimating{

    if (indicatorView.isAnimating) {
        
        [indicatorView stopAnimating];
    }
}

- (void)startAnimating{
    
    [indicatorView startAnimating];
}

@end
