//
//  LTLoadingView.m
//  SdkDemo
//
//  Created by yelon on 16/1/15.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTLoadingView.h"

@interface LTLoadingView (){

    UIActivityIndicatorView *indicatorView;
    UILabel *messageLabel;
}

@end


@implementation LTLoadingView

- (instancetype)init{

    if (self = [self initWithFrame:[[UIScreen mainScreen]bounds]]) {
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
        
        indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:indicatorView];
        indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [indicatorView startAnimating];
        
        messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:18.0];
        messageLabel.numberOfLines = 5;
        messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:messageLabel];
        
        UIView *superV = self;
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                           attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:superV
                                                           attribute:NSLayoutAttributeCenterY
                                                          multiplier:1.0
                                                            constant:-100]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:superV
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:indicatorView
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1.0
                                                            constant:0]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:indicatorView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:20]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:superV
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:50]];
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:superV
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:-50]];
    }
    return self;
}

- (void)startAnimating{

    [indicatorView startAnimating];
}
- (void)stopAnimating{

    [indicatorView stopAnimating];
}

-(void)setDetailMessage:(NSString *)detailMessage{

    messageLabel.text = detailMessage;
    CGSize size = messageLabel.frame.size;
    size.height = 200;
    [messageLabel sizeThatFits:size];
}

@end
