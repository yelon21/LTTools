//
//  PickerViewController.h
//  YJNew
//
//  Created by yelon on 16/3/3.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate <NSObject>

- (void)pickerViewControllerDidSelect:(id)obj cancel:(BOOL)cancel;

@end
@interface PickerViewController : UIViewController

//@property(nonatomic,strong)void(^selectedObj)(BOOL cancel, id obj);
@property(nonatomic,assign)id<PickerViewControllerDelegate>delegate;
@property(nonatomic,assign)NSArray *itemArray;
@end
