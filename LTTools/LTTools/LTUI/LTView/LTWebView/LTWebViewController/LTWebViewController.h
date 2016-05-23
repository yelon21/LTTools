//
//  LTWebViewController.h
//  LTTools
//
//  Created by yelon on 16/4/27.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTWebView.h"

@interface LTWebViewController : UIViewController<LTWebViewDelegate>{
    
    
}
@property(strong,nonatomic) LTWebView *webView;

- (void)lt_reload;
- (void)lt_loadUrl:(NSString *)urlStr;
- (void)lt_loadHtml:(NSString *)html;
@end
