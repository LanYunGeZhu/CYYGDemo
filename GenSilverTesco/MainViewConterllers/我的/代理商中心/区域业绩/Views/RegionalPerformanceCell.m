//
//  RegionalPerformanceCell.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalPerformanceCell.h"

@implementation RegionalPerformanceCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    
    //设定最小的长按时间 按不够这个时间不响应手势
    longPressGR.minimumPressDuration = 1;
    longPressGR.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:longPressGR];
}

- (void)lpGR:(UILongPressGestureRecognizer *)lpGR{
    if (lpGR.state == UIGestureRecognizerStateBegan) {
        NSLog(@"---------------------");
        if (_longTap) {
            _longTap(lpGR.view);
        }
        
    }
    [self setViewCornerRadiusViews:@[self.storeImageView] floatCoriner:20.0f/2.0f];

}


- (void)setModel:(RegionalPerformanceModel *)model{
//    NSMutableAttributedString * mutableAttributed = [[NSMutableAttributedString alloc]initWithString:@"年让利金 :$ 588"];
//    [mutableAttributed setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(6, mutableAttributed.length - 6)];
//    cell.yearsOnGold.attributedText = mutableAttributed;
    self.storeName.text = model.shop_name;
    self.nameLabel.text=  [NSString stringWithFormat:@"%@   : %@",model.linkman,model.mobile];
    
    self.theSalesmanLabel.text = [NSString stringWithFormat:@"业务员 : %@",model.ywuser_name ];
    
    NSString *string_tprice = [NSString stringWithFormat:@"%@",model.mrl];
    NSString * tprice = [NSString stringWithFormat:@"月让利金 : %@",string_tprice];
    
    self.monthOnGold.attributedText = [KSTool setAttributedString:tprice color:[UIColor redColor] startNum:tprice.length - string_tprice.length length:string_tprice.length];
    
    NSString *string_trl = [NSString stringWithFormat:@"%@",model.trl];
    
    NSString *trl = [NSString stringWithFormat:@"总让利金 : %@",model.trl];
    self.yearsOnGold.attributedText = [KSTool setAttributedString:trl color:[UIColor redColor] startNum:trl.length - string_trl.length length:string_trl.length]
    ;

    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.shop_img]] placeholderImage:KSPLAIMAGE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
