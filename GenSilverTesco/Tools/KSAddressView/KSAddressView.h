//
//  KSAddressView.h
//  BigWinner
//
//  Created by kangshibiao on 2017/3/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KSAddressView : KSBaseXIBView<UIPickerViewDelegate,UIPickerViewDataSource>
/** */
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

/** 省 */
@property (strong, nonatomic) NSArray * province;
/** 市 */
@property (strong, nonatomic) NSArray * city;
/** 区 */
@property (strong, nonatomic) NSArray *area;

@property (copy, nonatomic) void (^addressPickViewBlock)(id province,id city,id arer);



@end
