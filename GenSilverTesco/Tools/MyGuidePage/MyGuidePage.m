//
//  MyGuidePage.m
//  GuidePage
//
//  Created by mc on 15/12/24.
//  Copyright © 2015年 kangshibiao. All rights reserved.
//


#import "MyGuidePage.h"
#import "AppDelegate.h"
@implementation MyGuidePage


- (instancetype)initWithFrame:(CGRect)frame arrImages:(NSArray *)images{
    
    if (self =[super initWithFrame:frame]) {
        self.imagesArr = images;
//        self.imagesArr = @[@"hui1",@"hui2",@"hui3",@"hui4",@"hui5",@"hui6"];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSWIDTH, KSHEIGHT)];
        
        _scrollView.contentOffset = CGPointMake(0, 0);
        
        _scrollView.contentSize = CGSizeMake(KSWIDTH * self.imagesArr.count, KSHEIGHT );
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.delegate = self;
        
        _scrollView.bounces= NO;
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < self.imagesArr.count; i ++) {
            
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*KSWIDTH, 0, KSWIDTH, KSHEIGHT)];
            
            self.imageView.image = [UIImage imageNamed:self.imagesArr[i]];
            [_scrollView addSubview:self.imageView];
            self.imageView.userInteractionEnabled = YES;
            
            if (self.imagesArr.count-1 == i) {
                
                UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame = CGRectMake(0, 0, Screen_wide ,Screen_heigth);
                
                [button setTitle:@"" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
                
                [self.imageView addSubview:button];
                
            }else{
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(Screen_wide - 80, Screen_heigth - 80, 80, 80);
                [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
                [self.imageView addSubview:button];
            }
        }
    }
    
    return _scrollView;
    
}
- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, KSHEIGHT - 40, KSWIDTH, 10)];
        _pageControl.hidden = YES;
        _pageControl.numberOfPages =self.imagesArr.count;
    }
    return _pageControl;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int offset = self.scrollView.contentOffset.x / KSWIDTH;
        
    _pageControl.currentPage = offset;
    
}
- (void)next{
    
    if ([_delegata respondsToSelector:@selector(remoeviGUidePage)])
    {
        [_delegata remoeviGUidePage];
        
        NSUserDefaults * user= [NSUserDefaults standardUserDefaults];
        [user setObject:@"GuidePage" forKey:@"GuidePage"];
        [user synchronize];

    }
}

@end
