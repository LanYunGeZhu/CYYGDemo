//
//  ReleaseNewActivitiesVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ReleaseNewActivitiesVC.h"
#import "KSImageView.h"
#import "KSPickView.h"
#import "UIButton+AddID.h"
#import "ActivityManagementVC.h"
@interface ReleaseNewActivitiesVC ()

@property (weak,nonatomic) IBOutlet KSImageView *imaegsView;
//站位字符
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
//内容
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;

// 店铺名称
@property (weak, nonatomic) IBOutlet UIButton *storeName;
//活动名称
@property (weak, nonatomic) IBOutlet UITextField *theNameOfTheEvent;
// 开始时间
@property (weak, nonatomic) IBOutlet UIButton *startTimer;
// 结束时间
@property (weak, nonatomic) IBOutlet UIButton *endTimer;
//活动价格
@property (weak, nonatomic) IBOutlet UITextField *activityPrice;
//商品原价
@property (weak, nonatomic) IBOutlet UITextField *commodityPrice;
//每人限领
@property (weak, nonatomic) IBOutlet UITextField *eachLimitGet;
//活动总件
@property (weak, nonatomic) IBOutlet UITextField *aDirectorOfThe;

@end

@implementation ReleaseNewActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布新活动";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(releseClikc)];
    if (_model) {
        
        self.imaegsView.goodsEditor = YES;
        self.imaegsView.imageArr =[@[_model.imgs] mutableCopy];
        [self.startTimer setTitle:_model.stime forState:UIControlStateNormal];
        [self.endTimer setTitle:_model.etime forState:UIControlStateNormal];
        self.activityPrice.text = _model.price;
        self.commodityPrice.text = _model.sprice;
        self.eachLimitGet.text = _model.perorder;
        self.aDirectorOfThe.text = _model.maxorder;
        self.contextTextView.text =_model.content;
        [self.storeName setTitle:_model.shop_name forState:UIControlStateNormal];
        self.theNameOfTheEvent.text = _model.title;
        self.storeName.Id = [_model.shop_id integerValue];
        self.placeholder.text = @"";
    }else{
           self.imaegsView.imageArr = @[];
    }
 
    self.imaegsView.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.imaegsView setColumn:3 maximumNumberOfSelection:1];
    self.imaegsView.block =^{
        
    };
    [[WHC_KeyboardManager share]addMonitorViewController:self];
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//发布
- (void)releseClikc{

    if ([[self.storeName titleForState:UIControlStateNormal] isEqualToString:@"点击选择店铺"]) {
        [MBProgressHUD showTipMessageInWindow:@"请选择店铺"];
        return;
    }
    
    if ([self.theNameOfTheEvent.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入活动名称"];
        return;
    }
    if ([[self.startTimer titleForState:UIControlStateNormal] isEqualToString:@"开始时间"]) {
        [MBProgressHUD showTipMessageInWindow:@"请选择开始时间"];
        return;
    }
    
    if ([[self.endTimer titleForState:UIControlStateNormal] isEqualToString:@"结束时间"]) {
        [MBProgressHUD showTipMessageInWindow:@"请选择结束时间"];
        return;
    }
    
    if ([self.activityPrice.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入活动价格"];

        return;
    }
    if ([self.commodityPrice.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入商品原价"];
        
        return;
    }
    if ([self.eachLimitGet.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入每人限领件数"];
        
        return;
    }
    if ([self.aDirectorOfThe.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入活动总件数"];
        
        return;
    }
    if ([self.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入活动说明"];

        return;
    }
    
    if (self.imaegsView.imageArr.count == 0) {
        [MBProgressHUD showTipMessageInWindow:@"至少上传一张图片"];
        return;
    }
    [self upLoadIamgeViews:^(NSString *iamgesUrl) {
        if ([iamgesUrl isEqualToString:@""]) {
            [MBProgressHUD showTipMessageInWindow:@"图片上传失败请重试！"];
            return;
        }
        else{
            
            NSDictionary *dic = @{@"shop_id":@(self.storeName.Id)
                                  ,@"title":self.theNameOfTheEvent.text
                                  ,@"stime":[self.startTimer titleForState:UIControlStateNormal]
                                  ,@"etime":[self.endTimer titleForState:UIControlStateNormal]
                                  ,@"price":self.activityPrice.text
                                  ,@"sprice":self.commodityPrice.text
                                  ,@"perorder":self.eachLimitGet.text
                                  ,@"maxorder":self.aDirectorOfThe.text
                                  ,@"content":self.contextTextView.text
                                  ,@"imgs":iamgesUrl
                                  ,@"user_id":[UserInfoManager sharedManager].user_id
                                  ,@"oid":_model ? _model.iD : @""
                                  };
            [MBProgressHUD showActivityMessageInWindow:isSubmitted];
            [KSRequestManager postRequestWithUrlString:URL_shoper_activity_add parameter:dic success:^(id responseObject) {
                NSLog(@"---%@",responseObject);
                [MBProgressHUD hideHUD];
                [MBProgressHUD showTipMessageInWindow:@"提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ActivityManagementVC" object:nil];
                    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[ActivityManagementVC class ]]) {
                            [self.navigationController popToViewController:obj animated:YES];
                        }
                    }];
                });
            } failure:^(id error) {
                
            }];

        }
    }];
  
}


