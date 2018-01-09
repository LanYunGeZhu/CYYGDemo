//
//  IWantMenuView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWantMenuView : KSBaseXIBView
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *listArr ;
@property (nonatomic,assign) NSInteger flag ;//1选择店铺 2选择比例
- (void)registerCell;
@end
