//
//  WWithDrawVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WWithDrawVC.h"
#import "WWithDrawCell.h"
#import "WPayView.h"
#import "UIView+Kiwi.h"
#import "WWIthRecordVC.h"
#import <QuartzCore/QuartzCore.h>

#import "WInfomationModel.h"
#import "WPswView.h"


static NSString *kCellID = @"cellID";

@interface WWithDrawVC ()<UITableViewDelegate,UITableViewDataSource,TouchDelegate>
{
    NSArray *ItemArr;
    WInfomationModel *model;
    NSString *ptype;
    NSString *payPsw;
}


@property (nonatomic,strong) WPayView *payView;
@property (nonatomic,strong) WPswView *PswView;

@end

@implementation WWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self WPostRequset];
}

- (void)initData
{
    [self.WithTab registerNib:[UINib nibWithNibName:@"WWithDrawCell" bundle:nil] forCellReuseIdentifier:kCellID];
    
    self.WithTab.toucDelegate = self;
    
    
    
    ItemArr = @[@"所在地区",@"开户银行",@"开户网点",@"银行账号",@"开户姓名"];
    
    [self setRightWithImage:@"更多(7)" action:@selector(clickToRecord)];
    
    _payView = [WPayView initBaseView];
    
    _payView.frame = CGRectMake(0, 0, Screen_wide, 200);
    
    [_payView.Pay setTitle:@"立即提现" forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.WithTab.tableFooterView = _payView;
        
    });
    
    WeakSelf
    
    _payView.base_BlockIdx = ^(NSInteger index)
    {
        switch (index) {
            case 0:
            {
                
                
                
                weakSelf.PswView = [WPswView initBaseView];
                weakSelf.PswView .frame = weakSelf.view.bounds;
                
                [weakSelf.PswView baseXIB_showAlpha:.3 color:nil ];
                weakSelf.PswView .base_BlockIdx = ^(NSInteger index){
                    
                    payPsw = weakSelf.PswView.WPswtext.text;
                    
                    [weakSelf.PswView  baseXIB_removeSubView];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [weakSelf WloadRequsetData];
                        
                    });
                };


            }
                break;
                
            default:
                break;
        }
    };
    
    
    [self setHight:NO];
    [self.LeftV addCallBack:^(UIView *wView) {
    [self setHight:NO];
    }];
    
    [self.ReftV addCallBack:^(UIView *wView) {
    [self setHight:YES];
    }];
    
    
    self.title = @"积分提现";
    
}

- (void)setHight:(BOOL)isSelect
{
   
    self.ReftV.layer.borderColor = isSelect == YES? [UIColor redColor].CGColor:[UIColor clearColor].CGColor;
    self.ReftV.layer.borderWidth = 1;
  
    if(isSelect == NO)
    {
      ptype = @"0";
    }
    else
    {
      ptype = @"1";

    }
    
    for (UILabel *sbView in self.ReftV.subviews)
    {
        sbView.textColor = isSelect == YES?[UIColor redColor]:[UIColor blackColor];
    }
    
    self.LeftV.layer.borderColor = isSelect == YES?[UIColor clearColor].CGColor:[UIColor redColor].CGColor;
    self.LeftV.layer.borderWidth = 1;

    
    for (UILabel *sbView in self.LeftV.subviews)
    {
        sbView.textColor = isSelect == YES?[UIColor blackColor]:[UIColor redColor];
    }


}


- (void)WloadRequsetData{
    
    if([_WithDraw.text length] <= 0)
    {
        [MBProgressHUD showErrorMessage:WDomoneyTip];

        return;
    }
    
    if([ptype isEqualToString:@"0"])
    {
        if ([model.bz_points floatValue] < [_WithDraw.text floatValue])
        {
            [MBProgressHUD showErrorMessage:WDopmoneyTip];
            
            return;
            
        }
    }
    else
    {
        if ([model.hk_points floatValue] < [_WithDraw.text floatValue])
        {
            [MBProgressHUD showErrorMessage:WDopmoneyTip];
            
            return;
            
        }
    }
    
    
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    
    [KSRequestManager postRequestWithUrlString:URL_apptomoney parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"ptype":ptype,@"amount":_WithDraw.text,@"pay_password":payPsw} success:^(id responseObject) {
        
        [MBProgressHUD showSuccessMessage:WMoneyTip];
        [self WPostRequset];
        
        
    } failure:^(id error) {
        
    }];
}



// 提现记录

- (void)clickToRecord
{
    WWIthRecordVC *VC =[WWIthRecordVC new];

    [self.navigationController pushViewController:VC animated:YES];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
     cell.LSmall.text = ItemArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
           cell.RSmall.text = model.anames;
        }
            break;
        case 1:
        {
            cell.RSmall.text = model.bank_name;
        }
            break;
        case 2:
        {
            cell.RSmall.text = model.bank_addr;
        }
            break;
        case 3:
        {
            cell.RSmall.text = model.bank_account;
        }
            break;
        case 4:
        {
            cell.RSmall.text = model.real_name;
        }
            break;
            
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)WPostRequset{
    
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    
    [KSRequestManager postRequestWithUrlString:URL_appinfomation parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        
        NSLog(@"---%@",responseObject);
        
        if(KSDIC(responseObject, @"user") )
        {
            model = [WInfomationModel whc_ModelWithJson:responseObject keyPath:@"user"];
            _LSmall.text = StringWithStr(@"剩余",StringWithStr(model.bz_points, @"积分"));
            _RSmall.text = StringWithStr(@"剩余",StringWithStr(model.hk_points, @"积分"));
;
            [_WithTab reloadData];
            
        }
        
    } failure:^(id error) {
        
    }];
}

@end
