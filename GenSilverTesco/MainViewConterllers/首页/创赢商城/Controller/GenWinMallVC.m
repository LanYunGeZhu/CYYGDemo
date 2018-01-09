//
//  GenWinMallVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GenWinMallVC.h"
#import "GenGoodsListCell.h"
#import "HeaderPageCollectionViewCell.h"
#import "GenWinMenusCell.h"
#import "GoodsDetailsVC.h"
#import "SearchNavView.h"
#import "MenuHeaderListView.h"
#import "MenuListModel.h"
#import "PageModel.h"
#import "GenWinMallMode.h"
@interface GenWinMallVC ()

@property (assign, nonatomic) NSInteger menusSelectedIndex;
@property (strong, nonatomic) NSMutableArray *menusArray;
@property (strong, nonatomic) GenWinMenusCell *headerView;

@property (assign, nonatomic) CGFloat header_height;

@property (strong, nonatomic)MenuListModel *model1;

@property (strong, nonatomic)MenuListModel *model2;

/** 记录上一次选中的菜单*/
@property (assign ,nonatomic) NSInteger indexPath_row;

@property (strong, nonatomic) NSArray *pageArray;
@property (strong, nonatomic) NSString *serachText;
@end

@implementation GenWinMallVC


- (void)addMjRefresh{
    self.page = 1;
    self.size = 20;
    WeakSelf
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self base_RefreshHeaderFooter:YES];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self base_RefreshHeaderFooter:NO];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.serachText = @"";
    [self initCollectionView];
    [self setLeftDefultWithNav];

    [self  addNavSerachView:CGRectMake(0, 0, Screen_wide-8, 31) isResponse:NO addressTextIco:NO];
    [self addMjRefresh];
    [self loadRequsetData];
    [self getMenusData];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.header_height =  (Screen_wide *151/375) + 12;
    WeakSelf
    
    self.serachStringBlock = ^(NSString *serachText){
        NSLog(@"---%@",serachText);
        
        [weakSelf.searchView.searchButton setTitle:[NSString stringWithFormat:@" %@",serachText] forState:UIControlStateNormal];
        weakSelf.serachText = serachText;
        [weakSelf.datasMutabArray removeAllObjects];
        [weakSelf.collectionView reloadData];
        weakSelf.page = 1;
        [weakSelf loadRequsetData];
    };

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context  {
    
    id  stirng = KSDIC(change, @"new");
    CGPoint p1 = [stirng CGPointValue];
    
    if (p1.y > self.header_height) {
        if (_headerView == nil) {
            _headerView = [[[NSBundle mainBundle]loadNibNamed:@"GenWinMenusCell" owner:nil options:nil]lastObject];
            _headerView.frame = CGRectMake(0, 0, Screen_wide, KS_H(44));
            [_headerView setSelectMenusButton:self.menusSelectedIndex];
            _headerView.model1 = _model1;
            _headerView.model2  = _model2;
            WeakSelf
            _headerView.menuClickBlock = ^(NSInteger indx){
                weakSelf.menusSelectedIndex = indx;
                [weakSelf showMensView:indx];
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

- (void)getMenusData{
    [KSRequestManager postRequestWithUrlString:URL_goods_category parameter:@{} success:^(id responseObject) {
//        NSLog(@"--%@",responseObject);
        self.menusArray = KSDIC(responseObject, @"cats");
    } failure:^(id error) {
        
    }];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    if (isHeader) {
        self.serachText  = @"";
        [self.datasMutabArray removeAllObjects];
        [self.collectionView reloadData];
        [self.searchView.searchButton setTitle:@" 搜索" forState:UIControlStateNormal];
        self.page = 1;
    }else{
        self.page ++;
    }
    [self loadRequsetData];
}

- (void)loadRequsetData{
    NSDictionary * paramter = @{@"keys":self.serachText
                                ,@"sort":_model2?_model2.iD:@""
                                ,@"cat_id":_model1?_model1.iD:@""
                                ,@"order":@""
                                ,@"size":@(self.size),
                                @"page":@(self.page)};
    [KSRequestManager postRequestWithUrlString:URL_appgoodsList parameter:paramter success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.pageArray =  [PageModel whc_ModelWithJson:responseObject keyPath:@"ads"];
        [self.datasMutabArray addObjectsFromArray:[GenWinMallMode whc_ModelWithJson:responseObject keyPath:@"goods"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(id error) {
        if ([error isKindOfClass:[NSError class]]) {
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];

        }
      
    }];
}

#pragma mark -- 配置UICollectionView
- (void)initCollectionView{
    NSArray *cellsArray = @[@"HeaderPageCollectionViewCell",@"GenGoodsListCell",@"GenWinMenusCell"];
    [cellsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionView registerNib:[UINib nibWithNibName:cellsArray[idx] bundle:nil] forCellWithReuseIdentifier:obj];
    }];

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
    if (indexPath.section == 0) {
        HeaderPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeaderPageCollectionViewCell class]) forIndexPath:indexPath];
        cell.pageView.backgroundColor =[UIColor redColor];
        cell.pageView.isWebImage = YES;
        cell.pageView.imageArray  = self.pageArray;
            
        return cell;
    }else if (indexPath.section ==1){
        GenWinMenusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GenWinMenusCell class]) forIndexPath:indexPath];
        [cell setSelectMenusButton:self.menusSelectedIndex];
        cell.model1 = _model1;
        cell.model2 = _model2;
        WeakSelf
        cell.menuClickBlock = ^(NSInteger indx){
            weakSelf.menusSelectedIndex = indx;
            [weakSelf showMensView:indx];
        };
        return cell;
    }
    else if (indexPath.section ==2){
        GenGoodsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GenGoodsListCell class]) forIndexPath:indexPath];
        cell.model =self.datasMutabArray[indexPath.item];
        return cell;
    }
    return nil;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section ==2) {
        GoodsDetailsVC *goods =[GoodsDetailsVC new];
        GenWinMallMode *model = self.datasMutabArray[indexPath.item];
        goods.goods_id = model.goods_id;
        [self.navigationController pushViewController:goods animated:YES];
    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(Screen_wide, Screen_wide *151/375);
    }else if (indexPath.section ==1){
        return CGSizeMake(Screen_wide, KS_H(44));
    }
    return CGSizeMake(Screen_wide/2.f - 18 , KS_H(211));
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

