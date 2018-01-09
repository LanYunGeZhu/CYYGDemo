//
//  KSBaseViewController.m
//  HSH
//
//  Created by kangshibiao on 16/5/30.
//  Copyright © 2016年 mc. All rights reserved.
//

#import "KSBaseViewController.h"
#import "KSBaseXIBView.h"
#import "ErrorView.h"
#import "KSPickView.h"
@interface KSBaseViewController ()

@end

@implementation KSBaseViewController

- (NSMutableArray *)datasMutabArray{
    if (!_datasMutabArray) {
        _datasMutabArray = [NSMutableArray array];
    }
    return _datasMutabArray;
}
- (NSMutableDictionary *)datasMutabDic{
    if (!_datasMutabDic) {
        _datasMutabDic = [[NSMutableDictionary alloc]init];
    }
    return _datasMutabDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"----        %@         ",NSStringFromClass([self class]));

    });
    [self setLeftDefultWithNav];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self reqserManager:nil url:nil];
//
//    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)loadRequsetData{
    for (int x = 0; x < 10; x ++) {
        
        [self.datasMutabArray addObject:@"0"];
    }
    
    
}

- (void)postRequsetWithUrlString:(NSString *)url
                       parameter:(id)parameter
                         success:(void (^)(id responseObject))success
{
    
}

- (void)reqserManager:(NSDictionary *)dic url:(NSString *)url{
    [KSRequestManager postRequestWithUrlString:url parameter:dic success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [self showErrorView:^{
            [MBProgressHUD showActivityMessageInWindow:@"加载中。。。"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self reqserManager:dic url:url];

            });
        }];
    }];
}

- (void)showErrorView:(void (^)())errorFailure{
   __weak ErrorView * error = [ErrorView initBaseView];
    error.loadButton = ^{
        [error removeFromSuperview];
        errorFailure();
    };
    [self.view addSubview:error];
}

- (void)setLeftWithImage:(NSString *)imageName action:(SEL)action
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:action];
}

- (void)setLeftDefultWithNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

/**
 *
 */
- (void)setLeftWithString:(NSString *)text action:(SEL)action{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:self action:action];
}

/**
 * 左边返回按钮 文字
 *
 * @param text   标题名字
 */
- (void)setLeftDefaultWithString:(NSString *)text{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];

}

/**
 * 右边按钮 图片
 * @param  imageName  图片名字
 * @param  action     回调事件
 */
- (void)setRightWithImage:(NSString *)imageName action:(SEL)action{
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:action];
}

/**
 * 右边按钮 文字
 * @param  imageName  图片名字
 * @param  action     回调事件
 */
- (void)setRightWithString:(NSString *)text action:(SEL)action{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:self action:action];
}

#pragma mark -- TableView 分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSString *)calculationDistance:(CLLocation* )loction latitude:(double)latitude longitude:(double)longitude{
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:latitude longitude: longitude];
    
    CLLocation *loc2 =[[CLLocation alloc] initWithLatitude:loction.coordinate.latitude longitude:loction.coordinate.longitude];
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
    
    NSLog(@"distance距离%f",distance);
    return [NSString stringWithFormat:@"离我%.2fKm",distance/1000];
}


- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavStatusBarRedColor:(UIColor *)color{
    if (color == [UIColor clearColor]) {
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;

    }else{
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;

    }
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)base_callPhone:(NSString *)mobile{
    [KSTool callPhone:mobile];
//    [KSTool alertViewWithController:self title:@"温馨提示" message:[NSString stringWithFormat:@"您确定要拨打%@",mobile] items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
//        if (indx == 1) {
//        }
//        
//    }];
}

/**
 * 弹出一个pickView
 * datasArray 二维数组 ，自动处理多个分区
 * selectArray  选择成功回调  数组 《包含 索引 内容》
 */
- (void)base_showPickViewListDatasArray:(NSArray *)datasArray selectArray:(void (^)(NSArray *array))selectArray
{
    KSPickView *pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
    pickView.datasArr = datasArray;
    pickView.blockArray = ^(NSArray *sArray){
        selectArray(sArray);
    };
    [pickView show];
}


static char objc_smlImage;
static char objc_bigImageUrl;
- (void)base_ToViewLargerVersion:(UIView *)view currentImageIndex:(NSInteger)currentImageIndex imageCount:(NSInteger )imageCount smlImage:(UIImage *)smlImage bigImageUrl:(NSArray< NSString *> *)bigImageUrl{
    objc_setAssociatedObject(self, &objc_smlImage, smlImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &objc_bigImageUrl, bigImageUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = currentImageIndex;
    photoBrowser.imageCount = imageCount;
    photoBrowser.sourceImagesContainerView = view;
    
    [photoBrowser show];
  
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return  objc_getAssociatedObject(self, &objc_smlImage);
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSArray *array = objc_getAssociatedObject(self, &objc_bigImageUrl);
    
    NSString *urlStr = array[index];
    return [NSURL URLWithString:urlStr];
}

- (void)dealloc{
    
    NSLog(@"-控制器 ---%@ --正常销毁",NSStringFromClass([self class]));
}



@end
