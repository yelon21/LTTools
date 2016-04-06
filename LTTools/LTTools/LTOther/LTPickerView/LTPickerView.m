//
//  LTPickerView.m
//  YJNew
//
//  Created by yelon on 16/3/2.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTPickerView.h"
#import "PickerViewController.h"
#import "UIView+LTTransform.h"

@interface LTPickerView ()<PickerViewControllerDelegate>

@property(nonatomic,strong)void(^selectedBlock)(BOOL cancel,id obj);
@property(nonatomic,strong)PickerViewController *pickerVC;
@property(nonatomic,strong)UINavigationController *pickerNav;
@end

@implementation LTPickerView

+ (instancetype)showPickerViewInView:(UIView *)inView
                 sourceArray:(NSArray *)sourceArray
                    selected:(void(^)(BOOL cancel,id obj))selectedBlock{

    LTPickerView *pickerView = [[LTPickerView alloc]initWithSuperView:inView];
    pickerView.selectedBlock = selectedBlock;
    [pickerView showWithItemArray:sourceArray];
    return pickerView;
}

-(instancetype)initWithSuperView:(UIView *)superView{

    if (self = [self initWithFrame:superView.bounds]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [superView addSubview:self];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0]];

        [self initPickerVC];
    }
    return self;
}

- (void)initPickerVC{

    if (self.pickerVC) {
        
        return;
    }
    self.pickerVC = [[PickerViewController alloc] init];
    self.pickerVC.delegate = self;
    self.pickerNav = [[UINavigationController alloc]initWithRootViewController:self.pickerVC];
    self.pickerNav.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *superView = self;
    [superView addSubview:self.pickerNav.view];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:260.0]];
    
    [self moveOutPickerVC];
}

- (void)moveOutPickerVC{

    [self.pickerNav.view lt_setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(self.bounds))
                        animated:NO];
    [self lt_setAlpha:0.0 animated:NO];
}

- (void)moveInPickerVC{
    
    [self lt_setAlpha:1.0 animated:NO];
    
    [self.pickerNav.view lt_resetTransform:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self pickerViewControllerDidSelect:nil cancel:YES];
}

- (void)hidePickerVC{
    
    [self.pickerNav.view lt_setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(self.bounds))
                                animated:YES
                              completion:^(BOOL finished) {
                                  
                                  [self removeFromSuperview];
                              }];
//    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.75];
    
}

-(void)pickerViewControllerDidSelect:(id)obj cancel:(BOOL)cancel{

    if (self.selectedBlock) {
        self.selectedBlock(cancel,obj);
    }
    [self hidePickerVC];
}

- (void)showWithItemArray:(NSArray *)itemArray{

    self.pickerVC.itemArray = itemArray;
    
    [self moveInPickerVC];
}

@end
