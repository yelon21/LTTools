//
//  PickerViewVC.m
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "PickerViewVC.h"
#import "LTPickerView.h"

@interface PickerViewVC ()

@end


@implementation PickerViewVC

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [LTPickerView showPickerViewInView:self.navigationController.view
                           sourceArray:@[@{@"title":@"名称1",
                                           @"value":@"000",@"image":@"eeee"},
  @{@"title":@"名称2",@"value":@"000",@"image":@"eeee"},
  @{@"title":@"名称3",@"value":@"000",@"image":@"eeee"}]
                              selected:^(BOOL cancel, id obj) {
                                  
                                  NSLog(@"%@-%@",@(cancel),obj);
                              }];
}
@end
