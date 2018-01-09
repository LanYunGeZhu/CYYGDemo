//
//  AboutUsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    
    _webview.scrollView.bounces = NO;
    //（www.cyyg111.com）http://www.cyyg111.com/wxaboutus.php
    NSURL *url = [NSURL URLWithString:@"http://www.cyyg111.com/wxaboutus.php?isapp=1"];
    [_webview loadRequest:[NSURLRequest requestWithURL:url]];
}


@end
