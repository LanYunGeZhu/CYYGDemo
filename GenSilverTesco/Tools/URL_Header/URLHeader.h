//
//  URLHeader.h
//  BigWinner
//
//  Created by kangshibiao on 2017/2/23.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#ifndef URLHeader_h
#define URLHeader_h

#define URL_MANURL  @"http://test.cyyg111.com/"
//#define URL_MANURL  @"http://www.cyyg111.com/"
//#define URL_MANURL_image  @"http://test.cyyg111.com/"
#define URL_MANURL_image  @"http://www.cyyg111.com/"

/**
 * 1.	用户登录
 */
#define URL_act_login @"user.php?act=act_login"

/*
 * 2.	用户注册->获取手机验证码
 */
#define URL_getcaptchabyid @"ajax.php?act=getcaptchabyid"

/*
 * 3.	用户注册
 */
#define URL_register @"register.php?act=register"

/*
 * 4.	找回密码->检查用户名
 */
#define URL_check_username @"findpwd.php?act=check_username"

/*
 * 5.	找回密码->获取手机验证码
 */
#define URL_send_mobile_code @"validate.php?act=send_mobile_code"

/*
 * 6.	找回密码->设置新密码
 */
#define URL_validate @"findpwd.php?act=validate"

/*
 * 6.找回密码->检查手机验证码接
 */
#define URL_reset_password @"findpwd.php?act=reset_password"

/*
 * 7.	首页->最新上架
 */
#define URL_get_new_shops @"api/shops.php?act=get_new_shops"

/*
 *
 */
#define URL_get_index_infos @"api/shops.php?act=get_index_infos"

/*
 * 11.创盈商城产品列表接口
 */
#define URL_appgoodsList @"api/appgoods.php?act=lists"

/**
 * api/appgoods.pp?act= goods_info
 */
#define URL_goods_info @"api/appgoods.php?act=goods_info"

/*
 *
 */
#define URL_newslists @"api/news.php?act=lists"

/*
 *
 */
#define URL_goods_category @"api/appgoods.php?act=goods_category"

/*
 *
 */
#define URL_

/*
 * 15.投诉建议接口：wxsuggest.php
 */
#define URL_wxsuggest @"wxsuggest.php?act=adddo"

/*
 * 16.帮助中心分类接口
 */
#define URL_get_help @"api/news.php?act=get_help"

/*
 * 12.商品详情->获取评论列表接口
 */
#define URL_appgoods @"api/appgoods.php?act=get_comment"

/*

 *查个人资料

 * 17.线上订单列表接口：api/orders.php?act=lists
9
 */
#define URL_ordersList      @"api/orders.php?act=lists"
/*
 个人信息
*/
#define URL_appinfomation   @"api/user.php?act=user_info"
/*
 提现
 */
#define URL_apptomoney      @"api/user.php?act=cashdo"
/*
 提现记录
 */
#define URL_appmoneyrecord  @"api/user.php?act=account_log"
/*
 做单
 */
#define URL_appmakeorder    @"api/orders.php?act=setorderdo"
/*
 会员信息
 */
#define URL_appuserinfo     @"api/user.php?act=get_user"
/*
 店铺列表
 */
#define URL_appshopinfo     @"api/shops.php?act=get_user_shops"
/*
 个人信息
 */
/*

 *修改用户信息

 * 18.线上订单详情接口

 */
#define URL_orders_detail @"api/orders.php?act=detail"
/*
 修改个人信息
 */
#define URL_appinfomationdefy @"api/user.php?act=set_info"
/*
 个人信息头像
 */
#define URL_appinfoImage @"api/user.php?act=get_headimg"
/*
 个人信息头像修改
 */
#define URL_appinfoImageChange @"api/user.php?act=edit_headimg"

/*
 推荐注册
 */
#define URL_apprecordregister @"api/user.php?act=get_register_url"
/*
<<<<<<< .mine
 * 20.商品评论接口
=======
 *修改用户信息单个:
>>>>>>> .r16503
 */

#define URL_comment_send @"api/user.php?act=my_comment_send"
/*
 个人信息修改
 */
#define URL_appsingledefy   @"api/user.php?act=set_user_one_info"


/*
<<<<<<< .mine
 * 19.我的线下订单列表接口
=======
 *获取开户银行
>>>>>>> .r16503
 */

