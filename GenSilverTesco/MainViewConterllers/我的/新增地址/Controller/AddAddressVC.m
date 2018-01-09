//
//  AddAddressVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "AddAddressVC.h"
#import "KSPickView.h"
#import "KSAddressView.h"
@interface AddAddressVC ()
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightWithString:@"完成" action:@selector(completeClick)];
    self.title = @"新增地址";
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    
    if (_model) {
        self.nameField.text = _model.consignee;
        self.phoneField.text = _model.mobile;
        self.addressInfo.text = _model.address;
        self.province = _model.province;
        self.city = _model.city;
        self.district = _model.district;
        [self.address setTitle:_model.rnames forState:UIControlStateNormal];
    }
}

- (void)completeClick{
//    self.nameField.text = @"李达康";
//    self.phoneField.text = @"13486171969";
//    self.addressInfo.text = @"祥园路88号中国智慧信息产业园";
    if ([self.nameField.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleaseName];
        return;
    }
    if ([self.phoneField.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleasePhone];
        return;
    }
    if ([[self.address titleForState:UIControlStateNormal] isEqualToString:@"请选择地址"]) {
        [MBProgressHUD showTipMessageInWindow:pleaseArea];
        return;
    }
    if ([self.addressInfo.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleaseInputDetailedAddress];

        return;
    }
    NSDictionary *dic = @{@"user_id":[UserInfoManager sharedManager].user_id
                          ,@"address_id":_model ? _model.address_id : @"0"
                          ,@"consignee":self.nameField.text
                          ,@"mobile":self.phoneField.text
                          ,@"tel":@""
                          ,@"province":_province
                          ,@"city":_city
                          ,@"district":_district
                          ,@"address":_addressInfo.text};
    [MBProgressHUD showActivityMessageInWindow:isSubmitted];
    [KSRequestManager postRequestWithUrlString:URL_address_edit parameter:dic success:^(id responseObject) {
        NSLog( @"---%@",responseObject);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:_model  ? updataAddressSuucess:addAddressSuucess];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_updataAddress) {
                _updataAddress();
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(id error) {
        
    }];
}

- (IBAction)showListCity:(id)sender{
    [self.view endEditing:YES];
  [self showMensuAddress]
    ;
}

- (void)showMensuAddress{
    WeakSelf
    
    KSAddressView *addressView = [KSAddressView initBaseView];
    addressView.frame = [UIScreen mainScreen].bounds;
    addressView.addressPickViewBlock = ^(id province,id city,id arer){
        weakSelf.province = KSDIC(province, @"region_id");
        weakSelf.city = KSDIC(city, @"region_id");
        weakSelf.district = KSDIC(arer, @"region_id");
         [weakSelf.address setTitle:[NSString stringWithFormat:@"%@%@%@",KSDIC(province, @"region_name"),KSDIC(city, @"region_name"),KSDIC(arer, @"region_name")] forState:UIControlStateNormal];
        
    };
    [addressView baseXIB_showAlpha:.3 color:nil];
}

@end
