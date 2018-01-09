//
//  RefundsListHeadeView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RefundsListHeadeView.h"

@implementation RefundsListHeadeView

- (void)awakeFromNib{
    [self.contactTheSeller.layer setCornerRadius:5];
    [self.contactTheSeller.layer setBorderColor:[UIColor redColor].CGColor];
    [self.contactTheSeller.layer setBorderWidth:1];
    
    [super awakeFromNib];
}

- (void)setData:(id)data{
//    NSArray *arrayImages = @[@"待商家查看",@"商家拒绝",@"退款成功",@"已取消退款"];
//    [self.statusButton setImage:[UIImage imageNamed:arrayImages[0]] forState:UIControlStateNormal];
    NSArray *arrayTitles = @[@"待商家查看",@"退款成功",@"已退款",@"已取消退款",@"申请被拒绝"];
    NSArray *imgArr = @[@"Group 222",@"Group 3",@"Group 3",@"Group 5",@"Group 4"];
    NSString *titleStr;NSString *btnStr;NSString *imgStr;
    switch ([data integerValue]) {
        case 5://待审核
            imgStr = imgArr[0];
            titleStr = arrayTitles[0];
            btnStr = @"取消退款";
            break;
        case 4://完成退货
            imgStr = imgArr[1];
            titleStr = arrayTitles[1];
            self.contactTheSeller.hidden = YES;
            break;
        case 3://已退款
            imgStr = imgArr[2];
            titleStr = arrayTitles[2];
            self.contactTheSeller.hidden = YES;
            break;
        case 8://已取消
            imgStr = imgArr[3];
            titleStr = arrayTitles[3];
            self.contactTheSeller.hidden = YES;
            break;
        case 6://申请被拒绝
            imgStr = imgArr[4];
            titleStr = arrayTitles[4];
            self.contactTheSeller.hidden = YES;
            btnStr = @"联系卖家";
            break;
            
            
        default:
            break;
    }
    [self.statusButton setImage:[UIImage imageNamed:imgStr] forState:(UIControlStateNormal)];
//    [self.statusButton setTitle:titleStr forState:UIControlStateNormal];
    [self.contactTheSeller setTitle:btnStr forState:UIControlStateNormal];
    self.nameLable.text = titleStr;
    
    NSDateFormatter *formatt = [[NSDateFormatter alloc]init];
    formatt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    [formatt setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateStr = [formatt stringFromDate:[NSDate date]];
    self.timer.text = dateStr;
    
}
@end