#define URL_sjorders @"api/orders.php?act=sjorders"
//获取银行列表
#define URL_appgetBank      @"api/news.php?act=banks"


/*

 * 24.联盟商家列表接口

 *身份认证信息提交
>>>>>>> .r16503
 */

#define URL_shopslists @"api/shops.php?act=lists"
//提交个人身份认证信息
#define URL_appinfosubmit   @"api/user.php?act=set_info"


/*=======================================================*/
/*
<<<<<<< .mine

 *充值记录

=======
<<<<<<< .mine
 *修改密码
=======
>>>>>>> .r16770
 * 25.店铺详情接口
<<<<<<< .mine

=======
>>>>>>> .r16662
>>>>>>> .r16770
 */

/*
 充值记录
 */
#define URL_appcharge     @"api/user.php?act=account_logs"
/*
 充值
 */
#define URL_appchargeurl  @"api/user.php?act=rechargedo"


#define URL_changePW @"api/user.php?act=edit_password"

#define URL_shopsdetail @"api/shops.php?act=detail"


/*
 *找回支付密码
 */
#define URL_findPayPW @"user.php?act=save_findsavepass"

/*
 *找回支付密码获取验证码
 */
#define URL_findPayPW_getCode @"ajax.php?act=send_mobile_code"

/*
 *我的钱包列表接口
 */
#define URL_myPurse @"api/user.php?act=account_log"

/*
 *我的分享列表接口
 */
#define URL_myShare @"api/user.php?act=account_log"

/*
 *我的收藏列表接口
 */
#define URL_myCollect @"api/user.php?act=my_collection"

/*
 *收藏或取消收藏接口
 */
#define URL_cancleCollect @"api/user.php?act=collection_add"

/*
 *我的评论列表接口
 */
#define URL_myComment @"api/user.php?act=comment_list"

/*
 *积分换购_获取当前已有积分
 */
#define URL_getCanUseCode @"api/user.php?act=my_points"

/*
<<<<<<< .mine
 *积分换购_获取当前商家下店铺列表接口
=======
 * 36.收货地址列表接口: api/user.php?act=address_list
>>>>>>> .r16662
 */
#define URL_shopsList @"api/shops.php?act=get_user_shops"
#define URL_address_list @"api/user.php?act=address_list"

/*
<<<<<<< .mine
 *积分换购提交申请接口
=======
 * 37.添加/编辑收货地址接口: api/user.php?act=address_edit
>>>>>>> .r16662
 */
#define URL_codeRedemption @"api/orders.php?act=addsjorder"
#define URL_address_edit @"api/user.php?act=address_edit"

/*=======================================================*/

/*
 * 84:获取运费
 */
#define URL_get_shipping_fee @"api/orders.php?act=get_shipping_fee"

/*
 * 83:修改购物车中商品数量:api/orders.php?act=change_number
 */
#define URL_change_number @"api/orders.php?act=change_number"

/*
 * 41.我的购物车列表接口:api/user.php?act=my_cart
 */
#define URL_usermy_cart  @"api/user.php?act=my_cart"

/**
 * 42.结算商品接口:api/orders.php?act=order_down
 */
#define URL_order_down @"api/orders.php?act=order_down"

/*
 * 79删除收货地址：api/user.php?act=address_del
 */
#define URL_address_del @"api/user.php?act=address_del"

/**
 *  80.加入购物车 api/orders.php?act=add_to_cart
 */
#define URL_add_to_cart @"api/orders.php?act=add_to_cart"

/*
 * 82.获取行业数据：
 */
#define URL_get_industry @"api/shops.php?act=get_industry"

/**
 * 47.代理商中心添加商家接口:api/agent.php?act=add_shop
 */
#define URL_add_shop @"api/agent.php?act=add_shop"

/**
 * 48.区域订单审核列表接口:api/agent.php?act= sjorders
 */
#define URL_agentsjorders @"api/agent.php?act=sjorders"

/**
 * 49. 批量管理区域订单接口:api/agent.php?act=audit_sjorder
 */
#define URL_agent_audit_sjorder @"api/agent.php?act=audit_sjorder"

/**
 * 50. 商家入驻审核列表接口:api/agent.php?act=shops
 */
#define URL_agentshops @"api/agent.php?act=shops"

/**
 *  代理商基本信息：api/agent.php?act=agent_info
 */
