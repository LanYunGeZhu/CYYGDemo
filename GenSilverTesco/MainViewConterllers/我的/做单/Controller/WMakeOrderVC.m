//
//  WMakeOrderVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WMakeOrderVC.h"
#import "LatestNavMenusView.h"
#import "WCashView.h"
#import "WScoreView.h"
#import "UILabel+Kiwi.h"
#import "KSPickView.h"
#import "WDealModel.h"
#import "WPswView.h"
#import "PartWillOrderVC.h"

@interface WMakeOrderVC ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSString *ursname;
    NSString *VipUser_id;

    WDealModel *deal;
    NSString *shop_id;
    KSPickView * pickView;
    NSDictionary *parameter;
    NSString *pay_password;
    NSString *pay_ratio;


}

@property (strong, nonatomic) LatestNavMenusView *menusView;
@property (strong, nonatomic) WCashView *cashView;
@property (strong, nonatomic) WScoreView *scoreView;
@property (nonatomic,strong) WPswView *pswView;


@end

@implementation WMakeOrderVC
- (LatestNavMenusView *)menusView{
    if (_menusView == nil) {
        _menusView = [LatestNavMenusView initBaseView];
        [_menusView.segmentedControl setTitle:@"现金做单" forSegmentAtIndex:0];
        [_menusView.segmentedControl setTitle:@"积分做单" forSegmentAtIndex:1];
        [_menusView.segmentedControl removeSegmentAtIndex:2 animated:NO];
        _menusView.frame = CGRectMake(0, 0, 100, Screen_heigth);
        [_menusView.segmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _menusView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initData];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self WSearchshopPostRequset];

}



- (void)initData
{
    [[WHC_KeyboardManager share] addMonitorViewController:self];
    
    self.navigationItem.titleView = self.menusView;
    
    deal = [WDealModel new];
    _scoreView = [WScoreView initBaseView];
    _cashView = [WCashView initBaseView];
    
    _cashView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
    _scoreView.frame = CGRectMake(Screen_wide, 0, Screen_wide, Screen_heigth);

    self.WScorllView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
    
    self.WScorllView.contentSize = CGSizeMake(Screen_wide*2, 0);
    self.WScorllView.showsVerticalScrollIndicator = NO;
    self.WScorllView.showsHorizontalScrollIndicator = NO;
    self.WScorllView.pagingEnabled = YES;
    self.WScorllView.bounces = NO;
    
    [self.WScorllView addSubview:_cashView];
    [self.WScorllView addSubview:_scoreView];
    
    _scoreView.WScoreLa.text = @"C模式-16%";

    
    WeakSelf
    _cashView.base_BlockIdx = ^(NSInteger index)
    {
        switch (index) {
            case 0:
            {
                if (weakSelf.cashView.VipTf.text.length <=0)
                {
                    return;
                }
                
                [weakSelf WSearchPostRequset: weakSelf.cashView.VipTf.text];
                [weakSelf.view endEditing:YES];
            }
                break;
            case 1:
            {
                [weakSelf WPostRequset:@"0"];
                
            }
                break;
                
            default:
                break;
        }
    };
    
    
    [_cashView.BankLa addCallBack:^(UILabel *wLabel) {
       
        pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
        pickView.datasArr = [deal WDealWithArrayR:self.datasMutabArray];
        
        pickView.indexBlock = ^(NSInteger tag,NSString *context){
            
            weakSelf.cashView.BankLa.text = context;
            shop_id = [deal WDealWithArrayID:self.datasMutabArray][tag];
            
        };
        
        [pickView show];
        
    }];
    
    _scoreView.cashTf.delegate = self;
    
    _scoreView.base_BlockIdx = ^(NSInteger index)
    {
        switch (index) {
            case 0:
            {
                if (weakSelf.scoreView.VipTf.text.length <=0)
                {
                    return;
                }
                
                [weakSelf WSearchPostRequset: weakSelf.scoreView.VipTf.text];
                [weakSelf.view endEditing:YES];

            }
                break;
            case 1:
            {
                [weakSelf WPostRequset:@"1"];

            }
                break;
                
            default:
                break;
        }

    };
    
    [_scoreView.shopLa addCallBack:^(UILabel *wLabel) {
        
        pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
        pickView.datasArr = [deal WDealWithArrayR:self.datasMutabArray];
        
        pickView.indexBlock = ^(NSInteger tag,NSString *context){
            weakSelf.scoreView.shopLa.text = context;
            shop_id = [deal WDealWithArrayID:self.datasMutabArray][tag];
            
        };
        
        [pickView show];

        
    }];
    [_scoreView.WScoreLa addCallBack:^(UILabel *wLabel) {
       
        pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
        
        pickView.datasArr = @[@"C模式-16%"];
        pickView.indexBlock = ^(NSInteger tag,NSString *context){
            weakSelf.scoreView.WScoreLa.text = context;
            weakSelf.scoreView.scoreTf.text = [NSString stringWithFormat:@"%.f",[weakSelf.scoreView.cashTf.text floatValue]*10];
                pay_ratio = @"16";
                weakSelf.scoreView.ratioTf.text = [NSString stringWithFormat:@"%.f",[weakSelf.scoreView.cashTf.text floatValue]*0.16];
        };
        
        [pickView show];

        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentedControlClick:(UISegmentedControl *)sge
{
    [_WScorllView setContentOffset:CGPointMake(Screen_wide*sge.selectedSegmentIndex, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.x == 0) {
        
        _menusView.segmentedControl.selectedSegmentIndex = 0;
    }else{

        _menusView.segmentedControl.selectedSegmentIndex=1;
    }
}

// 做单
- (void)WPostRequset:(NSString *)type{
    
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
   if([type isEqualToString:@"0"]){
       if([_cashView.cashTf.text length] <=0 ||[_cashView.ratioTf.text length] <=0||[_cashView.shopTf.text length]<=0||[shop_id length]<=0||[ursname length]<=0){  [MBProgressHUD showWarnMessage:@"请完善资料,再进行提交!"];
           return;
       }
   }
   else{if([_scoreView.cashTf.text length] <=0 ||[_scoreView.ratioTf.text length] <=0||[_scoreView.shopTf.text length]<=0||[shop_id length]<=0||[ursname length]<=0){[MBProgressHUD showWarnMessage:@"请完善资料,再进行提交!"];
       return;
   }
   }
    
    
    
    
    WeakSelf
    
    weakSelf.pswView = [WPswView initBaseView];
    weakSelf.pswView.frame = self.view.bounds;
   
    [weakSelf.view addSubview:weakSelf.pswView];
    weakSelf.pswView.base_BlockIdx = ^(NSInteger index){
        pay_password = weakSelf.pswView.WPswtext.text;
        [weakSelf.pswView removeFrom];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf MakeNow:type];

        });
    };
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_scoreView.cashTf])
    {
        _scoreView.scoreTf.text = [NSString stringWithFormat:@"%.2f",[_scoreView.cashTf.text floatValue]*10];
        
        if (pay_ratio == nil)
        {
             pay_ratio = @"16";
        }
        _scoreView.ratioTf.text = [NSString stringWithFormat:@"%.2f",[_scoreView.cashTf.text floatValue]*0.16];
        
        
    }
}

