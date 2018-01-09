//
//  ProductSpecificationsView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ProductSpecificationsView.h"
#import "ProductItemsCell.h"
#import "ProductModel.h"
#import "ProductHeaderView.h"
@implementation ProductSpecificationsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    self.textField.layer.borderColor = [UIColor  blackColor].CGColor;
    self.textField.layer.borderWidth = 1;
}

- (IBAction)base_ButtonsClick:(UIButton *)sender{
    
    if (sender.tag == 0||sender.tag == 3 || sender.tag == 4) {
        
        if (sender.tag == 3 || sender.tag ==4) {
            [self calculateThePricetheSelectedIds:^(double price, NSString *ids) {
                if ([self componentsSeparatedByString:ids].count < _model.attrs.count) {
                    [MBProgressHUD showTipMessageInWindow:@"请选择规格"];
                }else{
                    [self baseXIB_removeSubView];
                    
                    [super base_ButtonsClick:sender];
                }
            }];
        }else{
            [self baseXIB_removeSubView];
            
            [super base_ButtonsClick:sender];
        }
       
    }else {
        NSInteger num = [self.textField.text integerValue];
        if(sender.tag ==1){
        // 减去
            if (num == 0) {
                return;
            }
            num --;
        }else{
        //增加
            num ++;
        }
        [self calculateThePricetheSelectedIds:^(double price, NSString *ids) {
            
           NSString *goodNum  = [self queryTheInventory:ids];
            if (num >[goodNum integerValue ]) {
                [MBProgressHUD showTipMessageInWindow:@"库存不足"];
                return;
            }
            self.textField.text = [NSString stringWithFormat:@"%ld",(long)num];
            self.theSelectedNum.text = [NSString stringWithFormat:@"已选：%ld件",(long)num];
            _model.goods.isSelect_num = num;
        }];
    
    }
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    self.textField.text = [NSString stringWithFormat:@"%ld",_model.goods.isSelect_num];
    self.theSelectedNum.text = [NSString stringWithFormat:@"已选：%ld件",_model.goods.isSelect_num];

    self.withMoreThanTheNumber.text = [NSString stringWithFormat:@"剩余：%@件",model.goods.goods_number];
    self.price.text = [NSString stringWithFormat:@"￥%@",model.goods.shop_price];
    [self.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,model.goods.goods_thumb]] placeholderImage:KSPLAIMAGE];
    [self loadDatas];
    [self quantityAndPriceCalculation];
}

- (NSMutableArray *)datasArray{
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

- (void)loadDatas{
    NSMutableArray *bigHeght = [NSMutableArray array];

    [_model.attrs enumerateObjectsUsingBlock:^(Attrs * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block NSInteger rowHeght = 0;
        NSMutableArray * array = [NSMutableArray array];
        [obj.values enumerateObjectsUsingBlock:^(Values * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            CGSize  size = [KSTool sizeWithTexte:obj1.label font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, 20)];
            CGFloat itemsWidth = size.width + 16;
            obj1.size = CGSizeMake( itemsWidth , 30);
            __block CGFloat floatH = 0;

            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                floatH  = floatH + [obj floatValue] + 8;
            }];
            CGFloat sfloat= (floatH +8.0f)/Screen_wide;
            NSLog(@"---%lu",(unsigned long)ceilf(sfloat));
            rowHeght = (unsigned long)ceilf(sfloat);

        }];
        [bigHeght addObject:@(rowHeght)];

        
    }];
    __block NSInteger view_height =0;
    [bigHeght enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        view_height = [obj integerValue] *38 +view_height +8;
    }];
    self.layou_collectionView_height.constant = 94 + 86 + view_height + 80;
    [self.collectionView reloadData];
    
    ///模拟数据
//   NSArray * lsitArr = @[@[@"中国/1000"],@[@"中国/1000",@"日本呵呵/23",@"韩国",@"中国",@"日本",@"韩国"]];
//    
//    NSMutableArray *bigHeght = [NSMutableArray array];
//    [lsitArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSMutableArray * smlArray = [NSMutableArray array];
//       __block NSInteger rowHeght = 0;
//        NSMutableArray * array = [NSMutableArray array];
//        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            CGSize  size = [KSTool sizeWithTexte:obj font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, 20)];
//            CGFloat itemsWidth = size.width + 16;
//            ProductModel *model = [ProductModel new];
//            model.size = CGSizeMake( itemsWidth , 30);
//            model.title = obj;
//            [array addObject:@(itemsWidth)];
//            [smlArray addObject:model];
//            __block CGFloat floatH = 0;
//            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                floatH  = floatH + [obj floatValue] + 8;
//            }];
//            CGFloat sfloat= (floatH +8.0f)/Screen_wide;
//            NSLog(@"---%lu",(unsigned long)ceilf(sfloat));
//            rowHeght = (unsigned long)ceilf(sfloat);
//        }];
//        [bigHeght addObject:@(rowHeght)];
//        [self.datasArray addObject:smlArray];
//    }];
//    
//    __block NSInteger view_height =0;
//    [bigHeght enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        view_height = [obj integerValue] *38 +view_height +8;
//    }];
    self.layou_collectionView_height.constant = 94 + 86 + view_height + 80;
    [self.collectionView reloadData];
}

