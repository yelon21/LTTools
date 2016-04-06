//
//  LTLoadingView.h
//  SdkDemo
//
//  Created by yelon on 16/1/15.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLoadingView : UIView

@property(nonatomic,assign)NSString *detailMessage;

- (void)startAnimating;
- (void)stopAnimating;

@end
