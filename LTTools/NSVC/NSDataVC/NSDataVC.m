//
//  NSDataVC.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSDataVC.h"

#import "NSData+LTCommon.h"

@interface NSDataVC ()

@property(nonatomic,strong)UITextView *textView;

@end

@implementation NSDataVC

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

    NSString *sourceString = NSStringFromClass([self class]);
    
    NSData *sourceData = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc]init];
    
    [string appendFormat:@"sourceString:\n%@\n\n",sourceString];
    [string appendFormat:@"sourceData:\n%@\n\n",sourceData];
    
    [string appendFormat:@"lt_stringValueUTF8:\n%@\n\n",[sourceData lt_stringValueUTF8]];
    [string appendFormat:@"lt_MD5:\n%@\n\n",[sourceData lt_MD5]];
    [string appendFormat:@"lt_SHA1:\n%@\n\n",[sourceData lt_SHA1]];
    [string appendFormat:@"lt_SHA224:\n%@\n\n",[sourceData lt_SHA224]];
    [string appendFormat:@"lt_SHA226:\n%@\n\n",[sourceData lt_SHA226]];
    [string appendFormat:@"lt_SHA384:\n%@\n\n",[sourceData lt_SHA384]];
    [string appendFormat:@"lt_SHA512:\n%@\n\n",[sourceData lt_SHA512]];
    self.textView.text = string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
