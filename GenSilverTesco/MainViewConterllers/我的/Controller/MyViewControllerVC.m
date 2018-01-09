//
//  MyViewControllerVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyViewControllerVC.h"
#import "IntegralCell.h"
#import "MyHeaderView.h"
#import "MerchantsCell.h"
#import "MyOrderCell.h"
#import "UserMenusCell.h"

#import "UIImageView+Kiwi.h"
#import "WHeadImageVC.h"
#import "MyOrderListVC.h"
#import "WScoreVC.h"
#import "WShareView.h"
#import "WRechargeVC.h"
#import "WWithDrawVC.h"
#import "WMakeOrderVC.h"
#import "LocalCustomerServiceView.h"
#import "LogOutCell.h"
#import "MainLoginVC.h"
#import "WInfomationModel.h"
#import "UploadTheMerchantsVC.h"
@interface MyViewControllerVC ()<UINavigationControllerDelegate>
{
    WInfomationModel *model;
    NSString *baseUrl;


}


@property (strong, nonatomic)  MyHeaderView *headerView;
@property (strong, nonatomic)  WShareView *shareView;
@property (strong, nonatomic) LogOutCell *logOutfooterView;
@property (strong, nonatomic) NSMutableDictionary *itemsData;
@property (strong, nonatomic) id orderNumData;

@end

@implementation MyViewControllerVC

