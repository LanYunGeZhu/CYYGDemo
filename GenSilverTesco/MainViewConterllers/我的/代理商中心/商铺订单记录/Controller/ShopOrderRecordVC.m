//
//  ShopOrderRecordVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShopOrderRecordVC.h"
#import "ShopOrderRecordCell.h"
#import "ShopOrderRecordModel.h"
@interface ShopOrderRecordVC ()

@end

@implementation ShopOrderRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//        [super loadRequsetData];
//    self.iD = @"1760";
    [KSRequestManager postRequestWithUrlString:URL_agent_sjorders parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size),@"shop_id":self.iD} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[ShopOrderRecordModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"商铺订单记录";
    [self registerTableVieCell:@"ShopOrderRecordCell"];
    self.base_CellHeight = 156;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopOrderRecordCell *cell = (ShopOrderRecordCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

@end
