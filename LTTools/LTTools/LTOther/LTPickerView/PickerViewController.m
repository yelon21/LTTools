//
//  PickerViewController.m
//  YJNew
//
//  Created by yelon on 16/3/3.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "PickerViewController.h"
#import "UIBarButtonItem+LTItem.h"

@interface PickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{

    UIPickerView *dataPickerView;
    NSMutableArray *listArray;
    NSInteger selectedRow;
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_item:@"nav_close"
                                                           highlight:nil
                                                              target:self
                                                                 sel:@selector(leftAction)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem LT_item:@"确定"
                                                                color:[UIColor whiteColor]
                                                               target:self
                                                                  sel:@selector(rightAction)];
    
    UIView *superView = self.view;
    
    dataPickerView = [UIPickerView new];
    dataPickerView.backgroundColor = [UIColor whiteColor];
    dataPickerView.delegate     = self;
    dataPickerView.dataSource   = self;
    dataPickerView.showsSelectionIndicator = YES;
    dataPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:dataPickerView];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
}

- (void)leftAction{

//    if (self.selectedObj) {
//        
//        self.selectedObj(YES,nil);
//    }
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidSelect:cancel:)]) {
        
        [self.delegate pickerViewControllerDidSelect:nil cancel:YES];
    }
}
- (void)rightAction{
    
//    self.selectedObj(NO,listArray[selectedRow]);
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidSelect:cancel:)]) {
        
        [self.delegate pickerViewControllerDidSelect:listArray[selectedRow] cancel:NO];
    }
}

-(void)setItemArray:(NSArray *)itemArray{

    if (!listArray) {
        
        listArray = [[NSMutableArray alloc]init];
    }
    [listArray setArray:itemArray];
    [dataPickerView reloadAllComponents];
}

#pragma mark ================================
#pragma mark pickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [listArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return listArray[row][@"title"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    selectedRow = row;
}

@end
