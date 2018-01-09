//
//  GoodsDetailsModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/7.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pros : NSObject
@property (nonatomic , copy) NSString              * goods_attr;
@property (nonatomic , copy) NSString              * product_number;
@end

@interface Supplier : NSObject
@property (nonatomic , copy) NSString              * bz_iq;
@property (nonatomic , copy) NSString              * headimg;
@property (nonatomic , copy) NSString              * supplier_name;

@end

@interface Paras :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * value;

@end

@interface Gallery :NSObject
@property (nonatomic , copy) NSString              * thumb_url;
@property (nonatomic , copy) NSString              * img_id;
@property (nonatomic , copy) NSString              * img_desc;
@property (nonatomic , copy) NSString              * img_original;
@property (nonatomic , copy) NSString              * img_url;

@end

@interface Goods :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * is_alone_sale;
@property (nonatomic , copy) NSString              * zhekou;
@property (nonatomic , copy) NSString              * seller_note;
@property (nonatomic , copy) NSString              * bonus_type_id;
@property (nonatomic , copy) NSString              * favs;
@property (nonatomic , copy) NSString              * is_shipping;
@property (nonatomic , copy) NSString              * warn_number;
@property (nonatomic , copy) NSString              * is_promote;
@property (nonatomic , copy) NSString              * measure_unit;
@property (nonatomic , copy) NSString              * give_integral;
@property (nonatomic , copy) NSString              * integral;
@property (nonatomic , copy) NSString              * original_img;
@property (nonatomic , copy) NSString              * goods_brand;
@property (nonatomic , copy) NSString              * supplier_id;
@property (nonatomic , copy) NSString              * is_real;
@property (nonatomic , copy) NSString              * goods_type;
@property (nonatomic , copy) NSString              * promote_start_date;
@property (nonatomic , copy) NSString              * goods_number;
@property (nonatomic , copy) NSString              * is_new;
@property (nonatomic , copy) NSString              * buymax_start_date;
@property (nonatomic , copy) NSString              * suppliers_id;
@property (nonatomic , copy) NSString              * supplier_status;
@property (nonatomic , copy) NSString              * provider_name;
@property (nonatomic , copy) NSString              * goods_desc;
@property (nonatomic , copy) NSString              * cat_id;
@property (nonatomic , copy) NSString              * is_best;
@property (nonatomic , copy) NSString              * shop_price;
@property (nonatomic , copy) NSString              * gmt_end_time;
@property (nonatomic , copy) NSString              * goods_sn;
@property (nonatomic , copy) NSString              * is_check;
@property (nonatomic , copy) NSString              * goods_brief;
@property (nonatomic , copy) NSString              * buyer_num;
@property (nonatomic , copy) NSString              * is_hot;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , copy) NSString              * buymax_end_date;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * index_rm;
@property (nonatomic , copy) NSString              * sales;
@property (nonatomic , copy) NSString              * index_th;
@property (nonatomic , copy) NSString              * goods_weight;
@property (nonatomic , copy) NSString              * supplier_status_txt;
@property (nonatomic , copy) NSString              * promote_end_date;
@property (nonatomic , copy) NSString              * index_tj;
@property (nonatomic , copy) NSString              * market_price;
@property (nonatomic , copy) NSString              * is_buy;
@property (nonatomic , copy) NSString              * is_delete;
@property (nonatomic , copy) NSString              * is_catindex;
@property (nonatomic , copy) NSString              * goods_thumb;
@property (nonatomic , copy) NSString              * click_count;
@property (nonatomic , copy) NSString              * max_integral;
@property (nonatomic , copy) NSString              * extension_code;
@property (nonatomic , copy) NSString              * buymax;
@property (nonatomic , copy) NSString              * rank_price;
@property (nonatomic , copy) NSString              * valid_date;
@property (nonatomic , copy) NSString              * sort_order;
@property (nonatomic , copy) NSString              * real_price;
@property (nonatomic , copy) NSString              * comment_rank;
@property (nonatomic , copy) NSString              * promote_price;
@property (nonatomic , copy) NSString              * is_virtual;
@property (nonatomic , copy) NSString              * promote_price_org;
@property (nonatomic , copy) NSString              * is_on_sale;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * bonus_money;
@property (nonatomic , copy) NSString              * shipping_id;
@property (nonatomic , copy) NSString              * goods_name_style;
@property (nonatomic , copy) NSString              * keywords;
@property (nonatomic , copy) NSString              * rank_integral;
@property (nonatomic , copy) NSString              * last_update;
@property (nonatomic , copy) NSString              * shop_price_formated;
@property (nonatomic , copy) NSString              * goods_img;
@property (nonatomic , copy) NSString              * cost_price;
@property (nonatomic , copy) NSString              * brand_id;
/**已选择数量*/
@property (assign, nonatomic) NSInteger            isSelect_num;
/**  是否收藏 0 没有收藏 */
@property (copy, nonatomic) NSString *iscollect;



@end

@interface Ads :NSObject
@property (nonatomic , copy) NSString              * ad_link;
@property (nonatomic , copy) NSString              * ad_name;
@property (nonatomic , copy) NSString              * ad_img;

@end

@interface Values :NSObject
@property (nonatomic , copy) NSString              * stock;
@property (nonatomic , copy) NSString              * format_price;
@property (nonatomic , copy) NSString              * iD;
@property (nonatomic , copy) NSString              * label;
@property (nonatomic , copy) NSString              * goods_attr_thumb;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , assign) CGSize               size;
/**<#name#>*/
@property (assign, nonatomic) NSInteger is_select;

@end

@interface Attrs :NSObject
@property (nonatomic , copy) NSString              * attr_id;
@property (nonatomic , copy) NSString              * attr_type;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray<Values *>              * values;

@end


@interface GoodsDetailsModel : NSObject
@property (nonatomic , strong) NSArray<Paras *>              * paras;
@property (nonatomic , strong) NSArray<Gallery *>              * gallery;
@property (nonatomic , strong) Goods              * goods;
@property (nonatomic , strong) NSArray<Ads *>              * ads;
@property (nonatomic , strong) NSArray<Attrs *>              * attrs;
@property (nonatomic , strong) Supplier              * supplier;

@property (nonatomic , strong) NSArray<Pros *>              * pros;

@end
