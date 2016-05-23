//
//  LTWebView.m
//  YJNew
//
//  Created by yelon on 16/3/8.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTWebView.h"

@interface LTWebView ()

@property(nonatomic,strong) UIWebView *webViewUI;
@property(nonatomic,strong) WKWebView *webViewWK;
@property(nonatomic,readwrite,strong,nullable) NSString *title;

@property(nonatomic,strong) UIScrollView *rootScrollView;
@property(nonatomic,assign) BOOL preLoad;
@end

@implementation LTWebView

-(instancetype)init{
    
    if (self = [self initWithFrame:CGRectZero]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {

    return [self initWithFrame:frame preLoad:NO];
}

-(instancetype)initWithFrame:(CGRect)frame preLoad:(BOOL)preLoad{
    
    if (self = [super initWithFrame:frame]) {
        
        self.preLoad = preLoad;
        
        if (self.preLoad) {
            
            self.rootScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
            [self addSubview:self.rootScrollView];
            [self.rootScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        }
        
        self.title = @"";
        Class wkClass = NSClassFromString(@"WKWebView");
        if (wkClass) {
            _isWKWebView = YES;
            [self initWKWebView];
        }
        else{
            
            _isWKWebView = NO;
            [self initUIWebView];
        }
    }
    return self;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    [super setBackgroundColor:backgroundColor];
    
    if (self.isWKWebView) {
        
        self.webViewWK.backgroundColor = backgroundColor;
    }
    else{
        
        self.webViewUI.backgroundColor = backgroundColor;
    }
}
//初始化
- (void)initWKWebView{
    
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    
    configuration.preferences = [[WKPreferences alloc]init];
    configuration.userContentController = [[WKUserContentController alloc]init];
    
    self.webViewWK = [[WKWebView alloc]initWithFrame:self.bounds
                                       configuration:configuration];
    self.webViewWK.UIDelegate = self;
    self.webViewWK.navigationDelegate = self;
    
    UIView *superView = self;
    if (self.rootScrollView) {
        superView = self.rootScrollView;
    }
    [superView addSubview:self.webViewWK];
    self.webViewWK.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.webViewWK.scrollView.bounces = YES;
}

- (void)initUIWebView{
    
    self.webViewUI = [[UIWebView alloc]initWithFrame:self.bounds];
    self.webViewUI.delegate = self;
    UIView *superView = self;
    if (self.rootScrollView) {
        superView = self.rootScrollView;
    }
    [superView addSubview:self.webViewUI];
    self.webViewUI.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.webViewUI.scrollView.bounces = YES;
}
// 成员方法
-(UIView *)webView{
    
    if (self.isWKWebView) {
        
        return self.webViewWK;
    }
    else{
        
        return self.webViewUI;
    }
}
//加载
- (void)lt_loadUrl:(NSString *)urlString{
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (!url) {
        
        return;
    }
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [self lt_loadRequest:request];
}

-(void)lt_loadRequest:(NSURLRequest *)request{
    
    if (self.isWKWebView) {
        
        [self.webViewWK loadRequest:request];
    }
    else {
        
        [self.webViewUI loadRequest:request];
    }
}

-(void)lt_loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{
    
    if (self.isWKWebView) {
        
        [self.webViewWK loadHTMLString:string baseURL:baseURL];
    }
    else {
        
        [self.webViewUI loadHTMLString:string baseURL:baseURL];
    }
}

-(void)lt_loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL{
    
    if (self.isWKWebView) {
        
        if ([self.webViewWK respondsToSelector:@selector(loadData:MIMEType:characterEncodingName:baseURL:)]) {//9.0
            
            [self.webViewWK loadData:data MIMEType:MIMEType characterEncodingName:textEncodingName baseURL:baseURL];
        }
    }
    else {
        
        [self.webViewUI loadData:data MIMEType:MIMEType textEncodingName:textEncodingName baseURL:baseURL];
    }
}
//属性 readonly
-(NSURL *)URL{
    
    if (self.isWKWebView) {
        
        return self.webViewWK.URL;
    }
    else{
        
        return self.webViewUI.request.URL;
    }
}
-(UIScrollView *)scrollView{
    
    if (self.isWKWebView) {
        
        return self.webViewWK.scrollView;
    }
    else{
        
        return self.webViewUI.scrollView;
    }
}

-(BOOL)canGoBack{
    
    if (self.isWKWebView) {
        
        return self.webViewWK.canGoBack;
    }
    else{
        
        return self.webViewUI.canGoBack;
    }
}

-(BOOL)canGoForward{
    
    if (self.isWKWebView) {
        
        return self.webViewWK.canGoForward;
    }
    else{
        
        return self.webViewUI.canGoForward;
    }
}

-(BOOL)isLoading{
    
    if (self.isWKWebView) {
        
        return self.webViewWK.isLoading;
    }
    else{
        
        return self.webViewUI.isLoading;
    }
}

- (void)lt_reload{
    
    if (self.isWKWebView) {
        
        [self.webViewWK reloadFromOrigin];
    }
    else{
        
        [self.webViewUI reload];
    }
}
- (void)lt_stopLoading{
    
    if (self.isWKWebView) {
        
        [self.webViewWK stopLoading];
    }
    else{
        
        [self.webViewUI stopLoading];
    }
}

- (void)lt_goBack{
    
    if (self.isWKWebView) {
        
        [self.webViewWK goBack];
    }
    else{
        
        [self.webViewUI goBack];
    }
}
- (void)lt_goForward{
    
    if (self.isWKWebView) {
        
        [self.webViewWK goForward];
    }
    else{
        
        [self.webViewUI goForward];
    }
}
//
-(void)lt_evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id _Nullable data, NSError * _Nullable))completionHandler{
    
    if (self.isWKWebView) {
        
        [self.webViewWK evaluateJavaScript:javaScriptString
                         completionHandler:completionHandler];
    }
    else{
        
        NSString *result = [self.webViewUI stringByEvaluatingJavaScriptFromString:javaScriptString];
        if (completionHandler) {
            completionHandler(result,nil);
        }
    }
}
#pragma mark LTWebViewDelegate
- (void)lt_webViewDidStartLoad:(UIView *)webView {
    
    if ([self.delegate respondsToSelector:@selector(ltwebViewDidStartLoad:)]) {
        
        [self.delegate ltwebViewDidStartLoad:self];
    }
}

- (void)lt_webViewDidFinishLoad:(UIView *)webView {
    
    if ([self.delegate respondsToSelector:@selector(ltwebViewDidFinishLoad:)]) {
        
        [self.delegate ltwebViewDidFinishLoad:self];
    }
    
    if (self.rootScrollView&&self.preLoad) {
        
        __weak typeof(self)weakSelf = self;
        [self lt_evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id  _Nullable response, NSError * _Nullable error) {
            
            double width = CGRectGetWidth(weakSelf.rootScrollView.bounds);
            
            double height = [response doubleValue];
            
            [weakSelf.rootScrollView setContentSize:CGSizeMake(width, height)];
            CGRect rect = CGRectMake(0.0, 0.0, width, height);
            weakSelf.webView.frame = rect;
        }];
    }
}

