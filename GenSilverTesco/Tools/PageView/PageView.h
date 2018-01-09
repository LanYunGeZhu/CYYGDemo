//
//  PageView.h
//  05-图片轮播器
//
//  Created by 柒月丶 on 15-8-6.
//  Copyright (c) 2015年 柒月丶. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SDPhotoBrowser.h"
@protocol PageViewDelegate <NSObject>

- (void)didSelectPageViewWithNumber:(NSInteger)selectNumber;

@end


@interface PageView : UIView

@property (nonatomic, strong,nullable) NSArray * imageArray;

@property (nonatomic ,assign) NSTimeInterval duration;
@property (nonatomic ,strong,nullable) NSTimer *timer;

@property (nonatomic ,assign) BOOL isWebImage;

@property (nonatomic, nullable) NSMutableArray *imageViewArray;

-(nullable instancetype)initPageViewFrame:(CGRect)frame;

@property (nonatomic ,weak)  id< PageViewDelegate> delegate;

@end
