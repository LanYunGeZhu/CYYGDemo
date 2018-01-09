//
//  GoodsDetailsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "GoodsDetailsVC.h"
#import "PageView.h"
#import "GoodsTitleAttributeCell.h"
#import "GoodsMenusCell.h"
#import "GoodsStoreCell.h"
#import "GoodsInfoCell.h"
#import "GoodsImageCell.h"
#import "ProductSpecificationsView.h"

#import "ProductEvaluationVC.h"
#import "EaseMessageViewController.h"
#import "PageModel.h"

#import "GoodsDetailsModel.h"
#import "ShoppingCartVC.h"
#import "ShoppingCartModel.h"
#import "SettlementConfirmationVC.h"
#import <WebKit/WebKit.h>
#import "GoodsFooterWKWebView.h"
@interface GoodsDetailsVC ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>

/** 收藏*/
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (strong, nonatomic) id data;
@property (assign, nonatomic) NSInteger staticheight;
@property (strong, nonatomic) GoodsFooterWKWebView *footerWeiView;

@property (strong, nonatomic)GoodsDetailsModel *model;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation GoodsDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.staticheight = 1;
    [self loadRequsetData];

}

- (void)loadRequsetData{

    [MBProgressHUD showActivityMessageInWindow:loadingIn];
    [KSRequestManager postRequestWithUrlString:URL_goods_info parameter:@{@"goods_id":self.goods_id,@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
     
//        NSLog(@"---%@",responseObject);
        _model = [GoodsDetailsModel whc_ModelWithJson:responseObject];
        _model.goods.isSelect_num = 1; //默认设置为 1件
        _data = responseObject;
        self.pageView.isWebImage = YES;
        
        self.pageView.imageArray =[self setPageViewModels];
        self.collectionButton.selected = [_model.goods.iscollect boolValue];

        [self addFooterView:_model.goods.goods_desc];
    } failure:^(id error) {
        if ([KSDIC(error, @"status") integerValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (NSArray *)setPageViewModels{
    NSMutableArray *array = [NSMutableArray array];
    [_model.gallery enumerateObjectsUsingBlock:^(Gallery * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PageModel *pageModel = [PageModel new];
        pageModel.ad_img = obj.img_url;
        [array addObject:pageModel];
    }];
    return array;
}

- (void)addFooterView:(NSString *)htmlString{
    WeakSelf
    self.footerWeiView = [[GoodsFooterWKWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_wide, 100)];
    self.footerWeiView.hetmlString = htmlString;
    self.footerWeiView.didFinishNavigation = ^(CGFloat height){
        weakSelf.footerWeiView.frame = CGRectMake(0, 0, Screen_wide, height);
        [weakSelf.myTableView reloadData];
        [MBProgressHUD hideHUD];
    };
    self.myTableView.tableFooterView = self.footerWeiView;
}

- (void)initTableView{
    self.title = @"商品详情";
    [self addHeaderViewPageView:CGRectMake(0, 0, Screen_wide, Screen_wide)];

    [self registerTableVieCellsArray:@[@"GoodsTitleAttributeCell",@"GoodsMenusCell",@"GoodsStoreCell",@"GoodsInfoCell",@"GoodsImageCell"]];
}


#pragma mark -- UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GoodsTitleAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsTitleAttributeCell class]) forIndexPath:indexPath];
        cell.data = _data;
        return cell;
    }else if (indexPath.section ==1 || indexPath.section ==2){
        GoodsMenusCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsMenusCell class]) forIndexPath:indexPath];
        cell.model = _model;
        cell.base_IndexPath = indexPath;
        return cell;
    }else if (indexPath.section ==3){
        GoodsStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsStoreCell class]) forIndexPath:indexPath];
        cell.model = _model;
        WeakSelf
        cell.baseCell_buttonIndex = ^(NSInteger index){
            [weakSelf contactTheMerchant];
        };
        return cell;
    }else if (indexPath.section ==4){
        GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsInfoCell class]) forIndexPath:indexPath];
        cell.contextLabel.text = @"";
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGSize size = [KSTool sizeWithTexte:@"Artka阿卡夏季女装必备款米黄修身型长袖针织外套阿卡夏季女装必备款米黄修身型长袖针织外套" font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 32, MAXFLOAT)];
        return ceil(size.height) + 76;
    }else if (indexPath.section ==1 || indexPath.section ==2 || indexPath.section ==3){
        return 44;
    }else if (indexPath.section ==4){
//        CGSize size = [KSTool sizeWithTexte:@"商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍" font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(Screen_wide - 32, MAXFLOAT)];
//        return ceil(size.height) + 72;
        return   72;

    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section ==5) {
        return 0;
    }
    return 16;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==1) {
        [self showProductView];
    }else if (indexPath.section ==2){
        ProductEvaluationVC *product = [ProductEvaluationVC new];
        product.goods_id = self.goods_id;
        [self.navigationController pushViewController:product animated:YES];
    }
}

