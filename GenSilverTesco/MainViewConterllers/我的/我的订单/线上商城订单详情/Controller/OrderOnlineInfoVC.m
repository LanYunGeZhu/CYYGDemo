//
//  OrderOnlineInfoVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OrderOnlineInfoVC.h"
#import "OnlineFooterView.h"
#import "OnlineAddressCell.h"
#import "OrderOnlineListCell.h"
#import "PriceListCell.h"
#import "OrderOnlineModel.h"
#import "PrderPaymentVC.h"
#import "OnlineOrderEvaluationVC.h"
#import "EaseMessageViewController.h"
#import "ApplyForARefundVC.h"
#import "GoodsDetailsVC.h"
@interface OrderOnlineInfoVC ()

@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *contextArray;
@property (strong, nonatomic) OrderOnlineModel *model;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation OrderOnlineInfoVC


- (void)timeCountdown{

    double timer = [_model.add_time doubleValue];
    NSTimeInterval StartTimeInterval = timer + 900;
    if ( StartTimeInterval - [self getCurrentTimer]<= 0) {
        
        NSLog(@"---%@",@"已经结束了");
        self.theCountdown.text = @"订单已超时";

        [self.timer setFireDate:[NSDate distantFuture]];
        [self.timer invalidate];
    }else{
        
        NSString *starContext = [self lessSecondToDay:StartTimeInterval -[self getCurrentTimer]];
        self.theCountdown.text = [NSString stringWithFormat:@"待付款,请在%@分钟内完成支付",starContext];
        NSLog(@"---%@",starContext);
    }

 
    
}
- (NSTimeInterval )getCurrentTimer{
    return [[NSDate date]timeIntervalSince1970];
}

- (NSString *)lessSecondToDay:(NSUInteger)seconds
{
//    NSUInteger hour = (NSUInteger)(seconds%(24*3600))/3600;
    NSUInteger min  = (NSUInteger)(seconds%(3600))/60;
    NSUInteger second = (NSUInteger)(seconds%60);
    
//    NSString *time = [NSString stringWithFormat:@"%lu小时%lu分%lu秒",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    return [NSString stringWithFormat:@"%lu:%lu",(unsigned long)min,(unsigned long)second];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequsetData];
    
    if (_model.order_status.integerValue == 2 || _model.order_status.integerValue ==3) {
    }else{
        [self setRightWithImage:@"更多11" action:@selector(rightClick)];
        
    }
}

- (void)goBack{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [super goBack];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_orders_detail parameter:@{@"order_id":_order_id,@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        _model = [OrderOnlineModel whc_ModelWithJson:responseObject keyPath:@"order"];
        self.contextArray = @[
  @[[NSString stringWithFormat:@"￥%@",_model.goods_amount]
    ,[NSString stringWithFormat:@"￥%@",_model.shipping_fee]
    ,[self getGoodsNum]
    ,[NSString stringWithFormat:@"%@",_model.integral_money]
    ,[NSString stringWithFormat:@"￥%@",_model.order_amount]]
  
  ,@[_model.order_sn
     ,[KSTool setTimeStyle:@"yyy-MM-dd HH:mm:ss" timer:[_model.add_time doubleValue] *1000]
     ,[self getPay_timerType:0 timerModel:_model.pay_time]
     ,[self getPay_timerType:1 timerModel:_model.shipping_time]
     ,[self getPay_timerType:2 timerModel:_model.shipping_time_end]]];
        [self setOrderCanl];
        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

/**&*
 * 根据 传入对应的 时间  返回对应的状态
 */
- (NSString *)getPay_timerType:(NSInteger)type timerModel:(NSString *)timerMode{
    
    NSArray *timerStringArray = @[@"未付款",@"未发货",@"未成交"];
    if ([timerMode integerValue] == 0) {
        return timerStringArray[type];
    }else{
        return [KSTool setTimeStyle:@"yyy-MM-dd HH:mm:ss" timer:[timerMode doubleValue] *1000];
    }
}

- (void)setOrderCanl{
    
    if ([_model.order_status integerValue] == 0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];

        [self.timer setFireDate:[NSDate distantPast]];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }else{
        [self  hidderHeaderTitmer];
 
    }
 
}

- (NSString * )getGoodsNum{
    __block NSInteger num = 0;
    [_model.goods enumerateObjectsUsingBlock:^(OrderOnlineGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        num = num + [obj.goods_number integerValue];
    }];
    return [NSString stringWithFormat:@"%ld",(long)num];
}

- (void)initTableView{
    [self registerTableVieCellsArray:@[@"OnlineAddressCell",@"OrderOnlineListCell",@"PriceListCell"]];
    self.titleArray = @[@[@"商品总价",@"快递费用",@"购买数量",@"使用积分",@"订单总价"],@[@"订单编号",@"创建时间",@"付款时间",@"发货时间",@"成交时间"]];
    self.title = @"订单详情";
}

/** 调用此方法 隐藏 tableView 上不 倒计时*/
- (void)hidderHeaderTitmer{
    self.layou_tableView_top.constant = 0;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return _model.goods.count;
    }else{
        return [self.titleArray[section -2] count];
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OnlineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OnlineAddressCell" forIndexPath:indexPath];
        cell.name.text = _model.consignee;
        cell.address.text = [NSString stringWithFormat:@"%@%@",_model.anames,_model.address];
        cell.phone.text = _model.mobile;
        return cell;
    }else if (indexPath.section ==1){
        OrderOnlineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderOnlineListCell" forIndexPath:indexPath];
        cell.model = _model.goods[indexPath.row];
        return cell;
    }else {
        PriceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceListCell" forIndexPath:indexPath];
        cell.nameLabel.text = self.titleArray[indexPath.section -2][indexPath.row];
        if (_model !=nil) {
            cell.contextLabel.text = self.contextArray[indexPath.section -2][indexPath.row];
            cell.centerContext.text = self.contextArray[indexPath.section -2][indexPath.row];
        }
        [cell.mensBtn addTarget:self action:@selector(copyMensuClick) forControlEvents:UIControlEventTouchUpInside];
        cell.base_IndexPath = indexPath;
        cell.isShowTitle = indexPath.section == 2 ? YES : NO;
        return cell;
    }
    return nil;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 78;
    }else if (indexPath.section ==1){
        return 91;
    }else{
        return 44;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return 40;
    }
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 16;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        WeakSelf
        OnlineFooterView *footerView = [OnlineFooterView initBaseView];
        footerView.model = _model;
        footerView.base_BlockIdx = ^(NSInteger index){
            [weakSelf footerMenusClick:section];
        };
        footerView.numLable.text = @"";
        footerView.price.text = @"";
        return footerView;
    }
    return nil;
}

