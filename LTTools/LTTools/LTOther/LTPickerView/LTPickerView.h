//
//  LTPickerView.h
//  YJNew
//
//  Created by yelon on 16/3/2.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPickerView : UIView

+ (instancetype)showPickerViewInView:(UIView *)inView
                         sourceArray:(NSArray *)sourceArray
                            selected:(void(^)(BOOL cancel,id obj))selectedBlock;

@end