- (BOOL)lt_webView:(UIView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([self.delegate respondsToSelector:@selector(ltwebView:shouldStartLoadWithRequest:navigationType:)]) {
        
        return [self.delegate ltwebView:self
             shouldStartLoadWithRequest:request
                         navigationType:navigationType];
    }
    return YES;
}

- (void)lt_webView:(UIView *)webView didFailLoadWithError:(nullable NSError *)error{
    
    if ([self.delegate respondsToSelector:@selector(ltwebView:didFailLoadWithError:)]) {
        
        [self.delegate ltwebView:self didFailLoadWithError:error];
    }
}
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [self lt_webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // 禁用用户选择
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [self lt_webViewDidFinishLoad:webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return [self lt_webView:webView
 shouldStartLoadWithRequest:request
             navigationType:navigationType];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
    [self lt_webView:webView didFailLoadWithError:error];
}

#pragma mark- WKNavigationDelegate
/*! @abstract 决定是否允许或者取消一个navigationAction
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"决定是否允许=%@",navigationAction.request);
    BOOL allow = [self lt_webView:webView
       shouldStartLoadWithRequest:navigationAction.request
                   navigationType:(NSInteger)navigationAction.navigationType];
    decisionHandler(allow);
}

/*! @abstract 判定在获取确定响应后是否允许导航
 @discussion 如果你不实现,如果webview能够显示， webview将允许响应.
 */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}

