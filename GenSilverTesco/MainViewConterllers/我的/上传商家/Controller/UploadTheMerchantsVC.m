//
//  UploadTheMerchantsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "UploadTheMerchantsVC.h"
#import "MerchantsListCell.h"
#import "ShopIntroducedVC.h"
#import "IdMerchantsImageCell.h"
#import "KSImageView.h"
#import "StoreImageViewCell.h"
#import "UnionMerchantModel.h"
#import "KSAddressView.h"
@interface UploadTheMerchantsVC ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) NSArray *placeholderArray;
@property (strong, nonatomic) NSArray *storeImages;
@property (strong, nonatomic) NSMutableArray * contextArray;
@property (strong, nonatomic) NSMutableArray *imagesArray;

@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;

@property (copy, nonatomic) NSString *context;
//行业id
@property (copy, nonatomic) NSString *industryId;

@property (assign,nonatomic) BOOL isSelectAgreement;
@end

@implementation UploadTheMerchantsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.isyw == 2) {
        self.title = @"添加店铺";
        self.datasMutabArray = [@[@"经营人",@"联系电话",@"所在区域",@"详细地址",@"所属行业",@"店铺名"]mutableCopy];
        self.placeholderArray = @[@"填写经营店铺的店主",@"填写店主的联系电话",@"选择省市区",@"请输入详细地址",@"点击选择所属行业",@"请输入店铺名称"];
        self.contextArray =[@[@"",@"",@"",@"",@"",@""]mutableCopy];
//        self.contextArray =[@[@"",@"",@"",@"",@"",@"",@""]mutableCopy];


    }else{
        self.title = @"上传商家";
        self.datasMutabArray = [@[@"会员账号",@"推荐账号",@"联系姓名",@"联系电话",@"所在区域",@"详细地址",@"所属行业",@"店铺名"]mutableCopy];
        self.placeholderArray = @[@"请输入会员账号",@"请输入推荐账号",@"填写经营店铺的店主",@"填写店主的联系电话",@"自动获取",@"请输入详细地址",@"点击选择所属行业",@"请输入店铺名称"];
        [self getTheAgentInformation];
        self.contextArray =[@[@"",@"",@"",@"",@"",@"",@"",@""]mutableCopy];

    }
//    self.context = @"这是一个很不错的店，反正我是不想写 哈哈哈哈哈 哈哈哈";
    self.imagesArray = [@[@"",@"",@"",@""]mutableCopy];


}

/*
 *&
 89.上传商家->检查商家账号：api/agent.php?act=get_user_info
	上传参数：会员ID：user_id
 商家账号：username
	返回参数：会员ID：如果大于0，则存在，等于0，则此账号为注册
 姓名：real_name
 联系电话：mobile_phone
 是否是商家：isshoper  1：是商家 0：不是
 */

static char objc_deleteType;
- (void)getTheAgentInformation{
    WeakSelf
    NSString *url = @"";
    if (self.isyw == 1) {
        url =URL_get_agent_area;
    }else{
        url= URL_agent_info;
    }
    [KSRequestManager postRequestWithUrlString:url parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if (self.isyw ==1) {
            if ([responseObject[@"lists"] count] > 0) {
                NSArray *array =  responseObject[@"lists"];
                [self.contextArray setObject:KSDIC(responseObject[@"lists"][0], @"anames") atIndexedSubscript:4];
                weakSelf.province = KSDIC(array[0], @"province");
                weakSelf.city = KSDIC(array[0], @"city");
                weakSelf.district = KSDIC(array[0], @"district");
                objc_setAssociatedObject(self, &objc_deleteType, responseObject[@"lists"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }

        }else{
            [self.contextArray setObject:KSDIC(responseObject, @"agent_area") atIndexedSubscript:4];
        }
        [self reloadSection:4];
    } failure:^(id error) {
        
    }];
}

- (IBAction)submitAudit:(UIButton *)sender{
    
    [MBProgressHUD showActivityMessageInWindow:@"正在添加..."];

    if ([self isContextNull]) {
        return;
    }
    
    if ([self isHeaderImagesNull]) {
        return;
    }
    
    if (!self.isSelectAgreement) {
        return [MBProgressHUD showTipMessageInWindow:@"请先同意协议"];
    }
    if ([self.context isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入店铺介绍"];
        return;
    }
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *imagsUrlArray = [NSMutableArray array];
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self.imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self upLoadIamgesView:obj updataSccuss:^(NSString *imageUrl) {
                [imagsUrlArray addObject:imageUrl];
                dispatch_semaphore_signal(semaphore);

            } failure:^(id error) {
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        }];
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (imagsUrlArray.count == 4) {
            NSLog(@"---%@",imagsUrlArray);
            [self upLoadStoreIamgs:imagsUrlArray];
        }else{
            
//            [MBProgressHUD showTipMessageInWindow:@"图片上传失败请重试！"];
        }
    });
    
}

