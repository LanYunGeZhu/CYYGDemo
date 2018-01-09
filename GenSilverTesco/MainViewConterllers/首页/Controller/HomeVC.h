//
//  HomeVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : KSBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
