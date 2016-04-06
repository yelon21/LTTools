//
//  LTTitleActivityView.h
//  YJNew
//
//  Created by yelon on 16/1/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTTitleActivityView : UIView

@property(nonatomic,assign) UIColor *frontColor;
@property(nonatomic,assign) NSString *title;

- (void)stopAnimating;
- (void)startAnimating;

@end
