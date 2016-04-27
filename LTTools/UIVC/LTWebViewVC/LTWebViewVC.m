//
//  LTWebViewVC.m
//  LTTools
//
//  Created by yelon on 16/4/26.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTWebViewVC.h"
#import "LTWebView.h"

@interface LTWebViewVC ()<LTWebViewDelegate>{

    LTWebView *ltwebView;
}

@end

@implementation LTWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    ltwebView = [[LTWebView alloc]initWithFrame:self.view.bounds];
    ltwebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:ltwebView];
    
    [ltwebView lt_loadUrl:@"http://localhost:63342/Dangmian/www/demo/test.html"];
}

#pragma mark LTWebViewDelegate
-(void)ltwebViewDidStartLoad:(LTWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

-(void)ltwebViewDidFinishLoad:(LTWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(BOOL)ltwebView:(LTWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
  navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL *url = [request URL];
    NSString *absoluteString = [url absoluteString];
    NSLog(@"absoluteString == %@",absoluteString);
    
    if ([absoluteString hasPrefix:@"http://itunes.apple.com"]) {
        
        [[UIApplication sharedApplication]openURL:url];
        return NO;
    }
   
    return YES;
}

-(void)ltwebView:(LTWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSLog(@"error==%@",error);
    NSLog(@"localizedFailureReason==%@",error.localizedFailureReason);
    NSLog(@"localizedDescription==%@",error.localizedDescription);
    NSLog(@"localizedRecoverySuggestion==%@",error.localizedRecoverySuggestion);
    NSLog(@"localizedRecoveryOptions==%@",error.localizedRecoveryOptions);
    NSLog(@"helpAnchor==%@",error.helpAnchor);
}
@end
