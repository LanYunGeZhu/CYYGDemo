//
//  WWinthDrawReCordCell.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WWinthDrawReCordCell.h"

@implementation WWinthDrawReCordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setState:(NSString *)state
{
    if ([state integerValue] == 0) {
        self.typeLa.text = @"提现让利金";
    }
    else
    {
        self.typeLa.text = @"提现贷款";

    }
}

- (void)setTpyestate:(NSString *)tpyestate
{
   if([tpyestate floatValue] == 111)
   {
     self.MoneyStatetLa.text = @"已放款";
   }
   else if([tpyestate floatValue] == 0)
   {
       self.MoneyStatetLa.text = @"待放款";

   }
   else if([tpyestate floatValue] == 102)
   {
       self.MoneyStatetLa.text = @"其他";

   }
   else{
       self.MoneyStatetLa.text = @"放款失败";

   }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
