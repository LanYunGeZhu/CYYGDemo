//
//  PartWillOrderInfoVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PartWillOrderInfoVC.h"
#import "PartInfoCell.h"
@interface PartWillOrderInfoVC ()

@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *contextArray;
@end

@implementation PartWillOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initTableView{
    self.title = @"订单信息";
    [self registerTableVieCell:@"PartInfoCell"];
    self.base_CellHeight = 44;
    self.datasMutabArray = [@[@"订单编号",@"会员账号",@"店铺名称",@"所在区域",@"商品名称",@"消费金额",@"支付方式",@"让利比例",@"让利金额",@"做单时间",@"审核状态"]mutableCopy];
    NSString *payType = [_model.ptype integerValue] == 1 ? @"现金支付":@"积分换购";
        NSArray *stateArray = @[@"待审核",@"已审核" ,@"已驳回"];
    self.contextArray = @[_model.orderid,_model.pay_user_name,_model.shop_name,_model.anames,_model.goods_name,_model.price,payType,[NSString stringWithFormat:@"%@%%",_model.rlbl],_model.rl_money,_model.addtime,stateArray[[_model.status integerValue]],@"",@""];
}

#pragma mark -- UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PartInfoCell *cell = (PartInfoCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.nameLabel.text = self.datasMutabArray[indexPath.row];
    cell.context.text = self.contextArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
