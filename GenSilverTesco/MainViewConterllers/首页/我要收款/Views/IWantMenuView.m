//
//  IWantMenuView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "IWantMenuView.h"
#import "IWantMenusListCell.h"
@implementation IWantMenuView

- (void)awakeFromNib{
    [super  awakeFromNib];
    [self.myTableView.layer setBorderWidth:1];
    [self.myTableView.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc]init];
    }
    return _listArr;
}

- (void)registerCell{
    

    [self.myTableView registerNib:[UINib nibWithNibName: @"IWantMenusListCell" bundle:nil] forCellReuseIdentifier:@"IWantMenusListCell"];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWantMenusListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IWantMenusListCell" forIndexPath:indexPath];
    
    if (self.listArr.count > 0) {
        if (_flag == 1) {//店铺cell
            cell.lab.text = self.listArr[indexPath.row][@"shop_name"];
        }else{//让利比cell
            cell.lab.text = self.listArr[indexPath.row][@"bili"];
        }
    }
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.base_BlockIdx) {
        self.base_BlockIdx(indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}




@end
