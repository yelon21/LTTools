//
//  NSStringVC.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSStringVC.h"

#import "NSString+LTRex.h"

@interface NSStringVC ()

@property(nonatomic,strong)IBOutlet UITextView *textView;
@property(nonatomic,strong)IBOutlet UITextField *textField;
@end

@implementation NSStringVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = NSStringFromClass([self class]);
    
    self.textView.editable = NO;
    
    NSString *str = NSStringFromClass([self class]);
    [self setupContent:str];
}
- (IBAction)clickAction:(id)sender {
    
    [self setupContent:self.textField.text];
}

- (void)setupContent:(NSString *)str{

    NSMutableString *string = [[NSMutableString alloc]init];
    
    [string appendFormat:@"str:\n%@\n\n",str];
    [string appendFormat:@"lt_containNumber:\n%@\n\n",@([str lt_containNumber])];
    [string appendFormat:@"lt_containcUppercaseLetter:\n%@\n\n",@([str lt_containcUppercaseLetter])];
    [string appendFormat:@"lt_containcLowercaseLetter:\n%@\n\n",@([str lt_containcLowercaseLetter])];
    [string appendFormat:@"lt_vaidPassword:\n%@\n\n",@([str lt_vaidPassword])];
    [string appendFormat:@"lt_isBankCardNumber:\n%@\n\n",@([str lt_isBankCardNumber])];
    [string appendFormat:@"lt_isCardDate:\n%@\n\n",@([str lt_isCardDate])];
    [string appendFormat:@"lt_isPhoneNumberString:\n%@\n\n",@([str lt_isPhoneNumberString])];
    [string appendFormat:@"lt_isEmailString:\n%@\n\n",@([str lt_isEmailString])];
    
    [string appendFormat:@"lt_isIDCardNumber:\n%@\n\n",@([str lt_isIDCardNumber])];
    [string appendFormat:@"lt_isIDCardNumber15:\n%@\n\n",@([str lt_isIDCardNumber15])];
    [string appendFormat:@"lt_isIDCardNumber18:\n%@\n\n",@([str lt_isIDCardNumber18])];
    [string appendFormat:@"lt_isMathsNumber:\n%@\n\n",@([str lt_isMathsNumber])];
    [string appendFormat:@"lt_isMathsNumberIntegerString:\n%@\n\n",@([str lt_isMathsNumberIntegerString])];
    [string appendFormat:@"lt_isNumberString:\n%@\n\n",@([str lt_isNumberString])];
    [string appendFormat:@"lt_isIpString:\n%@\n\n",@([str lt_isIpString])];
    self.textView.text = string;
}

@end