// 上传店铺图片
- (void)upLoadStoreIamgs:(NSArray *)idImager{
    dispatch_group_t group1 = dispatch_group_create();
    NSMutableArray *imagsUrlArray1 = [NSMutableArray array];
    
    dispatch_group_async(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
        [self.storeImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"---第-%lu--开始上传",(unsigned long)idx);
            [self upLoadIamgesView:obj updataSccuss:^(NSString *imageUrl) {
                dispatch_semaphore_signal(semaphore1);
                [imagsUrlArray1 addObject:imageUrl];
                NSLog(@"---第-%d--上传成功",idx);
                
            } failure:^(id error) {
                dispatch_semaphore_signal(semaphore1);
                
            }];
            dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
            
        }];
        
    });
    dispatch_group_notify(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"成功");
        NSLog(@"---%@",imagsUrlArray1);
        NSDictionary *dic;
        if (self.isyw == 2) {
            dic = @{@"user_id":[UserInfoManager sharedManager].user_id
                    ,@"linkman":self.contextArray[0]
                    ,@"mobile":self.contextArray[1]
                    ,@"address":self.contextArray[3]
                    ,@"industry":self.industryId
                    ,@"province":_province
                    ,@"city":_city
                    ,@"district":_district
                    ,@"business":@""
                    ,@"shop_name":self.contextArray[5]
                    ,@"content":self.context //店铺介绍
                    ,@"shop_img":idImager[0]
                    ,@"license_img":idImager[1]
                    ,@"idcard_img":idImager[2]
                    ,@"idcard_fimg":idImager[3]
                    ,@"imgs":[self setStoreImagesaArrayString:imagsUrlArray1]
                     //isyw:1:业务员  0：代理商
                    };

        }else{
            dic = @{@"user_name":self.contextArray[0]
                    ,@"parent":self.contextArray[1]
                    ,@"real_name":self.contextArray[2]
                    ,@"mobile_phone":self.contextArray[3]
                    ,@"address":self.contextArray[5]
                    ,@"industry":self.industryId
                    ,@"business":@""
                    ,@"province":_province
                    ,@"city":_city
                    ,@"district":_district
                    ,@"shop_name":self.contextArray[7]
                    ,@"content":self.context //店铺介绍
                    ,@"shop_img":idImager[0]
                    ,@"license_img":idImager[1]
                    ,@"idcard_img":idImager[2]
                    ,@"idcard_fimg":idImager[3]
                    ,@"imgs":[self setStoreImagesaArrayString:imagsUrlArray1]
                    ,@"isyw":@(self.isyw) //isyw:1:业务员  0：代理商
                    ,@"user_id":[UserInfoManager sharedManager].user_id
                    };

        }
        
        [KSRequestManager postRequestWithUrlString: self.isyw == 2 ? URL_user_add_shop :URL_add_shop parameter:dic success:^(id responseObject) {
            NSLog(@"---%@",responseObject);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showTipMessageInWindow:@"添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_updataSuccess) {
                    _updataSuccess();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(id error) {
            
        }];
        
    });
    

}

//拼接店铺展示图
- (NSString *)setStoreImagesaArrayString:(NSArray *)imagesArray{
   __block NSString *urlStrin  =@"";
    [imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([urlStrin isEqualToString:@""]) {
            urlStrin = obj;
        }else{
            urlStrin = [NSString stringWithFormat:@"%@|%@",urlStrin,obj];
        }
    }];
    return urlStrin;
}

/**
 *
 47.代理商中心添加商家接口:api/agent.php?act=add_shop
 上传参数:用户id:user_id
 身份：isyw:1:业务员  0：代理商
 */
- (void)upLoadIamgesView:(UIImage *)image updataSccuss:(void(^)(NSString *imageUrl))upLoadSuccess failure:(void(^)(id error))failureImageUrl{
    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:nil images:@[image] success:^(id responseObject) {
        upLoadSuccess(KSDIC(responseObject, @"imgs"));
    } failure:^(NSError *error) {
        failureImageUrl(nil);
    }];
}

