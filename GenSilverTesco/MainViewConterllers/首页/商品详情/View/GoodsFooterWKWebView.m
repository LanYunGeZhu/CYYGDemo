//
//  GoodsFooterWKWebView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/29.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsFooterWKWebView.h"

@implementation GoodsFooterWKWebView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        NSString *jScript = @"var meta = document.createElement('meta'); \
        meta.name = 'viewport'; \
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
        var head = document.getElementsByTagName('head')[0];\
        head.appendChild(meta);";
        /**
         *
         var meta = document.createElement('meta'); \
         meta.name = 'viewport'; \
         meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
         var head = document.getElementsByTagName('head')[0];\
         head.appendChild(meta)
         */
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        
        wkWebConfig.userContentController = wkUController;
        
        
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:wkWebConfig];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
        [self addSubview:_webView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.webView.frame = self.bounds;
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)"
              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                  if (!error) {
                      NSNumber *height = result;
                      
                      NSLog(@"----%@",height);
                      if (_didFinishNavigation) {
                          _didFinishNavigation([height floatValue]);
                      }
                  }
              }];
}


- (void)setHetmlString:(NSString *)hetmlString{
    [ self.webView loadHTMLString:[self reSizeImageWithHTML:hetmlString] baseURL:nil];

}

- (NSString *)reSizeImageWithHTML:(NSString *)html {
    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", Screen_wide , html];
}

- (void)dealloc{
    self.webView = nil;
    self.webView.scrollView.delegate = nil;
}
@end
