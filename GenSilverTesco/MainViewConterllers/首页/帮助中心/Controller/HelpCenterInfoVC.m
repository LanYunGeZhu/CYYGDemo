//
//  HelpCenterInfoVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "HelpCenterInfoVC.h"
#import "HelpCenterInfoCell.h"
@interface HelpCenterInfoVC ()

@end

@implementation HelpCenterInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:15px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",KSDIC(_data, @"content") ];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];

}

- (void)initTableView{
    self.title = @"帮助详情";
    [self registerTableVieCell:@"HelpCenterInfoCell"];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpCenterInfoCell *cell = (HelpCenterInfoCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.context.text =@"1.1本协议是VlP会员与杭州创盈易购科技有限公司之间关于用户成为创盈易购会员且使用易购用户所订立的协议 . 本协议描述了创盈易购软件许可以及服务使用及相关方面的权利义务 . 本服务协议构成您使用创盈易购商城之先决条件,除非您接收本协议条款 ,否则您无权使用本协议的相关服务 . 您的使用行为将视为同意接收本协议各项条款的约束.";
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [KSTool sizeWithTexte:@"1.1本协议是VlP会员与杭州创盈易购科技有限公司之间关于用户成为创盈易购会员且使用易购用户所订立的协议 . 本协议描述了创盈易购软件许可以及服务使用及相关方面的权利义务 . 本服务协议构成您使用创盈易购商城之先决条件,除非您接收本协议条款 ,否则您无权使用本协议的相关服务 . 您的使用行为将视为同意接收本协议各项条款的约束." font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 32, MAXFLOAT)];
    return ceil(size.height) + 53 +12;
}



@end
