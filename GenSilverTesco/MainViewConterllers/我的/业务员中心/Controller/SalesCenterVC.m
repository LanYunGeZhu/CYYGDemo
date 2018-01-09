//
//  SalesCenterVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SalesCenterVC.h"
#import "SalesHeaderCell.h"
#import "AmountCell.h"
#import "SalesListCell.h"
#import "UploadTheMerchantsVC.h"
#import "SalesListModel.h"
#import "MyPerformanceVC.h"
@interface SalesCenterVC ()
@property (strong, nonatomic) id salesData;
@end

@implementation SalesCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self getSalesInfo];
}

- (void)getSalesInfo{
    [KSRequestManager postRequestWithUrlString:URL_yw_index parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        self.salesData = responseObject;
//        [self.myTableView reloadData];
        [self loadRequsetData];

    } failure:^(id error) {
        
    }];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_yw_shops parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"status":@"-1",@"page":@(self.page),@"size":@(self.size) } success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[SalesListModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"业务员中心";
    [self registerTableVieCellsArray:@[@"SalesHeaderCell",@"AmountCell",@"SalesListCell"]];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count +2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SalesHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesHeaderCell" forIndexPath:indexPath];
        cell.data = self.salesData;
        return cell;
    }else if (indexPath.section ==1){
        AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmountCell" forIndexPath:indexPath];
        cell.monthOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_salesData, @"m_money")];
        cell.yearsOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_salesData, @"t_money")];
        cell.baseCell_buttonIndex = ^(NSInteger index){
            if (index == 0) {
                MyPerformanceVC *perforamnce=  [MyPerformanceVC new];
                [self.navigationController pushViewController:perforamnce animated:YES];
            }else{
                UploadTheMerchantsVC *upload = [UploadTheMerchantsVC new];
                upload.isyw = 1;
                [self.navigationController pushViewController:upload animated:YES];
 
            }

        };
        return cell;
    }else{
        SalesListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesListCell" forIndexPath:indexPath];
        cell.model =self.datasMutabArray[indexPath.section - 2];
        return cell;
    }
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60.0f;
    }else if (indexPath.section ==1){
        return 95.0f;
    }else{
        return 124;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01;
}



@end
