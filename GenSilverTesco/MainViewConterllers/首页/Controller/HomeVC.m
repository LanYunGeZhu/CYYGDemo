//
//  HomeVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "HomeVC.h"

#import "HeaderPageCollectionViewCell.h"
#import "ItemsCollectionViewCell.h"
#import "GoodsCollectionViewCell.h"

#import "QRCodeReaderViewController.h"

#import "GenWinMallVC.h"
#import "ShopForDetailsVC.h"
#import "AboutUsVC.h"
#import "NewLatestInformationVC.h"
#import "ComplaintsSuggestionsVC.h"
#import "SweepTheYardView.h"
#import "IWantToCollectionView.h"
#import "HelpCenterVC.h"
#import "MainLoginVC.h"
#import "HomeLsitModel.h"
#import "PageModel.h"
#import "SFWeatherVC.h"
#import "UploadTheMerchantsVC.h"
#import "QRCodeResultView.h"
#import "MyOrderListVC.h"
#import "WPswView.h"
#import "PaymentListView.h"

@interface HomeVC ()
@property (strong, nonatomic) id itemsData;
/** 相当于缓存高度 不用每次 去计算*/
@property (assign, nonatomic) CGSize home_menus_size;
@property (assign, nonatomic) CGSize home_lists_size;
@property (nonatomic,strong) PaymentListView *paymentListView ;
@property (strong, nonatomic) IWantToCollectionView *wantView;
@property (strong, nonatomic) QRCodeResultView *resultView;
@property (strong, nonatomic) NSMutableArray *pageViewImagesArray;
@property (strong, nonatomic) WPswView *psw_view;
@end

@implementation HomeVC

