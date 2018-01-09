//
//  UnionListVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnionListVC : KSBaseRefreshViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** */
@property (copy, nonatomic) NSString *itemsId;
/** */
@property (copy, nonatomic) NSString *address;



@end