- (void)upLoadIamgeViews:(void(^)(NSString *iamgesUrl))imageUrl{
    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:@{} images:self.imaegsView.imageArr success:^(id responseObject)
    {
        imageUrl(KSDIC(responseObject, @"imgs"));
    } failure:^(NSError *error) {
        imageUrl (@"");
    }];

}

- (IBAction)mensClikc:(UIButton *)sender{
    [self.view endEditing:YES];
    if (sender.tag == 0) {
        // 选择店铺
        WeakSelf
        [self loadStoreNameList:^(NSArray *shops) {
            [weakSelf showPickViewListDatasArray:@[[weakSelf setShopsListArray:shops]] selectArray:^(NSArray *array) {
                [sender setTitle:array[0][@"context"] forState:UIControlStateNormal];
                id data = array[0];
                NSInteger index = [KSDIC(data, @"idx") integerValue];
                sender.Id = [shops[index] [@"id"] integerValue];
            }];
        }];
       
        
    }else if (sender.tag ==1){
        //开始时间
        [self showPickView:^(NSString *timer) {
            if ([self compareDate:timer withDate:[self currentTimer]] == -1 ) {
                [sender setTitle:timer forState:UIControlStateNormal];

            }else{
                [MBProgressHUD showTipMessageInWindow:@"活动开始时间必须大于当前时间"];
            }
        }];
    }else{
        //结束时间
        [self showPickView:^(NSString *timer) {
            if ([self compareDate:timer withDate:[self.startTimer titleForState:UIControlStateNormal]] == -1) {
                [sender setTitle:timer forState:UIControlStateNormal];
                
            }else{
                [MBProgressHUD showTipMessageInWindow:@"活动结束时间必须大于开始时间"];
            }
        }];
    }
}

- (void)loadStoreNameList:(void (^)(NSArray *shops))shopsList{
    [KSRequestManager postRequestWithUrlString:URL_shopsList parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        shopsList(responseObject[@"shops"]);
    } failure:^(id error) {
        
    }];
}

- (NSMutableArray *)setShopsListArray:(NSArray *)shopsList{
    NSMutableArray *array = [NSMutableArray array];
    [shopsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:KSDIC(obj, @"shop_name")];
    }];
    return array;
}

- (NSString *)currentTimer{
    
    NSDate *date = [NSDate date];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}

- (void)showPickView:(void (^)(NSString *timer))timerBlokc{
    KSPickView *pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypeDataPicker];
    pickView.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    pickView.dataPickerBlock = ^(NSString *dataString){
        timerBlokc(dataString);
    };
    [pickView show];
}

/**
 * 弹出一个pickView
 * datasArray 二维数组 ，自动处理多个分区
 * selectArray  选择成功回调  数组 《包含 索引 内容》
 */
- (void)showPickViewListDatasArray:(NSArray *)datasArray selectArray:(void (^)(NSArray *array))selectArray
{
    KSPickView *pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
    pickView.datasArr = datasArray;
    pickView.blockArray = ^(NSArray *sArray){
        selectArray(sArray);
    };
    [pickView show];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholder.text =@"请输入活动说明";
    }
    else{
        self.placeholder.text = @"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//方法已封装！日期格式请传入：2013-08-05 12:12:12；如果修改日期格式，比如：2013-08-05，则将[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];修改为[df setDateFormat:@"yyyy-MM-dd"];
-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}


@end
