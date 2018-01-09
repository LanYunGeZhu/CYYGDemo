//
//  AgentHeaderView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "AgentHeaderView.h"
#import "UIImage+ImageEffects.h"

@implementation AgentHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
//    self.bgImageView.image = [[UIImage imageNamed:@"IMG_0014"] blurImage];
    
    [self setViewCornerRadiusViews:@[self.headerImageView] floatCoriner:40.0f];
}

- (void)setData:(id)data{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(data, @"headimg")]] placeholderImage:KSPLAIMAGE ];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(self.data, @"face_card")]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.bgImageView.image = [[self OriginImage:image scaleToSize:CGSizeMake(self.frame.size.width, self.frame.size.height)] blurImage];
                
            }
        });
    });
//    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(data, @"headimg")]] placeholderImage:KSPLAIMAGE ];
    if ([KSDIC(data, @"month_rl_money") isEqualToString:@""]) {
        
        self.browseTheNumber.text = @"0";
    }else{
        self.browseTheNumber.text = [NSString stringWithFormat:@"%@",KSDIC(data, @"month_rl_money")];

    }
    self.theOrderAmount.text = [NSString stringWithFormat:@"%@",KSDIC(data, @"total_amount")];
    self.orderNumber.text = [NSString stringWithFormat:@"%@",KSDIC(data, @"today_orders")];

}


-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)hiddenNum{
    [self.numBgViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden  = YES;
    }];
}

@end