- (void)showProductView{
    
    ProductSpecificationsView * productView= [ProductSpecificationsView initBaseView];
    productView.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
    productView.model =  _model;
    [productView registerCellItems];
    WeakSelf
    productView.base_BlockIdx = ^ (NSInteger indx){
        if (indx == 0) {
            GoodsMenusCell *cell = [weakSelf.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            cell.model = _model;
        }else if (indx == 3){
            //加入购物车
            if (![weakSelf isSpecifications]) {
                [MBProgressHUD showTipMessageInWindow:pleaseSelectACommoditySpecification];
                return;
            }
            
            [weakSelf addRequsetShoppingCart:^(id responseObject) {
                [MBProgressHUD showTipMessageInWindow:addShoopCarSuccess];

            }];
            
        }else{
            //立即购买
            [weakSelf addRequsetShoppingCart:^(id responseObject) {
                [weakSelf settlementConfirmation:[ShoppingCartModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
            }];
        }
    };
    [productView  baseXIB_showAlpha:.3 color:[UIColor lightGrayColor]];
}



#pragma mark -- 联系卖家
- (void)contactTheMerchant{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    NSLog(@"-#pragma mark -- 联系卖家-");
    EaseMessageViewController * chatController = [[EaseMessageViewController alloc]initWithConversationChatter:@"ljjxiaomi20170327" conversationType:EMConversationTypeChat];
    chatController.title = @"App客服" ;

    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark -- footerMensuClick
- (IBAction)footerMenus:(UIButton *)sender{
    
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    if (sender.tag == 0) {
        //收藏
        [self addCollectionSelect:sender];
    }else if (sender.tag ==1){
        //加入购物车
        [self showProductView];
    }else{
        //立即购买
        [self showProductView];
    }
}

- (void)addCollectionSelect:(UIButton *)sender{
    NSInteger iscollect = [_model.goods.iscollect integerValue];
    
    [KSRequestManager postRequestWithUrlString:URL_cancleCollect parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"goods_id":_model.goods.goods_id,@"ptype":@(iscollect)} success:^(id responseObject) {
        if (sender.selected) {
            [MBProgressHUD showTipMessageInWindow:@"取消收藏成功"];
        }else{
            [MBProgressHUD showTipMessageInWindow:@"收藏成功"];

        }
        sender.selected = ! sender.selected;
    } failure:^(id error) {
        
    }];
}

// 加入购物车 接口
- (void)addRequsetShoppingCart:(void(^)(id responseObject))shopCarOrder{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    [KSRequestManager postRequestWithUrlString:URL_add_to_cart parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"goods_id":_model.goods.goods_id,@"goods_number":@(_model.goods.isSelect_num),@"spec":[self getAttirString]} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        shopCarOrder(responseObject);
    } failure:^(id error) {
        
    }];
}

- (void)settlementConfirmation:(ShoppingCartModel *)model{
    model.isChoose =1;
    SettlementConfirmationVC *settlement = [SettlementConfirmationVC new];
    settlement.datasMutabArray = @[model];
    [self.navigationController pushViewController:settlement animated:YES];
}
//购物页面
- (void)buyNowShoppingCart:(id)data{
    ShoppingCartVC *shopping= [ShoppingCartVC new];
    
    [self.navigationController pushViewController:shopping animated:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];

//
    NSLog(@"---%@",NSStringFromCGSize(_footerWeiView.webView.scrollView.contentSize));



}

/** 获取 当前选择的属性 的id*/
- (NSString *)getAttirString{
    __block NSString * selectString = nil;
    [_model.attrs enumerateObjectsUsingBlock:^(Attrs * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.values enumerateObjectsUsingBlock:^(Values * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.is_select == 1) {
                if (selectString == nil) {
                    selectString = obj.iD;
                }else{
                    selectString = [NSString stringWithFormat:@"%@,%@",selectString,obj.iD];
                }
            }
        }];
    }];
    return selectString?selectString : @"";
}

// 是否选择属性
- (BOOL)isSpecifications{
    if ([[self getAttirString] isEqualToString:@""]) {
        return YES;
    }
    NSArray *ids = [[self getAttirString] componentsSeparatedByString:@","];
    if (ids.count  == _model.attrs.count) {
        
        return YES;
    }
    return NO;
}




@end
