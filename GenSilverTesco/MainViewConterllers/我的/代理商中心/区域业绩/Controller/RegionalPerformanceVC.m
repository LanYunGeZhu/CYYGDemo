//
//  RegionalPerformanceVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalPerformanceVC.h"
#import "RegionalPerformanceCell.h"
#import "AmountCell.h"
#import "PerformanceOfSubsidiaryModel.h"
#import "ShopOrderRecordVC.h"
@interface RegionalPerformanceVC ()
@property (strong, nonatomic) id data ;

@end

@implementation RegionalPerformanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    if (self.salesId) {
        self.title = @"业务员业绩";
    }
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}
- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_agentstats parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"saler":_salesId?_salesId:@"0",@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[RegionalPerformanceModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        self.data = responseObject;
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];

}


- (void)initTableView{
    self.title = @"区域业绩查询";
    [self registerTableVieCell:@"RegionalPerformanceCell"];
    [self registerTableVieCellsArray:@[@"AmountCell"]];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmountCell" forIndexPath:indexPath];
        cell.bgView.hidden = YES;
        if (_data) {
            cell.monthOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"mrl")];
            cell.yearsOnGold.text =[NSString stringWithFormat:@"%@", KSDIC(_data, @"trl")];
        }
        return cell;
    }else{
        WeakSelf
        RegionalPerformanceCell *cell = (RegionalPerformanceCell *) [super tableView:tableView cellForRowAtIndexPath:indexPath];
        cell.model = self.datasMutabArray[indexPath.section -1];
        if (self.salesId) {
            cell.longTap = ^(RegionalPerformanceCell *cell ){
                [weakSelf longTapClick:cell];
            };

        }
        
        return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ?50 : 124.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    ShopOrderRecordVC *shipOrder = [ShopOrderRecordVC new];
    PerformanceOfSubsidiaryModel *model  = self.datasMutabArray[indexPath.section -1]
    ;
    shipOrder.iD = model.iD;
    [self.navigationController pushViewController:shipOrder animated:YES];
    
    /*
     *
     //        // 删除；
    */
}

- (void)longTapClick:(RegionalPerformanceCell *)cell{
    


        [KSTool alertViewWithController:self title:nil message:nil items:@[@"解除业务员关系"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
            if (indx == 0) {
                NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
                [MBProgressHUD showActivityMessageInWindow:@"正在取消..."];
                PerformanceOfSubsidiaryModel * model = self.datasMutabArray[indexPath.section -1];
                [KSRequestManager postRequestWithUrlString:URL_cancelyw parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":model.iD} success:^(id responseObject) {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showTipMessageInWindow:@"操作成功"];
                    [self base_RefreshHeaderFooter:YES];
                } failure:^(id error) {
                    
                }];
            }
        }];
        
    
}



@end
