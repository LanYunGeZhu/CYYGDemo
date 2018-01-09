//
//  WebViewController.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/2.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url_string]]];
    
//    [self.webView loadHTMLString:_url_string baseURL:nil];
//    [self loadRequsetData];
//    
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
//    
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    
//    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkWebConfig];
//    _webView.UIDelegate = self;
//    _webView.navigationDelegate = self;
//    [self.view addSubview:_webView];
//    

}

- (NSString *)reSizeImageWithHTML:(NSString *)html {
    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", Screen_wide - 20, html];
}



-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)"
              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                  if (!error) {
                      NSNumber *height = result;
                      
                      NSLog(@"----%@",height);
//                      self.footerWeiView.frame = CGRectMake(0, 0, Screen_wide,[height floatValue]);
//                      self.webView.frame = self.footerWeiView.frame;
//                      
//                      NSLog(@"---%@----%@",NSStringFromCGRect(self.footerWeiView.frame),NSStringFromCGRect(self.footerWeiView.frame));
//                      [self.myTableView reloadData];
//                      
//                      [MBProgressHUD hideHUD];
//                      [MBProgressHUD showTipMessageInWindow:@"加载成功"];
                  }
              }];
    
    
    
}


- (void)loadRequsetData{
//    [KSRequestManager postRequestWithUrlString:URL_newslists parameter:@{@"ntype":@(2),@"page":@(1),@"size":@(200)} success:^(id responseObject) {
//        NSLog(@"---%@",responseObject);
//        id data = KSDIC(responseObject, @"lists")[3];
//            [self.webView loadHTMLString:KSDIC(data,@"content") baseURL:nil];
//
//    } failure:^(id error) {
//        
//    }];
    [KSRequestManager postRequestWithUrlString:URL_goods_info parameter:@{@"goods_id":@"433",@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        
//        NSLog(@"---%@",responseObject);
//        _model = [GoodsDetailsModel whc_ModelWithJson:responseObject];
//        _model.goods.isSelect_num = 1; //默认设置为 1件
//        _data = responseObject;
//        self.pageView.isWebImage = YES;
//        
//        self.pageView.imageArray = [PageModel whc_ModelWithJson:responseObject keyPath:@"ads"];
//        [self loadHtmlString];
//        self.collectionButton.selected = [_model.goods.iscollect boolValue];
//        NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
//                                "<head> \n"
//                                "<style type=\"text/css\"> \n"
//                                "body {font-size:15px;}\n"
//                                "</style> \n"
//                                "</head> \n"
//                                "<body>"
//                                "<script type='text/javascript'>"
//                                "window.onload = function(){\n"
//                                "var $img = document.getElementsByTagName('img');\n"
//                                "for(var p in  $img){\n"
//                                " $img[p].style.width = '100%%';\n"
//                                "$img[p].style.height ='auto'\n"
//                                "}\n"
//                                "}"
//                                "</script>%@"
//                                "</body>"
//                                "</html>",KSDIC(KSDIC(responseObject, @"goods"),@"goods_desc") ];
        
        [self.webView loadHTMLString: [ self reSizeImageWithHTML:KSDIC(KSDIC(responseObject, @"goods"),@"goods_desc")] baseURL:nil];

    } failure:^(id error) {
        
    }];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue]+20 ;
    NSLog(@"---%f",height);

}
@end
