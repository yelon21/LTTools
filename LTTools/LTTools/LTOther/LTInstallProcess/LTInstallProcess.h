//
//  LTInstallProcess.h
//  JSDemo
//
//  Created by yelon on 16/3/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTInstallProcess : NSObject

@property(nonatomic,assign) CGFloat progress;
@property(nonatomic,assign) UIColor *baseColor;

-(instancetype)initWithBaseView:(UIView *)baseView;

- (void)remove;
@end