- (BOOL)isHeaderImagesNull{
    __block  BOOL isFlog;

    NSArray <NSString *>* stingsArray = @[@"请上传门头照片",@"请上传营业执照",@"请上传法人身份证正面",@"请上传法人身份证反面"];
    [self.imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL *     _Nonnull stop) {
  
        if ([obj isKindOfClass:[NSString class]]) {
            isFlog = YES;
            [MBProgressHUD showTipMessageInWindow:stingsArray[idx]];
        }
    }];
    return isFlog;

}

/** 效验输入框的内容*/
- (BOOL)isContextNull{
    
  __block  BOOL isFlog;
    NSArray *array = nil;
    if (self.isyw == 2) {
         array = @[@"请输入店铺人姓名",@"请输入联系电话",@"选择省市区",@"",@"请选择所属行业",@"请输入店铺名"];
    }else{
        array = @[@"请输入会员账号",@"",@"请输入联系人姓名",@"请输入联系人电话",@"",@"",@"请选择所属行业",@"请输入店铺名"];

    }
    [self.contextArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@""]) {
            if ([array[idx] isEqualToString:@""]) {
                isFlog = NO;
            }else{
                [MBProgressHUD showTipMessageInWindow:array[idx]];
                isFlog = YES;
            }
            *stop =YES;

        }
    }];
    
    return isFlog;
}

- (void)initTableView{
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    self.title = @"上传商家";
    [self registerTableVieCellsArray:@[@"MerchantsListCell",@"ShopIntroducedVC",@"IdMerchantsImageCell",@"StoreImageViewCell"]];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count + 3 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section <= self.datasMutabArray.count -1) {
        MerchantsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantsListCell" forIndexPath:indexPath];
        cell.nameLabel.text = self.datasMutabArray[indexPath.section];
        cell.contextField.placeholder = self.placeholderArray[indexPath.section];
        cell.contextField.text = self.contextArray[indexPath.section];
        cell.contextField.tag = indexPath.section;
        cell.contextField.delegate  =self;
        [cell.contextField addTarget:self action:@selector(contextFieldClick:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section ==3 || indexPath.section == 4 ) {
            cell.statr.hidden = NO;
        }else{
            cell.statr.hidden = YES;
        }
        return cell;
    }
    else if (indexPath.section == self.datasMutabArray.count ){
        WeakSelf
        ShopIntroducedVC *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopIntroducedVC" forIndexPath:indexPath];
        cell.contextBlock = ^(NSString *context){
            weakSelf.context = context;
        };
        return cell;
    }else if (indexPath.section == self.datasMutabArray.count +1){
        IdMerchantsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdMerchantsImageCell" forIndexPath:indexPath];
        WeakSelf
        cell.baseCell_buttonIndex = ^(NSInteger index){
            [weakSelf setIdImagesCellClick:index];
        };
        return cell;
    }else if (indexPath.section == self.datasMutabArray.count +2){
        WeakSelf
        StoreImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreImageViewCell" forIndexPath:indexPath];
        cell.imageViews.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell.isSelectAgreement addTarget:self action:@selector(isSelectAgreementClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.imageViews.imageArr = [self.storeImages mutableCopy];
        [cell.imageViews setColumn:4 maximumNumberOfSelection:4];
        cell.imageViews.block =^{
            weakSelf.storeImages = cell.imageViews.imageArr;
        };
        return cell;
    }
    return nil;
  
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section <= self.datasMutabArray.count - 1) {
        return 44;
    }else if (indexPath.section == self.datasMutabArray.count)
    {
        return 80;
    }else if (indexPath.section == self.datasMutabArray.count +1){
        return KS_H(274.0f);
    }
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

static char objc_menus_button;
- (void)setIdImagesCellClick:(NSInteger)index{
    IdMerchantsImageCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.datasMutabArray.count +1]];
    WeakSelf
    [KSTool alertViewWithController:self title:@"请选择" message:nil items:@[@"相机",@"相册"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
        [self ipadCamereWithConeroller:weakSelf SourceType:indx == 0 ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary allowsEditing:NO];
    }];
    UIButton *sender = cell.menusButton[index];
    objc_setAssociatedObject(self, &objc_menus_button, sender,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ipadCamereWithConeroller:(id)viewController SourceType:(UIImagePickerControllerSourceType)SourceType allowsEditing:(BOOL)allowsEditing{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        if (SourceType == UIImagePickerControllerSourceTypeCamera) {
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"模拟器不支持相机");
                return;
            }
        }
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    [ipc.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    ipc.sourceType = SourceType;
    
    ipc.delegate = self;
    ipc.allowsEditing = allowsEditing;
    
    [viewController presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIButton *sender = objc_getAssociatedObject(self, &objc_menus_button);
    [sender setImage:KSDIC(info, @"UIImagePickerControllerOriginalImage") forState:UIControlStateNormal];
    [self.imagesArray setObject:KSDIC(info, @"UIImagePickerControllerOriginalImage") atIndexedSubscript:sender.tag];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
 
}


- (void)contextFieldClick:(UITextField *)textField{
    if (self.isyw == 2) {
        
    }else{
        if (textField.tag == 0) {
            if (textField.text.length == 11) {
                [KSRequestManager postRequestWithUrlString:URL_get_user_info parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"username":textField.text} success:^(id responseObject) {
                    NSLog(@"---%@",responseObject);
                    if ([[responseObject objectForKey:@"user_id"] integerValue] >0) {
                        [KSTool alertViewWithController:self title:@"温馨提示" message:@"您输入的账号已存在" items:@[@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
                            [textField endEditing:YES];
                            textField.text = @"";
                            [self.contextArray setObject:textField.text atIndexedSubscript:textField.tag];

                        }];
                    }
                } failure:^(id error) {
                    
                }];
            }
        }
       
    }
    [self.contextArray setObject:textField.text atIndexedSubscript:textField.tag];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    WeakSelf

    NSInteger idx1;
    NSInteger idx2;
    if (self.isyw == 2) {
        idx1 =2;
        idx2 = 4;
    }else{
        idx1 =4;
        idx2 = 6;
    }
    
    if (textField.tag == idx1) {
        if (self.isyw == 2) {
            
            [self showMensuAddress];

        }else if (self.isyw ==1){
            NSArray *objc_Datas = objc_getAssociatedObject(self, &objc_deleteType);
            [self showAlerView:[self arrayIemsData:objc_Datas keyString:@"anames"] blockIndex:^(NSInteger idx) {
                textField.text = KSDIC(objc_Datas[idx], @"anames");
                [weakSelf.contextArray setObject:textField.text atIndexedSubscript:textField.tag];
                weakSelf.province = KSDIC(objc_Datas[idx], @"province");
                weakSelf.city = KSDIC(objc_Datas[idx], @"city");
                weakSelf.district = KSDIC(objc_Datas[idx], @"district");
            }];
        }
        else{
            [self getTheAgentInformation];

        }
        return NO;
    }
    
    if (textField.tag == idx2) {
        [self loadItemsColltionView:^(id data) {
            textField.text = KSDIC(data, @"title");
            weakSelf.industryId = KSDIC(data, @"id");
            [weakSelf.contextArray setObject:textField.text atIndexedSubscript:textField.tag];
        }];
        return NO;
    }
    [self.contextArray setObject:textField.text atIndexedSubscript:textField.tag];

    return YES;
}


