//
//  MyGuidePage.h
//  GuidePage
//
//  Created by mc on 15/12/24.
//  Copyright © 2015年 kangshibiao. All rights reserved.
//
#define KSWIDTH [UIScreen mainScreen].bounds.size.width
#define KSHEIGHT [UIScreen mainScreen].bounds.size.height

#define NEXTFIRST [[NSUserDefaults standardUserDefaults]objectForKey:@"GuidePage"]

#import <UIKit/UIKit.h>

@protocol MyGuidePageDelegata <NSObject>

- (void)remoeviGUidePage;


@end

@interface MyGuidePage : UIView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame arrImages:(NSArray *)images;

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIImageView * imageView;

@property (strong, nonatomic) NSArray * imagesArr;
@property (strong, nonatomic) UIPageControl * pageControl;

@property (weak, nonatomic) id <MyGuidePageDelegata> delegata;



@end
