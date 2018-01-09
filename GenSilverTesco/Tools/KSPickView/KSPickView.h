//
//  KSPickView.h
//  TwinkleTwinkle
//
//  Created by kangshibiao on 16/8/28.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^indexBlock)(NSInteger index,NSString *context);
typedef NS_OPTIONS (NSInteger,PickType) {
    PickTypePickView,
    PickTypeDataPicker,
    PickTypeAddressPickView
};

@interface KSPickView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame type:(PickType)type;
@property (strong,nonatomic) UIPickerView *pickView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSArray *datasArr;

//回传 选中的索引 pickView
@property (copy,nonatomic)indexBlock indexBlock;

//单个pick回调
@property (copy, nonatomic) void((^ dataPickerBlock)(NSString *timer));

/** 预约看房 单独block*/
@property (copy, nonatomic) void(^blockArray)(NSArray *array);

@property (copy, nonatomic) void (^addressPickViewBlock)(NSString *province,NSString *city,NSString *arer);

@property (assign, nonatomic) PickType pickType;


@property(nonatomic,strong)NSDictionary *pickerDic;
@property(nonatomic,strong)NSArray *provinceArray;
@property(nonatomic,strong)NSArray *selectedArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSArray *townArray;
- (void)show;
@end
