//
//  HelpCenterVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "HelpCenterVC.h"
#import "HelpCenterCell.h"
#import "HelpCenterInfoVC.h"
#import "WebViewController.h"
@interface HelpCenterVC ()

@end

@implementation HelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.isSecondary == NO) {
        [self loadRequsetData];

    }
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_get_help parameter:@{} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:responseObject[@"lists"]];
        [self.myTableView reloadData];
        
    } failure:^(id error) {
        
    }];
//    if (self.isSecondary) {
//        self.datasMutabArray = @[@"账户注册",@"购物流程",@"入驻流程",@"WX积分兑换"];
//
//    }else{
//        self.datasMutabArray = @[@"帮助与指南",@"支付方式",@"配送与售后"];
//    }
}

- (void)initTableView{
    if (self.isSecondary == NO) {
        self.title = @"帮助中心";

    }
    [self registerTableVieCell:@"HelpCenterCell"];
    self.base_CellHeight = 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpCenterCell *cell = (HelpCenterCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (self.isSecondary == NO) {
        cell.name.text = self.datasMutabArray[indexPath.row][@"cat_name"];

    }
    else{
        cell.name.text = self.datasMutabArray[indexPath.row][@"title"];

    }
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isSecondary) {
        /** 二级页面*/
        HelpCenterVC *center = [HelpCenterVC new];
        center.datasMutabArray = self.datasMutabArray[indexPath.row][@"articles"];
        center.title = self.datasMutabArray[indexPath.row][@"cat_name"];
        center.isSecondary = YES;
        [self.navigationController pushViewController:center animated:YES];
    }else{
        /** 详细信息*/
        HelpCenterInfoVC * info = [HelpCenterInfoVC new];
        info.data = self.datasMutabArray[indexPath.row];
        [self.navigationController pushViewController:info animated:YES];
    }
   
}



@end
