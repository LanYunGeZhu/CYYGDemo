//
//  AddTheSalesmanVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "AddTheSalesmanVC.h"
@interface AddTheSalesmanVC ()

@property (copy, nonatomic) NSString *numText;
@end

@implementation AddTheSalesmanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setRightWithString:@"提交" action:@selector(subCommit)];
    self.title = @"添加业务员";
    [self getTheAgentInformation];
    if (_model) {
        self.mobile.text = _model.user_name;
        self.area.text = _model.anames;
        self.surname.text = _model.real_name;
        [self.commissionRatio setTitle:[NSString stringWithFormat:@"%.0f%%",[_model.yjbl doubleValue] *100] forState:UIControlStateNormal];
        self.numText = [NSString stringWithFormat:@"%.0f",[_model.yjbl doubleValue] * 100];
    }
}

- (IBAction)querySalesman:(id)sender{
    if ([self.mobile.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleasePhone];
        return;
    }
    if (![KSTool validateMobile:self.mobile.text]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入正确的手机号码"];
        
        return;
    }
    [KSRequestManager postRequestWithUrlString:URL_check_agent_user parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"username":self.mobile.text} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        id data = responseObject[@"user"];
        self.surname.text = KSDIC(data, @"real_name");
    } failure:^(id error) {
        
    }];
}

#pragma mark -- 提交
- (void)subCommit{
    
    if ([self.mobile.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleasePhone];
        return;
    }
    if (![KSTool validateMobile:self.mobile.text]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入正确的手机号码"];

        return;
    }
    
    if ([[self.commissionRatio titleForState:UIControlStateNormal] isEqualToString:@"选择数额百分比"]) {
        [MBProgressHUD showTipMessageInWindow:@"请选择佣金比例"];
        return;
    }
 
    NSDictionary * dic = @{@"user_id":[UserInfoManager sharedManager].user_id
                           ,@"user_name":self.mobile.text
                           ,@"yjbl":@([self.numText doubleValue])
                           ,@"id":_model?_model.iD : @""};

    [MBProgressHUD showActivityMessageInWindow:beingAdded];
    [KSRequestManager postRequestWithUrlString:URL_saler_add parameter:dic success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:_model? updateSuccess: addSuccess];
        if (_updateSuccess) {
            _updateSuccess();
        }
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(id error) {
        
    }];
}

//佣金比例
- (IBAction)commissionRatio:(UIButton *)sender{
    [self.view endEditing:YES];
    NSArray *array = [self commissontNum];
    [self base_showPickViewListDatasArray:@[array] selectArray:^(NSArray *array) {
        [sender setTitle:array[0][@"context"] forState:UIControlStateNormal];
        NSInteger index =[ array[0][@"idx"] integerValue];
        self.numText = [NSString stringWithFormat:@"%d",index + 1];
    }];
}


- (NSArray *)commissontNum{
    NSMutableArray *array = [NSMutableArray array];
    for (int x = 1; x < 21; x ++) {
        [array addObject:[NSString stringWithFormat:@"%d%%",x]];
    }
    
    return array;
}

- (void)getTheAgentInformation{
    [KSRequestManager postRequestWithUrlString:URL_agent_info parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.area.text=  KSDIC(responseObject, @"agent_area");
    } failure:^(id error) {
        
    }];
}


@end
