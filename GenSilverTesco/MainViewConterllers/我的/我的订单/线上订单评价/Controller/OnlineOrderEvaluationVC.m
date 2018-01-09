//
//  OnlineOrderEvaluationVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/8.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OnlineOrderEvaluationVC.h"
#import "OrderOnlineListCell.h"
#import "OnlneEvaluationFooterView.h"
@interface OnlineOrderEvaluationVC ()

@property (strong, nonatomic) OnlneEvaluationFooterView *evaluation;
@property (assign, nonatomic) NSInteger evaluation_index;
@end

@implementation OnlineOrderEvaluationVC

//- (OnlneEvaluationFooterView *)evaluation{
//    if (_evaluation == nil) {
//        _evaluation = [OnlneEvaluationFooterView initBaseView];
//        _evaluation.frame =CGRectMake(0, 0, Screen_wide, 224);
//    }
//    return _evaluation;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.evaluation_index = 5;
    // Do any additional setup after loading the view from its nib.
//    [self setRightWithString:@"提交" action:@selector(subCommit)];
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    self.title = @"评价";
}

- (void)subCommit{
 }

- (NSString *)goods_id{
   __block  NSString *goodsId = @"";
    [_model.goods enumerateObjectsUsingBlock:^(OrderOnlineGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([goodsId isEqualToString:@""]) {
            goodsId = obj.goods_id;
        }else{
            goodsId = [NSString stringWithFormat:@"%@|%@",goodsId,obj.goods_id];
        }
    }];
    return goodsId;
}

- (void)initTableView{
    [self registerTableVieCell:@"OrderOnlineListCell"];
    self.base_CellHeight = 91;
//    WeakSelf
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.myTableView.tableFooterView = self.evaluation;
//        self.evaluation.base_BlockIdx = ^(NSInteger index){
//            weakSelf.evaluation_index = index +1;
//        };
//        
//    });
//}
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _model.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderOnlineListCell *cell = (OrderOnlineListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.model = _model.goods[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    KSNavigationController *nav= [KSTabBarController gitNavigationController ];
//    OrderOnlineInfoVC *orderInfo = [OrderOnlineInfoVC new];
//    OrderOnlineModel *model = self.datasMutabArray[indexPath.section];
//    
//    orderInfo.order_id = model.order_id;
//    [nav pushViewController:orderInfo animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 224;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     OnlneEvaluationFooterView *evaluation = [OnlneEvaluationFooterView initBaseView];
    evaluation.frame =CGRectMake(0, 0, Screen_wide, 224);
    evaluation.commitCilick.tag = section;
    OrderOnlineGoods *goodsModel = _model.goods[section];
    evaluation.index = goodsModel.comNum;
    evaluation.model = goodsModel;
    evaluation.contextTextView.text = goodsModel.com_context;
    evaluation.base_BlockIdx = ^(NSInteger index){
        goodsModel.comNum = index ;
    };
    [evaluation.commitCilick addTarget:self action:@selector(commitCilick:) forControlEvents:UIControlEventTouchUpInside];
    return  evaluation;
}

- (void)commitCilick:(UIButton *)sender{
 
    [MBProgressHUD showActivityMessageInWindow:isSubmitted];
    OrderOnlineGoods *goodsModel = _model.goods[sender.tag];
    if ([goodsModel.com_context isEqualToString:@""]||goodsModel.com_context == nil) {
        
        [MBProgressHUD showTipMessageInWindow:@"请输入评论内容"];
        return;
    }
    [KSRequestManager postRequestWithUrlString:URL_comment_send parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"isapp":@"1",@"content":goodsModel.com_context,@"comment_rank":@(goodsModel.comNum +1),@"goods_id":goodsModel.goods_id,@"order_id":_model.order_id} success:^(id responseObject) {
        [MBProgressHUD showTipMessageInWindow:@"评论成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_upDataSccuss) {
                _upDataSccuss();
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(id error) {
        
    }];

}


@end
