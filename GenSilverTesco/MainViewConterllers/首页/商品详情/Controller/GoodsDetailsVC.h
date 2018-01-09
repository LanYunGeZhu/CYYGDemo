//
//  GoodsDetailsVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/12.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailsVC : KSBaseRefreshViewController<UITableViewDelegate,UITableViewDataSource>
/** */
@property (copy, nonatomic) NSString *goods_id;


@end
