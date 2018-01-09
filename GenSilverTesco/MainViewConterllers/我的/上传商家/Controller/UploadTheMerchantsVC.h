//
//  UploadTheMerchantsVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadTheMerchantsVC : KSBaseRefreshViewController

/** isyw:1:业务员  0：代理商  2 添加店铺*/
@property (assign, nonatomic) NSInteger isyw;

@property (copy, nonatomic) void(^updataSuccess)();

@end
