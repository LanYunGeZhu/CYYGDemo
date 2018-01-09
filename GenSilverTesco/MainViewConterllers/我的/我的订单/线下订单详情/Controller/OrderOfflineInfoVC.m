//
//  OrderOfflineInfoVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/30.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OrderOfflineInfoVC.h"
#import "OrderOfflineInfoCell.h"
#import "OrderOfflineModel.h"
@interface OrderOfflineInfoVC ()

@property (strong, nonatomic) OrderOfflineModel *model;
@property (strong, nonatomic) NSArray *contextArray;
@end

@implementation OrderOfflineInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadRequsetData];
}

- (void)goBack{
//    if (_goBackBlock) {
//        _goBackBlock();
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goBackOrderInfoClick" object:nil];
    [super goBack];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_orders_sjorder_detail parameter:@{@"id":self.order_Id,@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"----%@",responseObject);
        _model = [OrderOfflineModel whc_ModelWithJson:responseObject];
        self.datasMutabArray = [@[@"订单编号",@"会员账号",@"店铺名称",@"所在区域",@"商品名称",@"消费金额",@"支付方式",@"让利比例",@"让利金额",@"做单时间",@"审核状态"] mutableCopy];
        NSString *timer =[KSTool setTimeFormat:[_model.addtime doubleValue] *1000];
        NSArray *statusArray = @[@"待审核",@"审核通过",@"审核不通过"];
        NSString * text = statusArray[[_model.status integerValue]];

        self.contextArray = @[_model.orderid
                              ,_model.pay_user_name
                              ,_model.shop_name
                              ,_model.anames
                              ,_model.goods_name
                              ,_model.price
                              ,[self payOrderStatus]
                              ,[NSString stringWithFormat:@"%@%%",_model.rlbl]
                              ,[NSString stringWithFormat:@"￥%@",_model.rl_money]
                              ,timer
                              ,text];
        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (NSString *)payOrderStatus{
    NSString *payType = @"";
    if ([_model.pay_points doubleValue] > 0) {
        payType = @"积分支付";
    }
    if ([_model.pay_money doubleValue] > 0) {
        payType = @"现金支付";
    }
    return payType;
}

- (void)initTableView{
    [self registerTableVieCell:@"OrderOfflineInfoCell"];
    self.base_CellHeight = 44.0f;
    self.title = @"订单详情";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderOfflineInfoCell *cell =(OrderOfflineInfoCell *) [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.nameLable.text = self.datasMutabArray[indexPath.row];
    cell.context.text = self.contextArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