- (void)copyMensuClick{
    [MBProgressHUD showTipMessageInWindow:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _model.order_sn;
}

/** 删除*/
- (void)rightClick {
 
        if ([_model.order_status integerValue] == 0) {
            //代付款
            [KSTool alertViewWithController:self title:@"温馨提示" message:nil items:@[@"删除"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
                [self deleteOrderDataReuqset:0];
            }];
        }else if ([_model.order_status integerValue]  ==1){
            [KSTool alertViewWithController:self title:@"温馨提示" message:nil items:@[@"申请退款"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
                
                ApplyForARefundVC *applyFor = [ApplyForARefundVC new];
                applyFor.receivemodel = _model;
                [[KSTabBarController gitNavigationController ] pushViewController:applyFor animated:YES];
                
            }];
        }else if ([_model.order_status integerValue]  ==5){
            //交易关闭
            [KSTool alertViewWithController:self title:@"温馨提示" message:nil items:@[@"删除"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
                [self deleteOrderDataReuqset:0];
            }];
        }
    
}

- (void)deleteOrderDataReuqset:(NSInteger)section{
    
    OrderOnlineModel *model = _model;
    
    [KSTool alertViewWithController:self title:@"温馨提示" message:@"您确定要删除此订单吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
        if (indx == 0) {
            return ;
        }
        [KSRequestManager postRequestWithUrlString:URL_order_delete parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"order_id":model.order_id} success:^(id responseObject) {
            [MBProgressHUD showTipMessageInWindow:@"删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_goBlckOrderInfo) {
                    _goBlckOrderInfo(delete_Order_Success);
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(id error) {
        }];
        
    }];
}

/** 确认订单 取消 等操作*/
- (void)footerMenusClick:(NSInteger)section{
    
        if ([_model.order_status integerValue] == 0) {
            //去付款
            PrderPaymentVC * prode = [PrderPaymentVC new];
            prode.data = @{@"order_id":_model.order_id,@"order_amount":_model.order_amount};
            [[KSTabBarController gitNavigationController ] pushViewController:prode animated:YES];
        }else if ([_model.order_status integerValue] ==1){
            //联系卖家
            EaseMessageViewController * chatController = [[EaseMessageViewController alloc]initWithConversationChatter:@"ljjxiaomi20170327" conversationType:EMConversationTypeChat];
            chatController.title = @"App客服" ;
            [[KSTabBarController gitNavigationController ] pushViewController:chatController animated:YES];
            
        }else if ([_model.order_status integerValue]==2){
            [self confirmTheGoods:_model];
        }else if ([_model.order_status integerValue] ==3){
            WeakSelf
            // 去评价
            OnlineOrderEvaluationVC *evaluation = [OnlineOrderEvaluationVC new];
            evaluation.upDataSccuss = ^{
                weakSelf.model.order_status = @"4";
                if ( weakSelf.goBlckOrderInfo) {
                    weakSelf.goBlckOrderInfo(update_Order_evaluation);
                }
                [weakSelf.myTableView reloadData];
            };
            evaluation.model = _model;
            [[KSTabBarController gitNavigationController ] pushViewController:evaluation animated:YES];
            
        }else {
            //再次购买
            OrderOnlineGoods *goodsModel=  _model.goods[0];
            GoodsDetailsVC *goodsDetaols = [GoodsDetailsVC new];
            goodsDetaols.goods_id = goodsModel.goods_id;
            [[KSTabBarController gitNavigationController ] pushViewController:goodsDetaols animated:YES];
        }
}

- (void)confirmTheGoods:(OrderOnlineModel *)model{
    
    [KSRequestManager postRequestWithUrlString:URL_order_shipped parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"order_id":model.order_id} success:^(id responseObject) {
        [MBProgressHUD showTipMessageInWindow:@"确认收货成功"];
        [self base_RefreshHeaderFooter:YES];
    } failure:^(id error) {
        
    }];
}

- (void)dealloc{
    [self.timer invalidate];
    [self.timer setFireDate:[NSDate distantFuture]];
    self.timer = nil;
}

@end
