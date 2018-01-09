//
//  CustomAnnotationView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
    _name = name;
    CGSize size = [KSTool sizeWithTexte:self.name font:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(Screen_wide, 30)];
    UIImage *imageName = [UIImage imageNamed:@"dingdd"];

    self.nameLabel.frame = CGRectMake(0, 0, ceil(size.width) +10, 20);
    self.portraitImageView.frame = CGRectMake((_nameLabel.frame.size.width)/ 2.0f - (imageName.size.width / 2), 24, imageName.size.width, imageName.size.height);
    self.bounds = CGRectMake(0.f, 0.f, ceil(size.width) +10, 24 + imageName.size.height );

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {

        UIImage *imageName = [UIImage imageNamed:@"dingdd"];
        CGSize size = [KSTool sizeWithTexte:self.name font:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(Screen_wide, 30)];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ceil(size.width) +10, 20)];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = UIColorFromRGB(0xE3141E);
        self.nameLabel.font             = [UIFont systemFontOfSize:11.f];
        self.nameLabel.text             = self.name;
        self.nameLabel.backgroundColor  = RGBCOLOR(255, 0, 0, .1);
        [self.nameLabel.layer setCornerRadius:5];
        [self.nameLabel.layer setBorderWidth:1];
        [self.nameLabel.layer setBorderColor:UIColorFromRGB(0xE3141E).CGColor];
        
        [self addSubview:self.nameLabel];
        
        self.portraitImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_nameLabel.frame.size.width)/ 2.0f - (imageName.size.width / 2), 24, imageName.size.width, imageName.size.height)];
        
        self.portraitImageView.image = [UIImage imageNamed:@"dingdd"];

        [self addSubview:self.portraitImageView];
    }
    
    return self;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
////    if (self.selected == selected)
////    {
////        return;
////    }
//    
////    if (selected)
////    {
////        if (self.calloutView == nil)
////        {
////            /* Construct custom callout. */
////            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
////            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
////                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
////            
////            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////            btn.frame = CGRectMake(10, 10, 40, 40);
////            [btn setTitle:@"Test" forState:UIControlStateNormal];
////            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
////            [btn setBackgroundColor:[UIColor whiteColor]];
////            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
////            
////            [self.calloutView addSubview:btn];
////            
////            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
////            name.backgroundColor = [UIColor clearColor];
////            name.textColor = [UIColor whiteColor];
////            name.text = @"Hello Amap!";
////            [self.calloutView addSubview:name];
////        }
////        
////        [self addSubview:self.calloutView];
////    }
////    else
////    {
////        [self.calloutView removeFromSuperview];
////    }
//    
//    [super setSelected:selected animated:animated];
//}
//
//
//- (void)setSelected:(BOOL)selected{
//    NSLog(@"sdf");
//    [self setSelected:selected animated:NO];
//
//}
//
////- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
////{
////    BOOL inside = [super pointInside:point withEvent:event];
////    /* Points that lie outside the receiver’s bounds are never reported as hits,
////     even if they actually lie within one of the receiver’s subviews.
////     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
////     */
//////    if (!inside && self.selected)
//////    {
//////        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
//////    }
////    
////    return inside;
////}
//
@end
