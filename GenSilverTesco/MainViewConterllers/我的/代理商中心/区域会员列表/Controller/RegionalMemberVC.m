//
//  RegionalMemberVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalMemberVC.h"
#import "RegionalMemberCell.h"
#import "RegionalMemberModel.h"
@interface RegionalMemberVC ()

@end

@implementation RegionalMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    
//    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:@{} images:@[KSPLAIMAGE] success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        
//    }];

}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}


- (void)loadRequsetData{
    
    [KSRequestManager postRequestWithUrlString:URL_usersagent parameter:@{@"user_id":[UserInfoManager sharedManager].user_id, @"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self headerNumNewNumber:[NSString stringWithFormat:@"%@",KSDIC(responseObject, @"month_total")] alwaysPart:[NSString stringWithFormat:@"%@",KSDIC(responseObject, @"total")]];
        [self.datasMutabArray addObjectsFromArray:[RegionalMemberModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)headerNumNewNumber : (NSString *)newNumber alwaysPart:(NSString *)alwaysPart{
    
    // 新增人数
    self.theNewNumber.attributedText = [KSTool setAttributedString:[NSString stringWithFormat:@"本月新增 %@ 人",newNumber] color:[UIColor redColor] startNum:5 length:newNumber.length];
    self.alwaysPartQuantity.attributedText = [KSTool setAttributedString:[NSString stringWithFormat:@"总会员量 %@ 人",alwaysPart] color:[UIColor redColor] startNum:5 length:alwaysPart.length];
    ;
    
}


- (void)initTableView{
    [self registerTableVieCell:@"RegionalMemberCell"];
    self.base_CellHeight = 80;
    self.title = @"区域会员列表";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegionalMemberCell *cell = (RegionalMemberCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.modelMember = self.datasMutabArray[indexPath.section];
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
