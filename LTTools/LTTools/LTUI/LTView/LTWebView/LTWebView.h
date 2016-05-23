//
//  LTWebView.h
//  YJNew
//
//  Created by yelon on 16/3/8.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol LTWebViewDelegate;

@interface LTWebView : UIView<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,assign,readonly) BOOL isWKWebView;
@property(nonatomic,readonly,assign,nullable) UIView *webView;
@property(nonatomic,readonly,strong,nullable) NSString *title;
@property(nonatomic,assign,nullable) id<LTWebViewDelegate>delegate;

@property (nullable, nonatomic, readonly, assign) NSURL *URL;
@property (nonnull, nonatomic, readonly, assign) UIScrollView *scrollView;

- (void)lt_loadUrl:(nonnull NSString *)urlString;
- (void)lt_loadRequest:(nonnull NSURLRequest *)request;
- (void)lt_loadHTMLString:(nonnull NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)lt_loadData:(nonnull NSData *)data
           MIMEType:(nullable NSString *)MIMEType
   textEncodingName:(nullable NSString *)textEncodingName
            baseURL:(nullable NSURL *)baseURL;


@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

- (void)lt_reload;
- (void)lt_stopLoading;

- (void)lt_goBack;
- (void)lt_goForward;

//@property (nonatomic) BOOL scalesPageToFit;
//@property (nonatomic) UIDataDetectorTypes dataDetectorTypes NS_AVAILABLE_IOS(3_0);

- (void)lt_evaluateJavaScript:(nonnull NSString *)javaScriptString completionHandler:(void (^ __nullable)(__nullable id response, NSError * __nullable error))completionHandler;

@end

@protocol LTWebViewDelegate <NSObject>

@optional
- (BOOL)ltwebView:(nonnull LTWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)ltwebViewDidStartLoad:(nonnull LTWebView *)webView;
- (void)ltwebViewDidFinishLoad:(nonnull LTWebView *)webView;
- (void)ltwebView:(nonnull LTWebView *)webView didFailLoadWithError:(nullable NSError *)error;

@end