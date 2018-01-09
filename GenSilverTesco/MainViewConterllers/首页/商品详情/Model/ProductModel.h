//
//  ProductModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModelList : NSObject

@end

@interface ProductModel : NSObject


@property (assign, nonatomic) CGSize size;
@property (copy, nonatomic) NSString *title;

/**<#name#>*/
@property (assign, nonatomic) NSInteger is_select;

//@property (copy, nonnull) 
/** 菜单*/
@property (copy, nonatomic) NSArray <ProductModelList *> *values;



@end