- (void)MakeNow:(NSString *)type
{
    if([type isEqualToString:@"0"])
    {
        parameter = @{@"user_id":[UserInfoManager sharedManager].user_id,@"ptype":type,@"username":ursname,@"shop_id":shop_id,@"price":_cashView.cashTf.text,@"rlbl":_cashView.ratioTf.text,@"goods_name":_cashView.shopTf.text,@"pay_password":pay_password};
        
    }
    else
    {
        
        parameter = @{@"user_id":[UserInfoManager sharedManager].user_id,@"ptype":type,@"username":ursname,@"shop_id":shop_id,@"price":_scoreView.cashTf.text,@"rlbl":pay_ratio,@"goods_name":_scoreView.shopTf.text,@"user_pay_password":pay_password};
    }
    
    [KSRequestManager postRequestWithUrlString:URL_appmakeorder parameter:parameter success:^(id responseObject) {
        
        [MBProgressHUD showSuccessMessage:@"做单申请成功!"];
        
        PartWillOrderVC *partWill = [PartWillOrderVC new];
        [self.navigationController pushViewController:partWill animated:YES];
        
        
    } failure:^(id error) {
        
    }];

}
//
- (void)WSearchPostRequset:(NSString *)phoneNumber{
    
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    
    [KSRequestManager postRequestWithUrlString:URL_appuserinfo parameter:@{@"username":phoneNumber} success:^(id responseObject) {
        
        //
        if ([KSDIC(responseObject, @"user_id") isEqualToString:[UserInfoManager sharedManager].user_id])
        {
            [MBProgressHUD showWarnMessage:WMakeorderTip];
        }
        else
        {
            
            if (_menusView.segmentedControl.selectedSegmentIndex==1)
            {
                VipUser_id = KSDIC(responseObject, @"user_id");
                _scoreView.NameLa.text = KSDIC(responseObject, @"real_name");
                _scoreView.PhoneLa.text = KSDIC(responseObject, @"mobile_phone");
                ursname = KSDIC(responseObject, @"mobile_phone");
                [self WPostRequset];
            }else{
                VipUser_id = KSDIC(responseObject, @"user_id");
                _cashView.NameLa.text = KSDIC(responseObject, @"real_name");
                _cashView.PhoneLa.text = KSDIC(responseObject, @"mobile_phone");
                ursname = KSDIC(responseObject, @"mobile_phone");
            }
            

        }
        
        
    } failure:^(id error) {
        
    }];
}

- (void)WSearchshopPostRequset{
    [KSRequestManager postRequestWithUrlString:URL_appshopinfo parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"username":[[NSUserDefaults standardUserDefaults]objectForKey:@"user_name"]} success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[WBankModel whc_ModelWithJson:responseObject keyPath:@"shops"]];
        
        if (self.datasMutabArray.count == 0) {
            
            [MBProgressHUD showWarnMessage:@"您暂未拥有店铺!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(id error) {
        
    }];
}

//
- (void)WPostRequset{
    
    if (VipUser_id.length == 0) {
        [MBProgressHUD showErrorMessage:@"该会员暂时无法进行积分做单!"];
        return;
    }
    
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    
    [KSRequestManager postRequestWithUrlString:URL_appinfomation parameter:@{@"user_id":VipUser_id} success:^(id responseObject) {
        
        NSLog(@"---%@",responseObject);
        
        if(KSDIC(responseObject, @"user") )
        {
            _scoreView.scoreLa.text = StringWithStr(@"会员可用积分:",KSDIC(KSDIC(responseObject, @"user"), @"pay_points") );
            ;
            _scoreView.shopLa.text = [deal WDealWithArrayR:self.datasMutabArray][0];
            shop_id = [deal WDealWithArrayID:self.datasMutabArray][0];
            
        }
        
    } failure:^(id error) {
        
    }];
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
