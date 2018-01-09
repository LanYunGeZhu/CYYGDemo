//
//  WScoreVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WScoreVC.h"
#import "WConfirmBuyVC.h"
#import "UILabel+Kiwi.h"

@interface WScoreVC ()

@end

@implementation WScoreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
}

- (void)initData
{
    self.title = @"购买积分";
    [self setRightWithString:@"确认" action:@selector(clickToConfirm)];
    [self.scoreTf addTarget:self action:@selector(textValueDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textValueDidChange:(UITextField *)Tf{
    if ([Tf.text integerValue] <=0||[Tf.text integerValue]>100000000000){
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%.2f元",[Tf.text floatValue]/100];
    [self.moneyLa WSetMutibleColorWithPay:StringWithStr(@"所需金额:",str)];
}
- (void)clickToConfirm
{
    WConfirmBuyVC *confirm = [WConfirmBuyVC new];
    confirm.shopMoney = [NSString stringWithFormat:@"%.2f",[self.scoreTf.text floatValue]/100];
    confirm.score = [NSString stringWithFormat:@"%.2f",[self.scoreTf.text floatValue]];
    [self.navigationController pushViewController:confirm animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
