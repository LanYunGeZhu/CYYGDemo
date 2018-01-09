
//
//  ProductEvaluationVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ProductEvaluationVC.h"
#import "ProductEvaluationListCell.h"
#import "ProductEvaluationModel.h"
@interface ProductEvaluationVC ()<SDPhotoBrowserDelegate>

@end

@implementation ProductEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
  
    [KSRequestManager postRequestWithUrlString:URL_appgoods parameter:@{@"goods_id":_goods_id,@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[ProductEvaluationModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"ProductEvaluationListCell"];
    self.title = @"商品评价";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductEvaluationListCell *cell = (ProductEvaluationListCell *) [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.imageView_button1 addTarget:self action:@selector(imageView_button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.imageView_button2 addTarget:self action:@selector(imageView_button1Click:) forControlEvents:UIControlEventTouchUpInside];
    cell.iamgeView_bgVIew.hidden = YES;
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductEvaluationModel *model = self.datasMutabArray[indexPath.section];
    CGSize size =[KSTool sizeWithTexte:model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide -32, MAXFLOAT)];
    // 有图片
//    return ceil(size.height) + 76 + 68;
        return ceil(size.height) + 78.0f ;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)imageView_button1Click:(UIButton*)sender{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = sender.tag;
    photoBrowser.imageCount =2;
    photoBrowser.sourceImagesContainerView =sender.superview;
    
    [photoBrowser show];
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return KSPLAIMAGE;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
//    NSString *urlStr = [[self.modelsArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    return [NSURL URLWithString:urlStr];
    return nil;
}


@end