- (NSMutableArray *)pageViewImagesArray{
    if (!_pageViewImagesArray) {
        _pageViewImagesArray = [NSMutableArray array];
    }
    return _pageViewImagesArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setLeftWithImage:@"saoyisao" action:@selector(leftClick)];
    [self setRightWithImage:@"tianqi" action:@selector(rightClick)];
    [self initCollectionView];
    [[WHC_KeyboardManager share] addMonitorViewController:self];
    
    /** 由于键盘在wiond 上 需要单独处理*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
 
//    [self loadRequsetData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isPayPssword];
    [self loadRequsetData];
}

- (void)isPayPssword{
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UserInfoManager sharedManager].isLogin) {
            if ([[UserInfoManager sharedManager].pay_password integerValue] == 0) {
                [KSTool alertViewWithController:self title:@"温馨提示" message:@"您当前还没有设置支付密码？请先设置支付密码。" items:@[@"去设置"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
                    __weak WPswView *PswView = [WPswView initBaseView];
                    PswView .frame = weakSelf.view.bounds;
                    [PswView.Btn setTitle:@"设置" forState:UIControlStateNormal];
                    [PswView baseXIB_showAlpha:.3 color:nil ];
                    PswView .base_BlockIdx = ^(NSInteger index){
                        [weakSelf setPayPassword:PswView.WPswtext.text];
                    };
                    weakSelf.psw_view = PswView;
                    
                }];
            }
            
        }
        
    });
}

- (void)setPayPassword:(NSString *)pasWord{
    [MBProgressHUD showActivityMessageInWindow:@"正在设置"];
    [KSRequestManager postRequestWithUrlString:URL_changePW parameter:@{@"ptype":@"1",@"opass":pasWord,@"npass":pasWord,@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInView:@"设置成功"];
        [self.psw_view baseXIB_removeSubView];
        [self upDataUserInfo:nil];
    } failure:^(id error) {
        
    }];
}

- (void)upDataUserInfo:(id)data{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:[[UserInfoManager sharedManager] gitUserDefaultsData]];
    [dictionary setObject:@"1" forKey:@"pay_password"];;
    [[UserInfoManager sharedManager]insterUserInfo:dictionary];
};

- (void)loadRequsetData{
 
    [KSRequestManager postRequestWithUrlString:URL_get_index_infos parameter:@{} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
//        [self setOutByFigurePageDatas:KSDIC(KSDIC(responseObject, @"data"), @"ads")];
        [self.pageViewImagesArray addObjectsFromArray:[PageModel whc_ModelWithJson:responseObject keyPath:@"ads"]];
        [self.datasMutabArray addObjectsFromArray:[HomeLsitModel whc_ModelWithJson:responseObject keyPath:@"shops"]];
        [self.collectionView reloadData];
    } failure:^(id error) {
        
    }];
}

//- (void)setOutByFigurePageDatas:(id)array{
//    self.pageViewImagesArray = array;
//}

#pragma mark -- 配置UICollectionView
- (void)initCollectionView{
    
    NSArray *cellsArray = @[@"HeaderPageCollectionViewCell",@"ItemsCollectionViewCell",@"GoodsCollectionViewCell"];
    [cellsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionView registerNib:[UINib nibWithNibName:cellsArray[idx] bundle:nil] forCellWithReuseIdentifier:obj];
    }];
    self.itemsData = @{@"image":@[@"chuangyinshangchegn",@"saomaguanzhu",@"bdsj",@"gywm",@"zxzx",@"投诉建议",@"扫码收款",@"帮助中心"],
                       @"title":@[@"创盈商城",@"扫码关注",@"本地商家",@"关于我们",@"最新资讯",@"投诉建议",@"我要收款",@"帮助中心"]};
    self.home_menus_size =  CGSizeMake(Screen_wide/4.0f , KS_H(70));
    self.home_lists_size =  CGSizeMake(Screen_wide/2 - 18, KS_H(185));
}

/** 扫一扫*/
- (void)leftClick{
    
//    _resultView =  [QRCodeResultView initBaseView];
//    _resultView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
//    [_resultView baseXIB_showAlpha:0.7 color:[UIColor lightGrayColor]];
    
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    
    reader.title = @"扫码二维码";
    reader.modalPresentationStyle = UIModalPresentationFormSheet;    
//    __weak typeof (self) wSelf = self;
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSString *headStr = [resultAsString substringToIndex:2];
        
        NSArray *arr = [resultAsString componentsSeparatedByString:@" "];
        
        if ([headStr isEqualToString:@"C1"]) {//我要收款二维码
            
            //二维码里面的内容:C1 店铺id 金额 商家id 商品名称 积分 店铺名称,(C1代表我要收款二维码 C2店铺制作的收款二维码)
            [_paymentListView baseXIB_removeSubView];
            _paymentListView = [PaymentListView initBaseView];
            _paymentListView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
            [_paymentListView baseXIB_showAlpha:0.5 color:[UIColor blackColor]];
            //赋值
            _paymentListView.storeName.text = arr[6];
            _paymentListView.shoper_id = arr[1];
            _paymentListView.goodsNameField.text = arr[4];
            _paymentListView.priceField.text = arr[2];
            _paymentListView.integral.text = arr[5];
            _paymentListView.benefit.text = @"C模式-16%";
            _paymentListView.store_id = arr[3];
            _paymentListView.vc = self;
            
            
        }else if ([headStr isEqualToString:@"C2"]){//店铺制作收款吗
            
            _resultView = [QRCodeResultView initBaseView];
            _resultView.data = resultAsString;
            _resultView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
            [_resultView baseXIB_showAlpha:0.7 color:[UIColor lightGrayColor]];
            _resultView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            
        }else{//其它
            [MBProgressHUD showSuccessMessage:@"扫描失败，请确认二维码是否正确"];
        }
//        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:reader animated:YES];

}

/** 天气*/
- (void)rightClick {
    SFWeatherVC *vc = [SFWeatherVC new];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 8;
    }else{
        return self.datasMutabArray.count;
    }
    return 11;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HeaderPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeaderPageCollectionViewCell class]) forIndexPath:indexPath];
        cell.pageView.backgroundColor =[UIColor redColor];
        cell.pageView.isWebImage = YES;
        cell.pageView.imageArray  = self.pageViewImagesArray;

        
        return cell;
    }
    else if (indexPath.section ==1){
        ItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ItemsCollectionViewCell class]) forIndexPath:indexPath];
        [cell setImagesTitleData:self.itemsData indexPath:indexPath];
        return cell;
    }else{
        GoodsCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsCollectionViewCell class]) forIndexPath:indexPath];