#define URL_agent_info @"api/agent.php?act=agent_info"

#define URL_get_agent_area @"api/agent.php?act=get_agent_area"

/**
 * 51. 批量审核入驻商家接口:api/agent.php?act= audit_shops
 */
#define URL_audit_shops @"api/agent.php?act=audit_shops"

/**
 * 52. 区域会员列表接口:api/agent.php?act= users
 */
#define URL_usersagent @"api/agent.php?act=users"

/**
 * 53. 业务员管理列表接口:api/agent.php?act= salers
 */
#define URL_agentsalers @"api/agent.php?act=salers"

/**
 * 88.账号退出：api/user.php?act=logout
 */
#define URL_logout @"api/user.php?act=logout"

/**
 * 89.上传商家->检查商家账号：api/agent.php?act=get_user_info
 */
#define URL_get_user_info @"api/agent.php?act=get_user_info"


/**
 * 90. 业务员管理->检查业务员账号：api/agent.php?act=check_agent_user
 */
#define URL_check_agent_user @"api/agent.php?act=check_agent_user"

/**
 * 54. 添加业务员接口:api/agent.php?act= saler_add
 */
#define URL_saler_add @"api/agent.php?act=saler_add"

/**
 *
 */
#define URL_

/**
 *
 */
#define URL_

/**
 * 56. 业务员管理—删除业务员接口:api/agent.php?act= salerdel
 */
#define URL_salerdel @"api/agent.php?act=salerdel"


/**
 * 57. 代理商中心--商家活动管理接口:api/agent.php?act= activity
 */
#define URL_agentActivity @"api/agent.php?act=activity"


/**
 * 58. 批量管理商家活动接口:api/agent.php?act=activity_audit
 */
#define URL_activity_audit @"api/agent.php?act=activity_audit"

/**
 * 59. 区域信息列表接口:api/agent.php?act=news
 */
#define URL_agentnewsarea @"api/agent.php?act=news"

/**
 * 60. 发布信息接口:api/agent.php?act=news_add
 */
#define URL_news_add @"api/agent.php?act=news_add"

/**
 * 91.图片文件流上传：api/ shops.php?act=upload_image
 */
#define URL_uploadImage @"api/shops.php?act=upload_image"

/**
 * 61. 推荐扶持区域列表接口:api/agent.php?act= subslist
 */
#define URL_subslist @"api/agent.php?act=subslist"

/**
 * 62. 推荐扶持区域业绩列表接口:api/agent.php?act= subsstat
 */
#define URL_subsstat @"api/agent.php?act=subsstat"

/**
 * 63. 商家中心店铺列表接口:api/shoper.php?act=my_shops
 */
#define URL_my_shops @"api/shoper.php?act=my_shops"

/**
 * 64. 商家中心首页数据接口:api/shoper.php?act=my_index
 */
#define URL_my_index @"api/shoper.php?act=my_index"

/**
 * 67. 会员订单列表接口:api/shoper.php?act=sjorders
 */
#define URL_shopersjorders @"api/shoper.php?act=sjorders"

/**
 * 69. 审核积分换购接口:api/shoper.php?act= audit_sjorder
 */
#define URL_audit_sjorder @"api/shoper.php?act=audit_sjorder"

/**
 * 70. 业绩明细列表接口:api/shoper.php?act=stats
 */
#define URL_shoperstats @"api/shoper.php?act=stats"

/**
 * 71. 商家中心—活动管理列表接口:api/shoper.php?act=activity
 */
#define URL_shoper_activity @"api/shoper.php?act=activity"
/**
 * 72. 删除活动接口:api/shoper.php?act=activity_del
 */
#define URL_activity_del @"api/shoper.php?act=activity_del"


/**
 * 73. 发布新活动/修改活动 接口:api/shoper.php?act=activity_add
 */
#define URL_shoper_activity_add @"api/shoper.php?act=activity_add"


/**
 * 74. 推荐会员管理列表接口:api/shoper.php?act= subs
 */
#define URL_shoper_subs @"api/shoper.php?act=subs"

/**
 * 75. 删除订单接口:api/orders.php?act=order_delete
 */
#define URL_order_delete @"api/orders.php?act=order_delete"

/**
 * 76. 订单确认收货接口:api/orders.php?act=order_shipped
 */
