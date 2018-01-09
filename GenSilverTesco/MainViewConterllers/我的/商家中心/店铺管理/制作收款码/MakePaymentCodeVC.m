//
//  MakePaymentCodeVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MakePaymentCodeVC.h"
#import "KSPickView.h"
#import "PamentCodeSuccessVC.h"
@interface MakePaymentCodeVC ()

@end

@implementation MakePaymentCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"制作收款码";
    
    self.storeName.text = _store_Name;
}

- (IBAction)menusClick:(UIButton *)sender{
    if ([self.cashPaymentsAndBenefits.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入让利比例（单位：%）"];
        return;
    }
    if ([self.setTheGoods.text isEqualToString:@""]) {
        self.setTheGoods.text = @"未填写";
    }
    if (sender.tag == 0) {
        KSPickView *pick = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
        pick.datasArr = @[@[@"C模式-16%"]];
        pick.blockArray = ^(NSArray *blockArray){
            NSLog(@"--%@",blockArray);
           [ self.proportionIntegralBenefit setTitle:blockArray[0][@"context"] forState:UIControlStateNormal];
        };
        [pick show];
    }else{
        PamentCodeSuccessVC *pament = [PamentCodeSuccessVC new];
        //店铺id 商品名 积分让利比 现金让利比
        pament.data = @{@"shop_id":_store_Id,@"goods_name":_setTheGoods.text,@"rlbl1":@"16",@"rlbl2":_cashPaymentsAndBenefits.text,@"store_name":_store_Name};
        [self.navigationController pushViewController:pament animated:YES];
    }
}

@end
