//
//  KSAddressView.m
//  BigWinner
//
//  Created by kangshibiao on 2017/3/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSAddressView.h"

@implementation KSAddressView


#pragma mark -- UIPickerViewDataSource

#pragma mark -- UIPickerViewDelegate

- (void)awakeFromNib{
    [super awakeFromNib];

    [self requestManagerDataId:@"0" Array:^(NSArray *array) {
        self.province = array;
        [self.pickView reloadComponent:0];
        [self requestManagerDataId:self.province[0][@"region_id"] Array:^(NSArray *array) {
            self.city = array;
            [self.pickView reloadComponent:1];
            [self requestManagerDataId:self.city[0][@"region_id"] Array:^(NSArray *array) {
                self.area = array;
                [self.pickView reloadComponent:2];
            }];
        }];
    }];
//    
}

- (void)requestManagerDataId:(NSString *)Id Array:(void (^)(NSArray *array))array {
    
    [KSRequestManager postRequestWithUrlString:@"ajax.php?act=get_region" parameter:@{@"pid":Id} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        array(responseObject);
    } failure:^(id error) {
        
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.province.count;
    }else if (component == 1){
        return self.city.count;
    }else{
        return self.area.count;
    }
    return 10;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0 ) {
        return self.province[row][@"region_name"];
    }else if (component == 1){
        return  self.city[row][@"region_name"];
    }else{
        return self.area[row][@"region_name"];
    }
    return @"1";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [self requestManagerDataId:self.province[row][@"region_id"] Array:^(NSArray *array) {
            self.city = array;
            NSInteger index = 0;
            if (row > self.city.count - 1) {
                index = self.city.count - 1;

            }else{
                index = row;
            }
            [_pickView reloadComponent:1];
            if (self.city.count == 0) {
                self.area = nil;
                 self.city = nil;
                [_pickView reloadComponent:2];
                
            }else{
                [self requestManagerDataId:self.city[0][@"region_id"] Array:^(NSArray *array) {
                    self.area = array;
                    [_pickView reloadComponent:2];
                }];
            }
          
        }];
    }else if (component ==1){
        [self requestManagerDataId:self.city[row][@"region_id"] Array:^(NSArray *array) {
            self.area = array;
            [_pickView reloadComponent:2];
        }];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (IBAction)determine:(UIButton *)sender{
    if (sender.tag ==1 ) {
        NSString *province = [self.province objectAtIndex:[_pickView selectedRowInComponent:0]];
        NSString *city = [self.city objectAtIndex:[_pickView selectedRowInComponent:1]];
        NSString *town = [self.area objectAtIndex:[_pickView selectedRowInComponent:2]];
        _addressPickViewBlock(province,city,town);
        [self baseXIB_removeSubView];
    }
}

- (void)base_ButtonsClick:(UIButton *)sender{
    
    [self baseXIB_removeSubView];
}

@end
