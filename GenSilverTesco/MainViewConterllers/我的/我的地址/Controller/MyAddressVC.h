//
//  MyAddressVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressModel.h"

@interface MyAddressVC : KSBaseRefreshViewController
/** isAddress 点击列表 编辑 1  选择*/
@property (assign, nonatomic) NSInteger isAddress;
/** */
@property (strong, nonatomic) void(^selectListModel)(MyAddressModel *model);




@end
