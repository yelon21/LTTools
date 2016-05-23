//
//  LTWebViewController.m
//  LTTools
//
//  Created by yelon on 16/4/27.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTWebViewController.h"
#import "UIBarButtonItem+LTItem.h"

@interface LTWebViewController ()

@end

@implementation LTWebViewController

-(instancetype)init{

    if (self = [super init]) {
        
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [self initElements];
    }
    return self;
}

- (void)initElements{

    UIView *superView = self.view;
    [superView addSubview:self.webView];
}

-(LTWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[LTWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return _webView;
}

- (void)updateBarItems{

    NSMutableArray *items = [NSMutableArray array];
    
    UIBarButtonItem *backItem = [UIBarButtonItem LT_item:@"back"
                                               highlight:nil
                                                  target:self
                                                     sel:@selector(lt_goBack)];
    [items addObject:backItem];
    
    if ([self.webView canGoBack]) {
        
        UIBarButtonItem *closeItem = [UIBarButtonItem LT_item:@"关闭"
                                                       color:[UIColor blueColor]
                                                      target:self
                                                         sel:@selector(closeToBack)];
        [items addObject:closeItem];
    }
    self.navigationItem.leftBarButtonItems = items;
}

- (void)closeToBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)lt_goBack{
    
    if ([self.webView canGoBack]) {
        
        [self.webView lt_goBack];
    }
    else{
    
        [self closeToBack];
    }
}

-(void)lt_reload{

    [self.webView lt_reload];
}

- (void)lt_loadUrl:(NSString *)urlStr{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"url==%@",url);
    if (url) {
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        [self.webView lt_loadRequest:request];
    }
}

-(void)lt_loadHtml:(NSString *)html{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.webView lt_loadHTMLString:html baseURL:nil];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateBarItems];
}
- (void)setNetworkActivityIndicatorVisible:(BOOL)visible{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
}
#pragma mark LTWebViewDelegate
-(void)ltwebViewDidStartLoad:(LTWebView *)webView{
    
    [self setNetworkActivityIndicatorVisible:YES];
}
-(void)ltwebViewDidFinishLoad:(LTWebView *)webView{
    
    [self setNetworkActivityIndicatorVisible:NO];
    [self updateBarItems];
    
    [webView lt_evaluateJavaScript:@"document.title"
                 completionHandler:^(id  _Nullable response, NSError * _Nullable error) {
                     NSLog(@"document.title==%@",response);
                     self.navigationItem.title = response;
                 }];
}

-(BOOL)ltwebView:(LTWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
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
    
    [self setNetworkActivityIndicatorVisible:NO];
    [self updateBarItems];
    NSLog(@"error==%@",error);
}

@end
