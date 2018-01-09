//
//  WTouchTabDelegate.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol TouchDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

@end

@interface WTouchTabDelegate : UITableView

@property (nonatomic,weak) id<TouchDelegate> toucDelegate;

@end