- (void)showMensView:(NSInteger)index{
      if ([self scrollColltionView])  {
        [self.collectionView setContentOffset:CGPointMake(0,  (Screen_wide *151/375) + 12) animated:YES];
          self.collectionView.mj_footer = nil;
    }
    NSMutableArray *leftArray  = [NSMutableArray array];
    NSMutableArray *rightArray  = [NSMutableArray array];

    if (index == 0) {
        [self.menusArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MenuListModel *model = [MenuListModel new];
            model.title = KSDIC(obj, @"cat_name");
            model.iD = [NSString stringWithFormat:@"%@",KSDIC(obj, @"cat_id")];
            [leftArray addObject:model];
            NSMutableArray *array = [NSMutableArray array];

             [obj[@"subs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                 MenuListModel *model1 = [MenuListModel new];
                 model1.title = KSDIC(obj1, @"cat_name");
                 model1.iD = [NSString stringWithFormat:@"%@",KSDIC(obj1, @"cat_id")];
                 [array addObject:model1];
             }];
            [rightArray addObject:array];
        }];
    }else{
        NSArray *array = @[@{@"cat_name":@"综合",@"cat_id":@"goods_id"},@{@"cat_name":@"销量",@"cat_id":@"salenum"},@{@"cat_name":@"价格",@"cat_id":@"shop_price"},@{@"cat_name":@"最新",@"cat_id":@"last_update"},@{@"cat_name":@"热搜度",@"cat_id":@"click_count"}];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MenuListModel *model = [MenuListModel new];
            model.title = KSDIC(obj, @"cat_name");
            model.iD = KSDIC(obj, @"cat_id");
            [leftArray addObject:model];
        }];
        
    }
    
    MenuHeaderListView *headeView = [MenuHeaderListView initBaseView];
    headeView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
    [headeView setTableNum:index == 0 ? tableView_Num2 : tableView_Num1];
    headeView.leftDatasArray = leftArray;
    headeView.rightDatasArray = rightArray;
    WeakSelf

    if (headeView.tableNum == tableView_Num1) {
        headeView.indexPath_row = self.indexPath_row;

        headeView.base_BlockIdx = ^(NSInteger index){
            weakSelf.model2 = leftArray[index];
//            if ([weakSelf scrollColltionView]) {
                [weakSelf addMjRefresh];
                weakSelf.indexPath_row = index;
                [weakSelf.collectionView setContentOffset:CGPointMake(0,  0) animated:YES];
                GenWinMenusCell *cell = (GenWinMenusCell *)[weakSelf.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                cell.model2 = _model2;
                [weakSelf base_RefreshHeaderFooter:YES];
//            }
            
        };
    }else{
        headeView.table_index = ^(NSInteger leftIndex,NSInteger rightindex){
            weakSelf.model1 = leftArray[index];
//            if ([weakSelf scrollColltionView]) {
                [weakSelf addMjRefresh];
                weakSelf.model1 = rightArray[leftIndex][rightindex];
                GenWinMenusCell *cell = (GenWinMenusCell *)[weakSelf.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                cell.model1 = _model1;
                [weakSelf.collectionView setContentOffset:CGPointMake(0,  0) animated:YES];
                [weakSelf base_RefreshHeaderFooter:YES];
//            }
        };
    }
 
    [headeView baseXIB_showAlpha:0 color:nil];
}

- (BOOL)scrollColltionView{
    if (self.collectionView.contentOffset.y <= (Screen_wide *151/375 +12) ) {
        return YES;
    }
    return NO;
}

- (void)dealloc{
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}



@end
