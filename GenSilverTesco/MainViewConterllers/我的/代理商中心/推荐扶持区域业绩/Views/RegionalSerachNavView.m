//
//  RegionalSerachNavView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalSerachNavView.h"

@implementation RegionalSerachNavView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setViewCornerRadiusViews:self.views floatCoriner:15.0f];
    [self setViewCornerRadiusViews:@[self.serachBar] floatCoriner:15];
    self.serachBar.backgroundColor = [UIColor clearColor];
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (_searchBlick) {
        _searchBlick(searchBar.text);
    }
    [_serachBar resignFirstResponder];
}
@end
