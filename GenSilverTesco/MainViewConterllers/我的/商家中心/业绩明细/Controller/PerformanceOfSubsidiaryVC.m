//
//  PerformanceOfSubsidiaryVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PerformanceOfSubsidiaryVC.h"
#import "AmountCell.h"
#import "PerformanceListCell.h"
#import "PerformanceOfSubsidiaryModel.h"
@interface PerformanceOfSubsidiaryVC ()
@property (strong, nonatomic) id data;
@end

@implementation PerformanceOfSubsidiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_shoperstats parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[PerformanceOfSubsidiaryModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        self.data = responseObject;
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"业绩明细";
    [self  registerTableVieCellsArray:@[@"AmountCell",@"PerformanceListCell"]];
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
       
            cell.monthOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"rlotal")];

            cell.yearsOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"total")];

        }
        return cell;
    }else{
        PerformanceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerformanceListCell" forIndexPath:indexPath];
        cell.model = self.datasMutabArray[indexPath.section - 1];
        return  cell;
    }
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ?50 : 95.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}



@end
