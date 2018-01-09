//
//  CustomAnnotationView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *calloutView;

@end
