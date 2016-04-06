//
//  NSDateVC.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSDateVC.h"
#import "NSDate+LTFormatter.h"

@interface NSDateVC ()

@property(nonatomic,strong)UITextView *textView;

@end

@implementation NSDateVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = NSStringFromClass([self class]);
    
    self.textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [self setupContent];
}

- (void)setupContent{
    
    NSMutableString *string = [[NSMutableString alloc]init];
    
    NSDate *date = [NSDate date];
    
    [string appendFormat:@"date:\n%@\n\n",date];
    [string appendFormat:@"LT_currentDateString:\n%@\n\n",[NSDate LT_currentDateString]];
    
    [string appendFormat:@"LT_currentTimeString:\n%@\n\n",[NSDate LT_currentTimeString]];
    NSString *dateString = [date lt_dateString:@"yyyy-MM-dd HH:mm:ss"];
    [string appendFormat:@"lt_dateString:\n%@\n\n",dateString];
    NSDate *date2 = [NSDate LT_date:dateString formatter:@"yyyy-MM-dd HH:mm:ss"];
    [string appendFormat:@"LT_date:\n%@\n\n",date2];
    self.textView.text = string;
}


@end
