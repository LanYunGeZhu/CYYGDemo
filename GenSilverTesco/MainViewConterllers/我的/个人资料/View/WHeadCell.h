//
//  wHeadCell.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WInfomationModel.h"

@interface WHeadCell : KSBaseTableViewCell

@property (nonatomic,weak)IBOutlet UILabel *nickName;
@property (nonatomic,weak)IBOutlet UILabel *cheK;
@property (nonatomic,weak)IBOutlet UIButton *checkIde;

@property (nonatomic,strong) WInfomationModel *infoModol;

@property (nonatomic,assign)NSInteger tag;

@end
