//
//  GenWinMenusCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuListModel.h"
@interface GenWinMenusCell : UICollectionViewCell
/** */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray <UIButton *> *menusButton;

/** */
@property (copy, nonatomic) void(^menuClickBlock)(NSInteger index);


- (void)setSelectMenusButton:(NSInteger)index;
/** */
@property (strong, nonatomic) MenuListModel *model1;
/** */
@property (strong, nonatomic) MenuListModel *model2;




@end
