//
//  UIViewController+LTUtil.m
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "UIViewController+LTUtil.h"

@implementation UIViewController (LTUtil)

- (void)lt_setNavBackItem{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_item:@"nav_back"
                                                        highlight:nil
                                                           target:self
                                                              sel:@selector(lt_popToLastVC)];
}

- (void)lt_popToLastVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)lt_setPresentedVCBackItem{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_item:@"nav_close"
                                                           highlight:nil
                                                              target:self
                                                                 sel:@selector(lt_dismissToLastVC)];
}

- (void)lt_dismissToLastVC{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
