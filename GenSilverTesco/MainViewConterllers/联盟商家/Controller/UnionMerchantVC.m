//
//  UnionMerchantVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UnionMerchantVC.h"
#import "GoodsCollectionViewCell.h"
#import "GenWinMenusCell.h"
#import "ScreeningMenusCell.h"
#import "GoodsCollectionViewCell.h"
#import "ItemsCollectionViewCell.h"
#import "SearchNavView.h"
#import "UnionListVC.h"
#import "ShopForDetailsVC.h"
#import "UnionMerchantModel.h"
#import "HomeLsitModel.h"
#import "KSPickView.h"
#import "KSAddressView.h"
#import "KSCLLocationManager.h"
#import "UnionItemsCollectionViewCell.h"
@interface UnionMerchantVC ()
@property (assign, nonatomic) NSUInteger menusSelectedIndex;

/** 相当于缓存高度 不用每次 去计算*/
@property (assign, nonatomic) CGSize home_menus_size;
@property (assign, nonatomic) CGSize home_lists_size;

@property (strong, nonatomic) id itemsData;

@property (strong, nonatomic) ScreeningMenusCell *headerView;

@property (assign, nonatomic) CGFloat header_height;
@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) NSString *serachText;

@property (strong, nonatomic) NSArray <UnionMerchantModel *> *mensuItemsArray;

@property (strong, nonatomic) dispatch_group_t dispatch_group;
@end

@implementation UnionMerchantVC

- (dispatch_group_t)dispatch_group{
    if (_dispatch_group == nil) {
        _dispatch_group =  dispatch_group_create();
    }
    return _dispatch_group;
}
- (void)setLeftDefultWithNav{};


- (void)viewDidLoad {
    [super viewDidLoad];
    self.serachText = @"";
    self.address = @"";
    [self initCollectionView];
    [self addNavSerachView:CGRectMake(0, 0, Screen_wide, 31) isResponse:NO addressTextIco:YES];
    WeakSelf
    self.searchView.base_BlockIdx = ^(NSInteger index){
        [weakSelf showMensuAddress];
    };
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.header_height = (KS_H(70)*2 +12.0f);

    self.serachStringBlock = ^(NSString *serachText){
        NSLog(@"---%@",serachText);
        
        [weakSelf.searchView.searchButton setTitle:[NSString stringWithFormat:@" %@",serachText] forState:UIControlStateNormal];
        weakSelf.page = 1;
        weakSelf.size = 20;
        weakSelf.serachText = serachText;
        [weakSelf.datasMutabArray removeAllObjects];
        [weakSelf.myTableView reloadData];
        [weakSelf loadRequsetData];
    };
    [self loadRequsetData];
    [self addMjRefresh];
    [self loadCLLocation];
    [self loadItemsColltionView];

}

- (void)loadItemsColltionView{
    [KSRequestManager postRequestWithUrlString:URL_get_industry parameter:@{@"limit":@0} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.mensuItemsArray = [UnionMerchantModel whc_ModelWithJson:responseObject keyPath:@"lists"];
        [self.collectionView reloadData];

    } failure:^(id error) {

    }];
}

- (void)loadCLLocation{
    WeakSelf
    KSCLLocationManager * manager = [KSCLLocationManager shareManager];
    manager.isCity = YES;
    manager.locationBlock = ^(CLLocation *loction,id locality){
//        AMapLocationReGeocode * regocdeo = locality;
//        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",regocdeo.province,regocdeo.city,regocdeo.district];
        NSString *state=KSDIC(locality, @"State");
        
        NSString *city= KSDIC(locality, @"City");
        
        NSString *subLocality=KSDIC(locality, @"SubLocality");
        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];
//
        weakSelf.searchView.textAddress.text = subLocality;
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    [manager start];
}

- (void)showMensuAddress{
    WeakSelf

    KSAddressView *addressView = [KSAddressView initBaseView];
    addressView.frame = [UIScreen mainScreen].bounds;
    addressView.addressPickViewBlock = ^(id province,id city,id arer){
        weakSelf.searchView.textAddress.text = KSDIC(arer, @"region_name");
        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",KSDIC(province, @"region_name"),KSDIC(city, @"region_name"),KSDIC(arer, @"region_name")];
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    [addressView baseXIB_showAlpha:.3 color:nil];
}

- (void)addMjRefresh{
    WeakSelf
    self.page = 1;
    self.size = 20;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf base_RefreshHeaderFooter:YES];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf base_RefreshHeaderFooter:NO];
    }];

}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];

    if (isHeader) {
        self.serachText = @"";
        [self.searchView.searchButton setTitle:[NSString stringWithFormat:@" 搜索"] forState:UIControlStateNormal];

    }
    [self loadRequsetData];
    
}

