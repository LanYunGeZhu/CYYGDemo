//
//  StoreManagementVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "StoreManagementVC.h"
#import "StoreManagementCell.h"
#import "UploadTheMerchantsVC.h"
#import "MakePaymentCodeVC.h"
#import "StoreManagementModel.h"
@interface StoreManagementVC ()

@end

@implementation StoreManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    [self setRightWithString:@"添加店铺" action:@selector(addStore)];
}

- (void)addStore{
    
    WeakSelf
    UploadTheMerchantsVC *upload = [UploadTheMerchantsVC new];
    upload.isyw = 2;
    upload.updataSuccess = ^{
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    [self.navigationController pushViewController:upload animated:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:YES];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_my_shops parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject)
        ;
        [self.datasMutabArray addObjectsFromArray:[StoreManagementModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {

    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"StoreManagementCell"];
    self.base_CellHeight = 91;
    self.title = @"店铺管理";
  
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreManagementCell *cell = (StoreManagementCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.makePaymentCode addTarget:self action:@selector(makePaymentCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.makePaymentCode.tag = indexPath.section;
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01;
}

- (void)makePaymentCodeClick:(UIButton *)sende{
    MakePaymentCodeVC *make = [MakePaymentCodeVC new];
    StoreManagementModel *model = self.datasMutabArray[sende.tag];
    make.store_Id = model.iD;
    make.store_Name= model.shop_name;
    [self.navigationController pushViewController:make animated:YES];
}

@end
