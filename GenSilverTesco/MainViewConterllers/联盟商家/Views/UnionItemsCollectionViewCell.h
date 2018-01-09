//
//  UnionItemsCollectionViewCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnionItemsCollectionViewCell : UICollectionViewCell

/** */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** 相当于缓存高度 不用每次 去计算*/
@property (assign, nonatomic) CGSize home_menus_size;

/** */
@property (strong, nonatomic) NSArray *mensuItemsArray;

/** */
@property (copy, nonatomic) void(^collectionViewDidSelectItemAtIndexPath)(NSIndexPath *indexPath);



@end