- (void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_shopslists parameter:@{@"order":@(self.menusSelectedIndex),@"size":@(self.size),@"page":@(self.page),@"shop_name":_serachText,@"address":self.address,@"industry":@"0"} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[HomeLsitModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.collectionView reloadData];
        [self endRefresh];
    } failure:^(id error) {

    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context  {
  
    id  stirng = KSDIC(change, @"new");
    CGPoint p1 = [stirng CGPointValue];
    
    if (p1.y > self.header_height) {
        if (_headerView == nil) {
            _headerView = [[[NSBundle mainBundle]loadNibNamed:@"ScreeningMenusCell" owner:nil options:nil]lastObject];
            _headerView.frame = CGRectMake(0, 0, Screen_wide, KS_H(44));
            [_headerView setSelectMenusButton:self.menusSelectedIndex];
            WeakSelf
            _headerView.menuClickBlock = ^(NSInteger indx){
                weakSelf.menusSelectedIndex = indx;
                [weakSelf base_RefreshHeaderFooter:YES];
            };
            [self.view addSubview:_headerView];
        }
    }
    if (p1.y <self.header_height) {
        if (_headerView) {
            [_headerView removeFromSuperview];
            _headerView = nil;
        }
    }
}

#pragma mark -- 配置UICollectionView
- (void)initCollectionView{
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    NSArray *cellsArray = @[@"ScreeningMenusCell",@"ItemsCollectionViewCell",@"GoodsCollectionViewCell",@"UnionItemsCollectionViewCell"];
    [cellsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionView registerNib:[UINib nibWithNibName:cellsArray[idx] bundle:nil] forCellWithReuseIdentifier:obj];
    }];
    self.home_menus_size =  CGSizeMake(Screen_wide, KS_H(140) +1);
    self.home_lists_size =  CGSizeMake(Screen_wide/2 - 18, KS_H(185));
    self.itemsData = @{@"image":@[@"家居建材",@"食品餐饮",@"美容护肤",@"服饰饰品",@"汽车汽贸",@"家用电器",@"生活用品",@"帮助中心"],
                       @"title":@[@"家居建材",@"食品餐饮",@"美容护肤",@"服饰饰品",@"汽车汽贸",@"家用电器",@"生活用品",@"汽车用品"]};
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 1;
    }else{
        return self.datasMutabArray.count;
    }
    return 11;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (indexPath.section ==0){
        
        UnionItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UnionItemsCollectionViewCell class]) forIndexPath:indexPath];
        
        cell.mensuItemsArray = self.mensuItemsArray;
        cell.collectionViewDidSelectItemAtIndexPath = ^(NSIndexPath *indexPath){
            [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        };
        return cell;
    }else if (indexPath.section ==1){
        ScreeningMenusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScreeningMenusCell class]) forIndexPath:indexPath];
        [cell setSelectMenusButton:self.menusSelectedIndex];
        WeakSelf
        cell.menuClickBlock = ^(NSInteger indx){
            weakSelf.menusSelectedIndex = indx;
            [weakSelf base_RefreshHeaderFooter:YES];
        };
        return cell;
    }
    else if (indexPath.section ==2){
        GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsCollectionViewCell class]) forIndexPath:indexPath];
        cell.model = self.datasMutabArray[indexPath.item];
        return cell;
    }
    return nil;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        UnionListVC * unionList = [UnionListVC new];
        UnionMerchantModel * model = self.mensuItemsArray[indexPath.item];
        unionList.itemsId = model.iD;
        unionList.address = _address;
        unionList.title = model.title;
        [self.navigationController pushViewController:unionList animated:YES];
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
        return self.home_menus_size;
    }else if (indexPath.section ==1){
        return CGSizeMake(Screen_wide, KS_H(44));
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return CGSizeMake(Screen_wide, 12);
    }
    return CGSizeZero;
}



@end
