//
//  UnionListVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UnionListVC.h"
#import "ScreeningMenusCell.h"
#import "GoodsCollectionViewCell.h"
#import "ShopForDetailsVC.h"
@interface UnionListVC ()
@property (strong, nonatomic) ScreeningMenusCell *headerView;
@property (assign, nonatomic) NSInteger menusSelectedIndex;
@property (assign, nonatomic) CGSize home_lists_size;


@end

@implementation UnionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addHeaderView];
    [self initCollectionView];
    [self addMjRefresh];
    [self loadRequsetData];
    
    
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
    [self loadRequsetData];
}

- (void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)loadRequsetData{
    NSDictionary *dic = @{@"order":@(self.menusSelectedIndex)
                          ,@"size":@(self.size)
                          ,@"page":@(self.page)
                          ,@"shop_name":@""
                          ,@"address":self.address
                          ,@"industry":self.itemsId};
    
    [KSRequestManager postRequestWithUrlString:URL_shopslists parameter:dic success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[HomeLsitModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.collectionView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)addHeaderView{
    _headerView = [[[NSBundle mainBundle]loadNibNamed:@"ScreeningMenusCell" owner:nil options:nil]lastObject];
    _headerView.frame = CGRectMake(0, 0, Screen_wide, KS_H(44));
    [_headerView setSelectMenusButton:self.menusSelectedIndex];
    WeakSelf
    _headerView.menuClickBlock = ^(NSInteger indx){
        weakSelf.menusSelectedIndex = indx;
        [weakSelf.datasMutabArray removeAllObjects];
        [weakSelf.collectionView reloadData];
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:_headerView];

    });
}

#pragma mark -- 配置UICollectionView
- (void)initCollectionView{
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    NSArray *cellsArray = @[@"GoodsCollectionViewCell"];
    [cellsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionView registerNib:[UINib nibWithNibName:cellsArray[idx] bundle:nil] forCellWithReuseIdentifier:obj];
    }];
    self.home_lists_size =  CGSizeMake(Screen_wide/2 - 18, KS_H(185));
  
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.datasMutabArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.item];
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ShopForDetailsVC * shopFor = [ShopForDetailsVC new];
    HomeLsitModel *model = self.datasMutabArray[indexPath.item];
    shopFor.storeId = model.iD;
    [self.navigationController pushViewController:shopFor animated:YES];

}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    return self.home_lists_size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
 
    
    return UIEdgeInsetsMake(12, 12, 0, 12);
  
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(Screen_wide, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return .01;
}


@end
