//
//  GoodsFooterWKWebView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/29.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface GoodsFooterWKWebView : UIView<WKNavigationDelegate,WKUIDelegate>
/** */
@property (strong, nonatomic) WKWebView *webView;

/** */
@property (strong, nonatomic) NSString * hetmlString;

/** */
@property (copy, nonatomic) void(^didFinishNavigation)(CGFloat height);



@end
