//
//  ProductSpecificationsView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
@interface ProductSpecificationsView : KSBaseXIBView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** */
@property (weak, nonatomic) IBOutlet UITextField *textField;
/** */
@property (weak, nonatomic) IBOutlet UICollectionView * collectionView;

/** 数据源*/
@property (strong, nonatomic) NSMutableArray *datasArray;

/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_collectionView_height;
/** */
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_collection_bomttom;
/** 已经选 */
@property (weak, nonatomic) IBOutlet UILabel *theSelectedNum;
/** 剩余件数*/
@property (weak, nonatomic) IBOutlet UILabel *withMoreThanTheNumber;
/** 价钱*/
@property (weak, nonatomic) IBOutlet UILabel *price;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;

/** */
@property (strong, nonatomic) GoodsDetailsModel *model;



- (void)registerCellItems;
@end
