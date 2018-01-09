//
//  SFMyShareCell.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFMyShareCell.h"

@implementation SFMyShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SFMyShareModel *)model{
    _model = model;
    
    self.title.text = [NSString stringWithFormat:@"%@",model.title] ;;
    self.getCode.text = [NSString stringWithFormat:@"%@",model.getCode] ; ;
    
    NSString *type;
    switch ([model.ptype integerValue]) {
        case 0:
            type = @"赠送积分";
            break;
        case 2:
            type = @"贷款积分";
            break;
        case 6:
            type = @"充值积分";
            break;
        case 7:
            type = @"让利金积分";
            break;
        case 8:
            type = @"供货商积分";
            break;
        case 10:
            type = @"推荐积分";
            break;
            
        default:
            break;
    }
    self.time.attributedText = [self changeStrColor:model.time needChangeStr:[NSString stringWithFormat:@"[%@]",type]] ;
    
}

//改变指定字符串颜色
- (NSMutableAttributedString *)changeStrColor:(NSString *)allStr needChangeStr:(NSString *)changeStr{
    
    //需要改变颜色的字符串的长度
    NSInteger len = [changeStr length];
    //先得到一个字符串
    NSString * headerString = [NSString stringWithFormat:@"%@%@",allStr,changeStr];
    //    //计算需要设置变色的字符的长度和开始位置
    //    NSInteger loc =[headerString length] - [allStr length] ;
    
    //创建一个属性字符串
    NSMutableAttributedString *headerMutableString = [[NSMutableAttributedString alloc]initWithString:headerString];
    
    //开始根据长度和位置 设置颜色
    [headerMutableString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([allStr length], len)];
    [headerMutableString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, len)];
    
    return headerMutableString;//赋值
    
}

@end
