//
//  WebVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/8/15.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WebVC.h"
#import "MyOrderListVC.h"
#import "RechargeRecordVC.h"

@interface WebVC ()

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微信支付";
    
    NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
    [uuu setObject:@"1" forKey:@"vcShow"];
    [uuu setObject:@"WebVC" forKey:@"vc"];
    [uuu synchronize];
    
    [self.imgview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_imgurl]]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPayResult) name:@"getPayResult1" object:nil];
}
int i = 0;
- (void)getPayResult{
    
    if (_mark == 3) {//充值支付跳到充值记录
        //跳到充值记录列表
        RechargeRecordVC *Vc = [RechargeRecordVC new];
        [self.navigationController pushViewController:Vc animated:YES];
        return ;
    }
    
    //跳到订单列表
    MyOrderListVC *myOder= [MyOrderListVC new];
    if (_mark == 1) {//扫码支付跳到线下订单列表
        myOder.isFlog = YES;
    }else{
        myOder.index = 0;
    }
    [self.navigationController pushViewController:myOder animated:YES];
    
//    i+=1;
//    //获取支付结果
//    [MBProgressHUD showActivityMessageInView:@"查询支付结果..."];
//    [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=ck_recharge" parameter:@{@"ordersn":self.ordersn} success:^(id responseObject) {
//        
//        if ([responseObject[@"ispaid"] isEqual:@"1"]) {//支付成功
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showSuccessMessage:@"支付成功"];
//        }else{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (i >10) {
//                   [MBProgressHUD showSuccessMessage:@"支付失败"];
//                }
//                [self getPayResult];
//            });
//            return ;
//        }
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            if (_mark == 3) {//充值支付跳到充值记录
//                //跳到充值记录列表
//                RechargeRecordVC *Vc = [RechargeRecordVC new];
//                [self.navigationController pushViewController:Vc animated:YES];
//                return ;
//            }
//            
//            //跳到订单列表
//            MyOrderListVC *myOder= [MyOrderListVC new];
//            if (_mark == 1) {//扫码支付跳到线下订单列表
//                myOder.isFlog = YES;
//            }else{
//                myOder.index = 0;
//            }
//            [self.navigationController pushViewController:myOder animated:YES];
//            
//        });
//        
//        
//    } failure:^(id error) {
//        
//    }];
}




@end