#define URL_order_shipped @"api/orders.php?act=order_shipped"

/**
 * 92.区域信息->删除：api/agent.php?act=news_del
 */
#define URL_news_del @"api/agent.php?act=news_del"

/**
 * 95.线下订单详情：api/orders.php?act=sjorder_detail
 */
#define URL_orders_sjorder_detail @"api/orders.php?act=sjorder_detail"

/**
 * 96.业务员首页：api/agent.php?act=yw_index
 */
#define URL_yw_index @"api/agent.php?act=yw_index"


/**
 * 97.业务员->商家列表：api/agent.php?act=yw_shops
 */
#define URL_yw_shops @"api/agent.php?act=yw_shops"

/**
 * 98.业务员->我的业绩：api/agent.php?act=yw_stats
 */
#define URL_yw_stats @"api/agent.php?act=yw_stats"

/**
 *99.代理商中心->店铺订单：api/agent.php?act=sjorders
 */
#define URL_agent_sjorders @"api/agent.php?act=sjorders"
/**
 * 100. 代理商中心->区域业绩:api/agent.php?act=stats
 */
#define URL_agentstats @"api/agent.php?act=stats"

/**
 * 101:商家中心->获取让利模式:api/shoper.php?act=get_rlbl
 */
#define URL_get_rlbl @"api/shoper.php?act=get_rlbl"

/**
 * 102:商家中心->添加/编辑商铺:api/user.php?act=add_shop
 */
#define URL_user_add_shop @"api/user.php?act=add_shop"

/**
 *  103:代理商中心->设置业务员:api/agent.php?act=transhopdo
 */
#define URL_agent_transhopdo @"api/agent.php?act=transhopdo"

/**
 * 104:代理商中心->取消商家业务员:api/agent.php?act=cancelyw
 */
#define URL_cancelyw @"api/agent.php?act=cancelyw"

/**
 * 105；订单退款/退货接口:api/orders.php?act=orders_reback
 */
#define URL_order_reback @"api/orders.php?act=orders_reback"

/**
 * 106；订单退款/退货列表接口:api/orders.php?act=orders_reback_list
 */
#define URL_reback_list @"api/orders.php?act=orders_reback_list"

/**
 * 107；订单退款/退货详情接口:api/orders.php?act=orders_reback_detail
 */
#define URL_orders_reback_detail @"api/orders.php?act=orders_reback_detail"

/**
 * 110:购物车->删除商品：api/orders.php?act= delete_cart_goods
 */
#define URL_delete_cart_goods @"api/orders.php?act=delete_cart_goods"

/**
 * 112:购物->订单支付：api/orders.php?act=order_pay
 */
#define URL_order_pay @"api/orders.php?act=order_pay"

/**
 * 113:社区->发表主题：api/user.php?act=bbs_add
 */
#define URL_bbs_add @"api/user.php?act=bbs_add"

/**
 * 114:社区->主题列表：api/user.php?act=bbs_lists
 */
#define URL_bbs_lists @"api/user.php?act=bbs_lists"

/**
 * 116:社区->主题详情：api/user.php?act=bbs_detail
 */
#define URL_bbs_detail @"api/user.php?act=bbs_detail"


/**
 * 116:社区->回复列表：api/user.php?act=bbs_replys
 */
#define URL_bbs_replys @"api/user.php?act=bbs_replys"


/**
 * 118:社区->点赞：api/user.php?act=bbs_goods
 */
#define URL_bbs_goods @"api/user.php?act=bbs_goods"


/**
 * 117:社区->获取未读消息数：api/user.php?act=bbs_new_msg_num
 */
#define URL_bbs_new_msg_num @"api/user.php?act=bbs_new_msg_num"

/**
 * 118:社区->获取未读消息列表：api/user.php?act=bbs_new_msg_lists
 */
#define URL_bbs_new_msg_lists @"api/user.php?act=bbs_new_msg_lists"

/**
 *  119:社区->清空未读消息数：api/user.php?act=bbs_clear_new_msg

 */
#define URL_bbs_clear_new_msg @"api/user.php?act=bbs_clear_new_msg"

/**
 * 120:会员中心->订单概况：api/user.php?act=orders_stats
 */
#define URL_user_orders_stats @"api/user.php?act=orders_stats"

/**
 *
 */
#define URL_


#endif /* URLHeader_h */
