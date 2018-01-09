//
//  InformationdetailsVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewLatestModel.h"
@interface InformationdetailsVC : KSBaseRefreshViewController

/** */
@property (strong, nonatomic) NewLatestModel *model;
/**<#name#>*/
@property (assign, nonatomic) NSInteger newLitsType;


@end
