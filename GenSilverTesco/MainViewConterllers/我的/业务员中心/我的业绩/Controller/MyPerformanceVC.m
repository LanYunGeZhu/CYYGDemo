//
//  MyPerformanceVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/31.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyPerformanceVC.h"
#import "MyPerformanceCell.h"
#import "AmountCell.h"
#import "MyPerformanceModel.h"
@interface MyPerformanceVC ()
@property (strong, nonatomic) id data;
@end

@implementation MyPerformanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self addMjRefresh];
    [self loadRequsetData:0];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
//    [self loadRequsetData:0];
}

- (void)loadRequsetData:(NSInteger)index{
    //    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:index == 0 ? URL_yw_index :URL_yw_stats parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":@"0"} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if (index == 0) {
            self.data = responseObject;
            [self loadRequsetData:1];
        }
        else{
            [self.datasMutabArray addObjectsFromArray:[MyPerformanceModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
            [self.myTableView reloadData];
            [self endRefresh];

        }
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"我的业绩";
    [self  registerTableVieCellsArray:@[@"AmountCell",@"MyPerformanceCell"]];
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
            cell.monthOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"m_money")];
            cell.yearsOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"t_money")];
            
        }
        return cell;
    }else{
        MyPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPerformanceCell" forIndexPath:indexPath];
        cell.my_model = self.datasMutabArray[indexPath.section - 1];
        return  cell;
    }
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ?50 : 140.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}
@end
