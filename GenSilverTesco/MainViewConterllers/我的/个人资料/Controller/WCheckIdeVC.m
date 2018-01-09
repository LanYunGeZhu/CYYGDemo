//
//  wCheckIde.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WCheckIdeVC.h"
#import "WIdeCellTf.h"
#import "WIdeView.h"
#import "UILabel+Kiwi.h"
#import "UIButton+Extension.h"
#import "KSPickView.h"
#import "WBankModel.h"
#import "WDealModel.h"
#import "UIViewController+OpenImagePicker.h"
#import "KSAddressView.h"
#import "UIImageView+Kiwi.h"

@interface WCheckIdeVC ()<UITableViewDelegate,UITableViewDataSource,TouchDelegate,UIScrollViewDelegate>
{
    WDealModel *deal;
    WInfomationModel *model;
    NSString *url;

}

@property (strong, nonatomic)  WIdeView *headerView;
@property (copy, nonatomic)  NSString *province;
@property (copy, nonatomic)  NSString *city;
@property (copy, nonatomic)  NSString *district;
@property (copy, nonatomic)  NSString *address;

@end

@implementation WCheckIdeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self WGetrequestData];
    [self loadRequsetData];

    
    

 }

- (void)initData{

    self.title = @"身份信息";
    _headerView = [WIdeView initBaseView];
    _headerView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
    self.IDETab.toucDelegate = self;
    [[WHC_KeyboardManager share] addMonitorViewController:self];
    deal = [[WDealModel alloc]init];
    self.IDETab.userInteractionEnabled = YES;
    [self.IDETab registerNib:[UINib nibWithNibName:@"WIdeCellTf" bundle:nil] forCellReuseIdentifier:@"cell"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.IDETab.tableHeaderView = _headerView;
    });
    _headerView.IdePic.contentMode = UIViewContentModeScaleAspectFit;
    [_headerView.IdePic addClickMethod:^(UIImageView *btn) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self WphotoDeal:0];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self WphotoDeal:1];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
    [_headerView.BankLa addCallBack:^(UILabel *wLabel) {
        KSPickView * pickView= [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
        pickView.datasArr = [deal WDealWithArray:self.datasMutabArray];

        pickView.indexBlock = ^(NSInteger tag,NSString *context){
            _headerView.BankLa.text = context;
        };
        [pickView show];
    }];
    [_headerView.AreaLa addCallBack:^(UILabel *wLabel) {
        [self showMensuAddress];
    }];
    
    
    [self setRightWithString:@"提交" action:@selector(clickToback)];
}


- (void)WphotoDeal:(NSInteger)tag
{
    if (tag==0)
    {
        [self openImagePickerWithAction:0
                              completed:^(UIImage *image,NSString * filePath) {
                                  _headerView.IdePic.image =  image;
                                  [self Upload:image];
                              }];
    }
    else if(tag==1)
    {
        [self openImagePickerWithAction:1
                              completed:^(UIImage *image,NSString * filePath){
                                  _headerView.IdePic.image =  image;

                                  [self Upload:image];
                              }];
        
    }

}


- (void)Upload:(UIImage *)imageUrl
{
    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:@{} images:@[imageUrl] success:^(id responseObject) {
        
        url = KSDIC(responseObject, @"imgs");
        
    } failure:^(NSError *error) {
        
    }];
}



- (void)clickToback
{
    
    [self WPostrequestData];
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIdeCellTf *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(WTouchTabDelegate *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}

- (void)showMensuAddress{
    WeakSelf
    
    KSAddressView *addressView = [KSAddressView initBaseView];
    addressView.frame = [UIScreen mainScreen].bounds;
    addressView.addressPickViewBlock = ^(id province,id city,id arer){
        weakSelf.province = KSDIC(province, @"region_id");
        weakSelf.city = KSDIC(city, @"region_id");
        weakSelf.district = KSDIC(arer, @"region_id");
        weakSelf.headerView.AreaLa.text = [NSString stringWithFormat:@"%@%@%@",KSDIC(province, @"region_name"),KSDIC(city, @"region_name"),KSDIC(arer, @"region_name")];
     };
    [addressView baseXIB_showAlpha:.3 color:nil];
}

- (void)WGetrequestData
{
        [KSRequestManager postRequestWithUrlString:URL_appgetBank parameter:@{} success:^(id responseObject) {
            
            [self.datasMutabArray addObjectsFromArray:[WBankModel whc_ModelWithJson:responseObject keyPath:@"banks"]];
            
        } failure:^(id error) {
            
        }];
    
}

- (void)WPostrequestData
{
    if ([_headerView.nameTf.text length] > 0 && [_headerView.IdeTf.text length] >0 && ![_headerView.BankLa.text isEqualToString:@"点击选取开户银行"]&&_headerView.NetCodeTf.text.length >0 && _headerView.CardNoTf.text.length >0&&![_headerView.AreaLa.text isEqualToString:@"点击选取所在区域"]&&_headerView.AddressTf.text.length >0&&_headerView.WechatTf.text.length >0 &&_headerView.QQTf.text.length > 0)
    {[KSRequestManager postRequestWithUrlString:URL_appinfosubmit parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"real_name":_headerView.nameTf.text,@"card":_headerView.IdeTf.text,@"bank_name":_headerView.BankLa.text,@"bank_addr":_headerView.NetCodeTf.text,@"bank_account":_headerView.CardNoTf.text,@"province":self.province,@"city":self.city,@"district":self.district,@"address":_headerView.AddressTf.text,@"msn":_headerView.WechatTf.text,@"qq":_headerView.QQTf.text,@"face_card":url} success:^(id responseObject) {
        [MBProgressHUD showSuccessMessage:@"身份认证信息提交成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id error) {
        }];}
    else
    {
        [MBProgressHUD showWarnMessage:WSubmitinfoTip];
    }
    
   
    
}

- (void)loadRequsetData{
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    [KSRequestManager postRequestWithUrlString:URL_appinfomation parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if(KSDIC(responseObject, @"user") )
        {model = [WInfomationModel whc_ModelWithJson:responseObject keyPath:@"user"];
            _headerView.nameTf.text = model.real_name;
            _headerView.IdeTf.text = model.card;
            [_headerView.IdePic sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL, model.face_card)] placeholderImage:[UIImage imageNamed:@"身份证正面照"]];
            if ([model.face_card length]>0) {
                [_headerView.IdePic sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL, model.face_card)] placeholderImage:[UIImage imageWithContentsOfFile:@"身份证正面照"]];
            }else{
            }
            
            _headerView.BankLa.text = model.bank_name;
            _headerView.CardNoTf.text = model.bank_account;
            _headerView.NetCodeTf.text = model.bank_addr;
            _headerView.AreaLa.text = model.anames;
            _headerView.AddressTf.text = model.address;
            _headerView.QQTf.text = model.QQ;
            _headerView.WechatTf.text = model.msn;
            _headerView.AddressTf.text = model.address;
             url = model.face_card;
            self.province = model.province;
            self.city = model.city;
            self.district = model.district;
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
