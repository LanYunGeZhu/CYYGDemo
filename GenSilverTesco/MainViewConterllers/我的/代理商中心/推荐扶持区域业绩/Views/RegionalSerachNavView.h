//
//  RegionalSerachNavView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionalSerachNavView : KSBaseXIBView<UISearchBarDelegate>
/** */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *views;
/** */
@property (weak, nonatomic) IBOutlet UISearchBar *serachBar;
/** */
@property (weak, nonatomic) IBOutlet UIButton *selectData;
/** */
@property (copy, nonatomic) void(^searchBlick)(NSString *serachString);


@end
