//
//  UnionItemsCollectionViewCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UnionItemsCollectionViewCell.h"
#import "ItemsCollectionViewCell.h"
@implementation UnionItemsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.home_menus_size =  CGSizeMake(Screen_wide/4.0f , KS_H(70));
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ItemsCollectionViewCell"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}

- (void)setMensuItemsArray:(NSArray *)mensuItemsArray{
    _mensuItemsArray = mensuItemsArray;
     self.collectionView.pagingEnabled = YES;
    [self.collectionView reloadData];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
      return self.mensuItemsArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    ItemsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ItemsCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.model = self.mensuItemsArray[indexPath.item];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_collectionViewDidSelectItemAtIndexPath) {
        _collectionViewDidSelectItemAtIndexPath(indexPath);
    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.home_menus_size;
 
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeZero;
}

@end