- (void)loadItemsColltionView:(void(^) (id data))successData{
    WeakSelf
    [KSRequestManager postRequestWithUrlString:URL_get_industry parameter:@{@"limit":@0} success:^(id responseObject) {
        [weakSelf showAlerView:[weakSelf arrayIemsData:responseObject[@"lists"] keyString:@"title"]  blockIndex:^(NSInteger idx) {
            successData(responseObject[@"lists"][idx]);
        }];
    } failure:^(id error) {
        
    }];
}

- (NSArray <NSString *>*)arrayIemsData:(id)responseObject keyString:(NSString *)keyString{
    NSMutableArray *array = [NSMutableArray array];
    [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:KSDIC(obj, keyString)];
    }];
    return array;
}

- (void)showAlerView:(NSArray *)array blockIndex:(void(^)(NSInteger idx))index{
    
    [KSTool alertViewWithController:self title:@"请选择" message:nil items:array style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
        index(indx);
    }];
    
}

- (void)showMensuAddress{
    [self.view endEditing:YES];
    WeakSelf
    
    KSAddressView *addressView = [KSAddressView initBaseView];
    addressView.frame = [UIScreen mainScreen].bounds;
    addressView.addressPickViewBlock = ^(id province,id city,id arer){
        weakSelf.province = KSDIC(province, @"region_id");
        weakSelf.city = KSDIC(city, @"region_id");
        weakSelf.district = KSDIC(arer, @"region_id");
        NSString *addr = [NSString stringWithFormat:@"%@%@%@",KSDIC(province, @"region_name"),KSDIC(city, @"region_name"),KSDIC(arer, @"region_name")];
        [self.contextArray setObject:addr atIndexedSubscript:2];
        [self reloadSection:2];

    };
    [addressView baseXIB_showAlpha:.3 color:nil];
}

- (void)isSelectAgreementClick:(UIButton *)sender{
    sender.selected = ! sender.selected;
    _isSelectAgreement = sender.selected;
}

@end
