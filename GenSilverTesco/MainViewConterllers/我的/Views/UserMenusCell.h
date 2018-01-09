//
//  UserMenusCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMenusCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (void)registCollectionViewCell;
/** */
@property (strong, nonatomic) id  itemsData;


@end
