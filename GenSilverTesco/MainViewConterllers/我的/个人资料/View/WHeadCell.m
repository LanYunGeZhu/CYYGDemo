//
//  wHeadCell.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WHeadCell.h"

@implementation WHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfoModol:(WInfomationModel *)infoModol
{
    
    
    switch (self.tag) {
        case  0:
        {
            if (infoModol.alias.length > 0)
            {
                self.cheK.text = infoModol.alias;
            }
            else
            {
                self.cheK.text = StringWithStr(@"用户", infoModol.user_id);
                
            }

        }
        break;
            
        case 1:
        {
            if (infoModol.card.length > 0)
            {
                self.cheK.text = @"已认证";
            }
            else
            {
                self.cheK.text = @"去认证";
                
            }

        }
        break;
            
        default:
            break;
    }
  
    
    
    
    
    
}

@end