- (LogOutCell *)logOutfooterView{
    if (_logOutfooterView == nil) {
        _logOutfooterView = [[[NSBundle mainBundle]loadNibNamed:@"LogOutCell" owner:nil options:nil]lastObject];
        _logOutfooterView.frame = CGRectMake(0, 0, Screen_wide, 70.0f);
        [_logOutfooterView.logOut addTarget:self action:@selector(logOutClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logOutfooterView;
}

- (void)setLeftDefultWithNav{};
- (void)logOutClick{
    NSLog(@"dsf");
    [KSTool alertViewWithController:self title:@"温馨提示" message:@"您确定要退出登录吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
        if (indx == 1) {
            [KSRequestManager postRequestWithUrlString:URL_logout parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
                [[UserInfoManager sharedManager] removeUserInfoData];
                [self.navigationController presentViewController:[[KSNavigationController alloc] initWithRootViewController: [MainLoginVC new]] animated:YES completion:nil];
            } failure:^(id error) {
                
            }];
        }
    }];
}

- (void)getUserOrderNum{
    [KSRequestManager postRequestWithUrlString:URL_user_orders_stats parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.orderNumData = responseObject;
        [self.myTableView reloadData];

    } failure:^(id error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![UserInfoManager sharedManager].isLogin) {
        self.tabBarController.selectedIndex = 0;
    }
    else{
        [self WloadImage];
        [self loadRequsetData];
        [self userTypeData];
        [self getUserOrderNum];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)userTypeData{
    if ([[UserInfoManager sharedManager].isshoper integerValue] == 1) {
        _headerView.frame = CGRectMake(0, 0, Screen_wide, 135.0f);
        _headerView.menuBgView.hidden = NO;

    }else{
        _headerView.frame = CGRectMake(0, 0, Screen_wide, 91);
        [_headerView hiddenMenusCustomer];

    }
    _itemsData = [@{@"image":[@[@"购物车",@"我的收藏",@"积分换购",@"个人账户",@"代理商中心",@"商家中心",@"我要分享",@"业务员中心",@"本地客服",@"我的评论",@"tuikuan"]mutableCopy],
                    @"title":[@[@"我的购物车",@"我的收藏",@"积分换购",@"个人账户",@"代理商中心",@"商家中心",@"我的分享",@"业务员中心",@"本地客服",@"我的评价",@"退货退款"]mutableCopy]} mutableCopy];
    if ([[UserInfoManager sharedManager].isagent integerValue] == 0) {
        [self userDeleteItmesData:@"代理商中心"];
    }
    else{
        if ([UserInfoManager sharedManager].isshoper == 0) {
            [self userDeleteItmesData:@"商家中心"];
        }
    }
    if ([[UserInfoManager sharedManager].oper_agent_id integerValue] == 0) {
        [self userDeleteItmesData:@"业务员中心"];
    }else{
        if ([UserInfoManager sharedManager].isshoper == 0) {
            [self userDeleteItmesData:@"商家中心"];
        }
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myTableView.tableHeaderView = _headerView;
        self.myTableView.tableFooterView = self.logOutfooterView;
    });
}

- (void)userDeleteItmesData:(NSString *)titleString{
    NSMutableArray *arrayImages = _itemsData[@"image"];
    [arrayImages removeObject:titleString];
    NSMutableArray *arrayTitles = _itemsData[@"title"];
    [arrayTitles removeObject:titleString];
}

- (void)initTableView{
    [self registerTableVieCellsArray:@[@"IntegralCell",@"MerchantsCell",@"MyOrderCell",@"UserMenusCell"]];
    
    _headerView = [MyHeaderView initBaseView];
    _shareView  = [WShareView initBaseView];
    
    _shareView.frame = CGRectMake(0, 20, Screen_wide,Screen_heigth);

    _headerView.headerImageView.userInteractionEnabled = YES;
    WeakSelf
    _headerView.base_BlockIdx = ^(NSInteger index){
        
        switch (index) {
            case 0:
            {
                WScoreVC *score = [WScoreVC new];
                [weakSelf.navigationController pushViewController:score animated:YES];
            }
                break;
            case 1:
            {
                [KSTool showKey:weakSelf.shareView.TView];

                if (weakSelf.shareView.isHidden == NO)
                {
                    [weakSelf.view.window addSubview:weakSelf.shareView];
                }
                else
                {
                    [weakSelf.shareView setHidden:NO];
                }
             }
                break;
            case 2:
            {
                WRechargeVC *rechargeVC = [WRechargeVC new];
                [weakSelf.navigationController pushViewController:rechargeVC animated:YES];
            }
                break;

            case 3:
            {
                WWithDrawVC *DrawVC = [WWithDrawVC new];
                [weakSelf.navigationController pushViewController:DrawVC animated:YES];
            }
                break;
            case 4:
            {
                WMakeOrderVC *makeVc = [WMakeOrderVC new];
                [weakSelf.navigationController pushViewController:makeVc animated:YES];
            }
                break;

            default:
                break;
        }
        
    };
    
    _shareView.delegate = self;
    _shareView.base_BlockIdx = ^(NSInteger index)
    {
        switch (index) {
           
            case 4:
            {
                [weakSelf.shareView setHidden:YES];
            }
                break;
           
            default:
                break;
        }
    };
    
    [_headerView.headerImageView addClickMethod:^(UIImageView *wImageView) {
        WHeadImageVC *headImage = [WHeadImageVC new];
        headImage.url = baseUrl;
        [weakSelf.navigationController pushViewController:headImage animated:YES];
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([[UserInfoManager sharedManager].user_type integerValue] == 1) {
        return 4;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf
    NSInteger user_section = 0;
    if ([[UserInfoManager sharedManager].user_type integerValue] == 1) {
        user_section = 0;
    }else{
        user_section =1;
    }
    
    if (indexPath.section == 0) {
        IntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    else if (indexPath.section == 2 - user_section){
     
        MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell" forIndexPath:indexPath];
        if (_orderNumData) {
            cell.data =_orderNumData;
        }
        cell.baseCell_buttonIndex = ^(NSInteger index){
            [weakSelf myOrderClick:index];
        };
        return cell;
    }else if (indexPath.section ==3 -user_section){
        UserMenusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserMenusCell" forIndexPath:indexPath];
        cell.itemsData = self.itemsData;
        cell.baseCell_buttonIndex = ^( NSInteger index){
            [weakSelf myMenusIndex:index];
        };
        [cell registCollectionViewCell];
        return cell;
    }
    else {
        //商家中心
        MerchantsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantsCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    return nil;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UserInfoManager sharedManager].user_type integerValue] == 1) {
        return indexPath.section == 3 ? 287 : 90;
    }
    return indexPath.section == 2 ? 287 : 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

#pragma mark -- 我的订单 待收货 带付了。。。。。
- (void)myOrderClick:(NSInteger)index{

    MyOrderListVC *myOder= [MyOrderListVC new];
    myOder.index = index;
    [self.navigationController pushViewController:myOder animated:YES];
}

#pragma mark -- 我的购物车 我的收藏 等等
- (void)myMenusIndex:(NSInteger)index{
    NSDictionary *dicViewContrellers = @{@"我的购物车":@"ShoppingCartVC"
                                        ,@"我的收藏":@"SFMyCollectVC"
                                        ,@"积分换购":@"PointsRedemptionVC"
                                        ,@"个人账户":@"PersonalAccountVC"
                                        ,@"代理商中心":@"AgentCenterVC"
                                        ,@"我的分享":@"SFMyShareVC"
                                        ,@"本地客服":@"LocalCustomerServiceView"
                                        ,@"我的评价":@"SFMyAppraiseVC"
                                        ,@"退货退款":@"RefundsListVC"
                                        ,@"业务员中心":@"SalesCenterVC"
                                        ,@"商家中心":@"BusinessCenterVC"};
    
    
    NSString *keyTitle = _itemsData[@"title"][index];
    if ([dicViewContrellers[keyTitle] isEqualToString:@"LocalCustomerServiceView"]) {
        [self showLocalCustomerServiceView];
        return;
    }
    
    if ([dicViewContrellers[keyTitle] isEqualToString:@"BusinessCenterVC"]) {
        if ([[UserInfoManager sharedManager].isshoper integerValue]== 2) {
            [MBProgressHUD showTipMessageInWindow:@"正在审核中..."];
            
            return;
        }
        if ([[UserInfoManager sharedManager].isshoper isEqualToString:@"0"]) {
            [KSTool alertViewWithController:self title:@"温馨提示" message:@"您还不是商家，完善资料后可申请商家，确定申请吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
                if (indx == 1) {
                    UploadTheMerchantsVC *upload = [UploadTheMerchantsVC new];
                    upload.isyw = 2;
                    [self.navigationController pushViewController:upload animated:YES];
                }
            }];
            return;
        }
    }

    
    UIViewController *classVC = [NSClassFromString(dicViewContrellers[keyTitle]) new];
    [self.navigationController pushViewController:classVC animated:YES];
    return;
}

- (void)showLocalCustomerServiceView{
    LocalCustomerServiceView *serviceView = [LocalCustomerServiceView initBaseView];
    serviceView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
    [serviceView baseXIB_showAlpha:0.4 color:nil];
}

- (void)loadRequsetData{
    
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    [KSRequestManager postRequestWithUrlString:URL_appinfomation parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if(KSDIC(responseObject, @"user") )
        {
            [self upDataUserInfo:KSDIC(responseObject, @"user")];
            model = [WInfomationModel whc_ModelWithJson:responseObject keyPath:@"user"];
            [[NSUserDefaults standardUserDefaults]setObject:KSDIC(KSDIC(responseObject, @"user"), @"user_name") forKey:@"user_name"];
            [[NSUserDefaults standardUserDefaults]synchronize ];
            _headerView.nameLabel.text = model.alias.length == 0?StringWithStr(@"用户",model.user_id):model.alias;
            [self.myTableView reloadData];
        }
        
    } failure:^(id error) {
        
    }];
}

- (void)upDataUserInfo:(id)data{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:[[UserInfoManager sharedManager] gitUserDefaultsData]];
    [dictionary setObject:KSDIC(data, @"user_type") forKey:@"user_type"];;
    [dictionary setObject:KSDIC(data, @"isshoper") forKey:@"isshoper"];;
    [dictionary setObject:KSDIC(data, @"isagent") forKey:@"isagent"];
    [dictionary setObject:KSDIC(data, @"oper_agent_id") forKey:@"oper_agent_id"];;
    [[UserInfoManager sharedManager]insterUserInfo:dictionary];
}

- (void)WloadImage{
    
    [KSRequestManager postRequestWithUrlString:URL_appinfoImage parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if(![KSDIC(responseObject, @"headimg") isEqualToString:@""])
        {
             [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL, KSDIC(responseObject, @"headimg"))] ];
            baseUrl = StringWithStr(URL_MANURL, KSDIC(responseObject, @"headimg"));
        }
        
    } failure:^(id error) {
        
    }];
}

@end
