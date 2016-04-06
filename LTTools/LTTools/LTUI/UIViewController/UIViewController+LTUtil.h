//
//  UIViewController+LTUtil.h
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIBarButtonItem+LTItem.h"
#import "UIColor+LTCommon.h"

#import "UIImage+LTCommon.h"
#import "UIView+LTCommon.h"
#import "UIView+LTTransform.h"

@interface UIViewController (LTUtil)

- (void)lt_setNavBackItem;
- (void)lt_popToLastVC;

- (void)lt_setPresentedVCBackItem;
- (void)lt_dismissToLastVC;
@end