- (void)registerCellItems{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductItemsCell" bundle:nil] forCellWithReuseIdentifier:@"ProductItemsCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductHeaderView"];
//    [self loadDatas];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     Attrs *attri = _model.attrs[section];
    return attri.values.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _model.attrs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductItemsCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductItemsCell" forIndexPath:indexPath];
//    ProductModel * model = self.datasArray[indexPath.section][indexPath.item];
    Attrs *attri = _model.attrs[indexPath.section];
    Values *model  = attri.values[indexPath.row];
    cell.title.text  = model.label;
    if (model.is_select == 0) {
        cell.contentView.backgroundColor = UIColorFromRGB(0xdddddd);
        cell.title.textColor = UIColorFromRGB(0x999999);
    }else{
        cell.contentView.backgroundColor = [UIColor redColor];
        cell.title.textColor = [UIColor whiteColor];
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        ProductHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductHeaderView" forIndexPath:indexPath];
        Attrs *attri = _model.attrs[indexPath.section];
        header.sectioTitle.text = attri.name;
        return header;
    }
    return nil;
   
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Attrs *attri = _model.attrs[indexPath.section];
    Values *model  = attri.values[indexPath.row];
    if ([attri.attr_type integerValue] == 1) {
        //单选
         [attri.values enumerateObjectsUsingBlock:^(Values * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             if (obj.is_select == 1) {
                 ProductItemsCell *cell = (ProductItemsCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:indexPath.section]];
                 cell.contentView.backgroundColor = UIColorFromRGB(0xdddddd);
                 cell.title.textColor = UIColorFromRGB(0x999999);
                 obj.is_select = 0;
             }
         }];
    }
    if (model.is_select == 0) {
        model.is_select = 1;
    }else{
        model.is_select = 0;
    }
//    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    [self quantityAndPriceCalculation];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}

- (void)quantityAndPriceCalculation{
    
    [self calculateThePricetheSelectedIds:^(double price, NSString *ids) {
        self.price.text = [NSString stringWithFormat:@"￥%.2f",[_model.goods.shop_price doubleValue] + price];
    
        self.withMoreThanTheNumber.text = [NSString stringWithFormat:@"剩余：%@件",[self queryTheInventory:ids]];
        //如果当前数量大于库存 设置最大数量
        if ([[self queryTheInventory:ids] integerValue] < _model.goods.isSelect_num) {
            _model.goods.isSelect_num = [[self queryTheInventory:ids] doubleValue];
            self.theSelectedNum.text = [NSString stringWithFormat:@"已选：%ld件",_model.goods.isSelect_num];

        }

    }];

}

/** 计算选中规格的价格 以及 ids*/
- (void)calculateThePricetheSelectedIds:(void(^)(double price,NSString *ids))selectOrder{
    __block double price = 0;
    __block NSString *ids = @"";
    [_model.attrs enumerateObjectsUsingBlock:^(Attrs * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.values enumerateObjectsUsingBlock:^(Values * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj1.is_select == 1) {
                price  = [obj1.format_price doubleValue] + price;
                if ([ids isEqualToString:@""]) {
                    ids = obj1.iD;
                }else{
                    ids = [NSString stringWithFormat:@"%@|%@",ids,obj1.iD];
                }
            }
        }];
    }];
    selectOrder(price,ids);
}

//查询库存
- (NSString *)queryTheInventory:(NSString *)number{
    if ([number isEqualToString:@""]) {
        return _model.goods.goods_number;
    }
    if ([self componentsSeparatedByString:number].count < _model.attrs.count) {
        return  _model.goods.goods_number;
    }
    __block NSString *prosNum = @"0";
    [_model.pros enumerateObjectsUsingBlock:^(Pros * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.goods_attr isEqualToString:number]) {
           prosNum = [NSString stringWithFormat:@"%@",obj.product_number];
            
        }
    }];
    return prosNum;
}

- (NSArray *)componentsSeparatedByString:(NSString *)number{
    
    return [number componentsSeparatedByString:@"|"];
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Attrs *attri = _model.attrs[indexPath.section];
    Values *model = attri.values[indexPath.row];
    return model.size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(Screen_wide, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 8;
}


@end
