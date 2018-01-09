//
//  FoundStoreInfoView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundStoreInfoView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UIView *bgView;
/** 店铺头像 */
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
/** 店铺名称*/
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 店铺电话*/
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 店铺地址*/
@property (weak, nonatomic) IBOutlet UILabel *address;
/** 距离 */
@property (weak, nonatomic) IBOutlet UILabel *distance;
//店长
@property (weak, nonatomic) IBOutlet UILabel *linkman;
/** 默认 420 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_bgView_height;

@property (nonatomic,strong) UIViewController *vc ;
@property (nonatomic,strong) NSDictionary *dataDic ;
@end
