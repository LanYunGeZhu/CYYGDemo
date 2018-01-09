//
//  RefundsListInfoVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefundsListModel.h"

@interface RefundsListInfoVC : KSBaseRefreshViewController

@property (nonatomic,strong) NSString *back_id ;
@property (nonatomic,strong) NSString *status ;

@property (nonatomic,strong) NSArray *receiveArr ;

@end
