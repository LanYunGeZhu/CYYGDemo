//
//  KSPickView.m
//  TwinkleTwinkle
//
//  Created by kangshibiao on 16/8/28.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//


#define screen_width    [UIScreen mainScreen].bounds.size.width
#define screen_height    [UIScreen mainScreen].bounds.size.height

#define Screen_wide    [UIScreen mainScreen].bounds.size.width
#define Screen_heigth  [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r, g, b, a)         ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])


#import "KSPickView.h"

@implementation KSPickView


- (instancetype)initWithFrame:(CGRect)frame type:(PickType)type{
    
    if (self = [super initWithFrame:frame]) {
        _pickType = type;
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.pickView = [[UIPickerView alloc]init ];
    UIView * linView= [[UIView alloc]init ];
    
    if (_pickType == PickTypePickView|| _pickType == PickTypeAddressPickView)
    {
        self.pickView.frame = CGRectMake(0, Screen_heigth, Screen_wide, 180);
        linView.frame = CGRectMake(0, Screen_heigth, screen_width, 40);
        
        [UIView animateWithDuration:.3 animations:^{
            self.pickView.frame = CGRectMake(0, Screen_heigth - 180, Screen_wide, 180);
            linView.frame = CGRectMake(0, CGRectGetMinY(self.pickView.frame)-40, screen_width, 40);
        }];
        self.pickView.dataSource = self;
        self.pickView.delegate = self;
        
        self.pickView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickView];
    }
    else{
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, screen_height, screen_width, 200)];
        linView.frame = CGRectMake(0, screen_height, screen_width, 40);
        
        [UIView animateWithDuration:.3 animations:^{
            self.datePicker.frame = CGRectMake(0, Screen_heigth - 200, Screen_wide, 200);
            
            linView.frame = CGRectMake(0, CGRectGetMinY(self.datePicker.frame)-40, screen_width, 40);
        }];
        
        self.datePicker.backgroundColor = [UIColor whiteColor];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:self.datePicker];
    }
    
    linView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:linView];
    
    UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canBtn.frame = CGRectMake(0, 0, screen_width/2, 40);
    [canBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canBtn setTitleColor:RGBCOLOR(31, 183, 245, 1) forState:UIControlStateNormal];
    [canBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    canBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    canBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [canBtn addTarget:self action:@selector(canBtn) forControlEvents:UIControlEventTouchUpInside];
    [linView addSubview:canBtn];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm.frame = CGRectMake(screen_width/2, 0, screen_width/2, 40);
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    confirm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    confirm.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [confirm.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [confirm setTitleColor:RGBCOLOR(31, 183, 245, 1) forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [linView addSubview:confirm];
    if (_pickType == PickTypeAddressPickView) {
        [self addPickView];
    }
    
}

- (void)addPickView{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

#pragma mark -- UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    [self changeSpearatorLineColor];
    if (_pickType == PickTypeAddressPickView) {
        
        if (component == 0) {
            return _provinceArray[row];
        } else if (component == 1) {
            return _cityArray[row];
        } else {
            return _townArray[row];
        }
    }
    if ([[self.datasArr objectAtIndex:0]isKindOfClass:[NSArray class]]) {
        NSArray * array = self.datasArr[component];
        return array[row];
    }
    return self.datasArr[row];
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_pickType == PickTypeAddressPickView) {
        
        return 3;
    }
    if ([[self.datasArr objectAtIndex:0]isKindOfClass:[NSArray class]]) {
        return self.datasArr.count;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (_pickType == PickTypeAddressPickView) {
        if (component == 0) {
            return _provinceArray.count;
        } else if (component == 1) {
            return _cityArray.count;
        } else {
            return _townArray.count;
        }
    }
    if ([[self.datasArr objectAtIndex:0]isKindOfClass:[NSArray class]]) {
        return [self.datasArr[component] count];
    }
    return self.datasArr.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_pickType == PickTypeAddressPickView) {
        
        if (component == 0) {
            self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
            if (self.selectedArray.count > 0) {
                self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
            } else {
                self.cityArray = nil;
            }
            if (self.cityArray.count > 0) {
                self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
            } else {
                self.townArray = nil;
            }
        }
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:2];
        
        if (component == 1) {
            if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
                self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
            } else {
                self.townArray = nil;
            }
            [pickerView selectRow:1 inComponent:2 animated:YES];
        }
        
        [pickerView reloadComponent:2];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        [pickerLabel setTextColor:COLOR_text];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)show{
    
    UIView *bgView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_wide, Screen_heigth)];
    bgView.alpha = .6;
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.tag = 122;
    UIWindow * wiondw = [[UIApplication sharedApplication].delegate window];
    [wiondw addSubview:bgView];
    [wiondw addSubview:self];
}

- (void)removeSubView{
    UIWindow * wiondw = [[UIApplication sharedApplication].delegate window];
    UIView *bgView = [wiondw viewWithTag:122];
    [bgView removeFromSuperview];
    [self removeFromSuperview];
    
}

- (void)canBtn{
    [self removeSubView];
}

- (void)confirm{
    if (_pickType == PickTypePickView)
    {
        if ([[self.datasArr objectAtIndex:0] isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [NSMutableArray array];
            [self.datasArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [array addObject:@{@"idx":@([_pickView selectedRowInComponent:idx]),@"context":obj[[_pickView selectedRowInComponent:idx]]}];
            }];
            if (_blockArray) {
                _blockArray(array);
            }
        }
        else{
            NSInteger index = [self.pickView selectedRowInComponent:0];
            if (_indexBlock) {
                _indexBlock(index,self.datasArr[index]);
            }
        }
        
    }
    else if (_pickType == PickTypeAddressPickView){
        NSString *province = [self.provinceArray objectAtIndex:[_pickView selectedRowInComponent:0]];
        NSString *city = [self.cityArray objectAtIndex:[_pickView selectedRowInComponent:1]];
        NSString *town = [self.townArray objectAtIndex:[_pickView selectedRowInComponent:2]];
        _addressPickViewBlock(province,city,town);
    }
    else{
  
        if (_dataPickerBlock) {
            
            _dataPickerBlock([self gitDataString]);
        }
        
    }
    [self removeSubView];
}

- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in _pickView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = UIColorFromRGB(0x1f8bcd);//隐藏分割线
        }
    }
}


- (NSString *)gitDataString{
    
    NSDate *date = [self.datePicker date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970]*1000;
    if (self.datePicker.datePickerMode == UIDatePickerModeDateAndTime) {
        NSString * timerString = [KSTool setTimeStyle:@"yyyy-MM-dd HH:mm" timer:timeInterval];
        return timerString;

    }
    NSString * timerString = [KSTool setTimeStyle:@"yyyy-MM-dd" timer:timeInterval];
    NSLog(@"---%@",timerString);
    return timerString;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches anyObject].view != self.pickView)
    {
        [self removeSubView];
    }

  
}
@end
