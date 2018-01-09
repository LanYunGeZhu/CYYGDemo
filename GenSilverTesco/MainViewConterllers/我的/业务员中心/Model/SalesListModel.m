//
//  SalesListModel.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SalesListModel.h"

@implementation SalesListModel

/// 模型数组/字典元素对象可自定义类<替换实际属性名,实际类>
+ (NSDictionary <NSString *, Class> *)whc_ModelReplaceContainerElementClassMapper{
    return @{@"SalesListModel":self};
}
@end
