//
//  DemoWebViewController.m
//  LTTools
//
//  Created by yelon on 16/4/27.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "DemoWebViewController.h"
#import "LTWebViewVCTest.h"

@interface DemoWebViewController ()

@end

@implementation DemoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LTWebViewVCTest *VC = [[LTWebViewVCTest alloc] init];
    [VC lt_loadUrl:@"http://wx2.yjpal.com/community/queryChatMessages.do?resource=app&userinfo.shopCode=S00002&userinfo.appCode=ios"];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
