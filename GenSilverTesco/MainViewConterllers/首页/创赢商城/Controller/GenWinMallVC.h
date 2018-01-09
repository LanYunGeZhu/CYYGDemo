//
//  GenWinMallVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavSerachViewVC.h"
@interface GenWinMallVC : BaseNavSerachViewVC<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