//        cell.backgroundColor =[UIColor redColor];
        cell.model = self.datasMutabArray[indexPath.item];
        return cell;
    }
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section ==1) {
   
        if (indexPath.item == 0) {
            //创盈商城
            GenWinMallVC *genWin = [GenWinMallVC new];
            [self.navigationController pushViewController:genWin animated:YES];
        }
        else if (indexPath.item ==1){
            // 扫码关注
            SweepTheYardView * sweep = [SweepTheYardView initBaseView];
            sweep.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
            
            [sweep baseXIB_showAlpha:.1 color:[UIColor clearColor]];
        }else if (indexPath.item ==2){
            //本地商家
            UIWindow *wiondw = [[UIApplication sharedApplication].delegate window];
            KSTabBarController * tabBarConterrller = (KSTabBarController *)wiondw.rootViewController;
            tabBarConterrller.selectedIndex = 1;
        }else if (indexPath.item ==3){
            //关于我们
            AboutUsVC *about = [AboutUsVC new];
            about.title = @"关于我们";
            [self.navigationController pushViewController:about animated:YES];
        }
        else if (indexPath.item ==4){
            //最新资讯
            NewLatestInformationVC * newLatest = [NewLatestInformationVC new];
            [self.navigationController pushViewController:newLatest animated:YES];
        }else if (indexPath.item ==5){
            //投诉建议
            ComplaintsSuggestionsVC *complaint = [ComplaintsSuggestionsVC new];
            [self.navigationController pushViewController:complaint animated:YES];
        }else if (indexPath.item == 6){
            if (![UserInfoManager sharedManager].isLogin) {
                [[UserInfoManager sharedManager] goLoginPrompt:YES];
                return;
            }
            if ([[UserInfoManager sharedManager].isshoper integerValue]== 2) {
                [MBProgressHUD showTipMessageInWindow:@"正在审核中..."];

                return;
            }
            if ([[UserInfoManager sharedManager].isshoper intValue] == 0) {
                [KSTool alertViewWithController:self title:@"温馨提示" message:@"您还不是商家，是否升级为商家？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
                    if (indx == 1) {
                        
                        UploadTheMerchantsVC *upload = [UploadTheMerchantsVC new];
                        upload.isyw = 2;
                        [self.navigationController pushViewController:upload animated:YES];
                    }
                }];
                return;
            }
            [KSRequestManager postRequestWithUrlString:@"api/shops.php?act=get_user_shops" parameter:@{@"username":[UserInfoManager sharedManager].username} success:^(id responseObject) {
                
                NSArray *arr = [[NSArray alloc]initWithArray:responseObject[@"shops"]];
                if (arr.count == 0) {
                    [MBProgressHUD showErrorMessage:@"该商家下暂无店铺"];
                    return;
                }
                //我要收款
                [_wantView baseXIB_removeSubView];
                _wantView = [IWantToCollectionView initBaseView];
                _wantView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
                [_wantView baseXIB_showAlpha:0.5 color:[UIColor blackColor]];
                _wantView.listArr = [[NSMutableArray alloc]initWithArray:arr];
                if (_wantView.listArr.count > 0) {
                    _wantView.storeName.text = arr[0][@"shop_name"];
                    _wantView.shoper_id = arr[0][@"id"];
                    NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
                    _wantView.goodsNameField.text = [uuu objectForKey:@"homeGoodName"];
                }
                
            } failure:^(id error) {
                
            }];
        }else if (indexPath.item == 7){
            //帮助中心
            HelpCenterVC *about = [HelpCenterVC new];
            [self.navigationController pushViewController:about animated:YES];

        }
    }else if (indexPath.section ==2){
        ShopForDetailsVC * shopFor = [ShopForDetailsVC new];
        HomeLsitModel *model = self.datasMutabArray[indexPath.item];
        shopFor.storeId = model.iD;
        [self.navigationController pushViewController:shopFor animated:YES];
  
    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(Screen_wide, Screen_wide *151/375);
    }else if (indexPath.section ==1){
        return self.home_menus_size;
    }
    return self.home_lists_size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 2) {
        return UIEdgeInsetsMake(12, 12, 0, 12);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 2) {
        return 12;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - 键盘监听处理 -

- (void)keyboardWillShow:(NSNotification *)notify {

    CGRect _keyboardFrame;
    NSDictionary * userInfo = notify.userInfo;
    _keyboardFrame = ((NSValue *)userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    NSLog(@"---%@",NSStringFromCGRect(_keyboardFrame));
    
    CGFloat y_H = 106;
    if (Screen_heigth == 568) {
        y_H = 90;
    }
    CGFloat y = Screen_heigth - (CGRectGetMaxY(_wantView.bgView.frame) -y_H);
    
    CGFloat keyBoadrH = CGRectGetHeight(_keyboardFrame) +44;
    
    if (keyBoadrH > y) {
        _wantView.frame = CGRectMake(0, -(keyBoadrH -y), Screen_wide, Screen_heigth);

    }
}


- (void)keyboardWillHide:(NSNotification *)notify {
    
    _wantView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
}
@end