/*! @abstract 开始加载
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"开始加载");
    [self lt_webViewDidStartLoad:webView];
}

/*! @abstract 接收到重定向
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"接收到重定向");
}

/*! @abstract 加载失败
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"加载失败");
    [self lt_webView:webView didFailLoadWithError:error];
}

/*! @abstract 开始接收数据
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"开始接收数据");
}

/*! @abstract 加载完成
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    NSLog(@"加载完成");
    self.title = webView.title;
    
    [self lt_webViewDidFinishLoad:webView];
}

/*! @abstract 错误发生.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"error==%@",error);
    [self lt_webView:webView didFailLoadWithError:error];
}

/*! @abstract webview 需要证书校验
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
//
//    NSLog(@"需要证书校验");
//}

/*! @abstract webview 内容处理终止
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    
    NSLog(@"内容处理终止");
}

#pragma mark- WKUIDelegate

/*! @abstract 创建新的webview
 @param webView The web view invoking the delegate method.
 @param configuration The configuration to use when creating the new web
 view.
 @param navigationAction The navigation action causing the new web view to
 be created.
 @param windowFeatures Window features requested by the webpage.
 @result A new web view or nil.
 @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
 
 If you do not implement this method, the web view will cancel the navigation.
 */
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//
//}

/*! @abstract Notifies your app that the DOM window object's close() method completed successfully.
 @discussion Your app should remove the web view from the view hierarchy and update
 the UI as needed, such as by closing the containing browser tab or window.
 调用 关闭页面
 */
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    
    NSLog(@"关闭页面");
}

/*! @abstract 显示js alert
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this
 call.
 @param completionHandler The completion handler to call after the alert
 panel has been dismissed.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have a single OK button.
 
 If you do not implement this method, the web view will behave as if the user selected the OK button.
 */

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"message=%@",message);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
        completionHandler();
    }];
    
    [alert addAction:action];
    
    UIViewController *viewCon = (UIViewController *)self.delegate;
    if (![viewCon isKindOfClass:[UIViewController class]]) {
        
        viewCon = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    if (viewCon.presentedViewController) {
        
        completionHandler();
    }
    else{
    
        [viewCon presentViewController:alert animated:YES completion:nil];
    }
}

/*! @abstract 显示js confirm
 
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(NO);
    }];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(YES);
    }];
    
    [alert addAction:actionCancel];
    [alert addAction:actionConfirm];
    
    UIViewController *viewCon = (UIViewController *)self.delegate;
    if (![viewCon isKindOfClass:[UIViewController class]]) {
        
        viewCon = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    [viewCon presentViewController:alert animated:YES completion:nil];
}

/*! @abstract 显示js input panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param defaultText The initial text to display in the text entry field.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the text
 input panel has been dismissed. Pass the entered text if the user chose
 OK, otherwise nil.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel, and a field in
 which to enter text.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:prompt
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(nil);
    }];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *input = ((UITextField *)alert.textFields.firstObject).text;
        completionHandler(input);
    }];
    
    [alert addAction:actionCancel];
    [alert addAction:actionConfirm];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = defaultText;
        textField.secureTextEntry = ([prompt rangeOfString:@"密码"].location != NSNotFound || [defaultText rangeOfString:@"密码"].location != NSNotFound);
    }];
    
    UIViewController *viewCon = (UIViewController *)self.delegate;
    if (![viewCon isKindOfClass:[UIViewController class]]) {
        
        viewCon = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    [viewCon presentViewController:alert animated:YES completion:nil];
}


@end
