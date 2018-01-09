//
//  wHeadImageVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WHeadImageVC.h"
#import "UIImage+ImageEffects.h"
#import "UIButton+Extension.h"
#import "WHeadCell.h"
#import "WNickNameVC.h"
#import "WCheckIdeVC.h"
#import "WInfomationModel.h"
#import "UIButton+EMWebCache.h"
#import "UIViewController+OpenImagePicker.h"

static CGFloat kImageHeight = 240.0;
static CGFloat wFrame = 80;
static NSString *kCellID = @"cellID";

@interface WHeadImageVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    UIImageView *_headImage;//需要形变的图片视图
    UIButton *_headBtn;//需要形变的图片视图
    WInfomationModel *model;
    NSString *fileth;

}


@end

@implementation WHeadImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createDataSource];
    [self createTableView];
    [self loadRequsetData];}

-(void)createDataSource
{
    _dataSource = [NSMutableArray arrayWithObjects:@"昵称",@"实名认证", nil];
    self.title = @"个人资料";
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_wide, Screen_heigth) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(kImageHeight, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:@"WHeadCell" bundle:nil] forCellReuseIdentifier:kCellID];
    [self.view addSubview:_tableView];
    //设置图片
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -kImageHeight, Screen_wide, kImageHeight)];
    _headImage.userInteractionEnabled = YES;
    _headImage.contentMode =  UIViewContentModeRedraw;
    _headImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake((_headImage.frame.size.width - wFrame)/2, (_headImage.frame.size.height-wFrame)/2, wFrame, wFrame);
    if([self.url length] == 0)
    {
     [_headBtn setBackgroundImage:[UIImage imageNamed:@"lww"] forState:UIControlStateNormal];
    }
    else{
        [_headBtn sd_setImageWithURL:[NSURL URLWithString:self.url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"lww"]];
    }
    WeakSelf
    [_headBtn addClickMethod:^(UIButton *btn) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
          [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [weakSelf WphotoDeal:0];
         }]];
         [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [weakSelf WphotoDeal:1];
         }]];
         [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         }]];
         [weakSelf presentViewController:alertController animated:YES completion:nil];
     }];
    // 毛玻璃
    if([self.url length] >0)
    {
        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_url]];
        _headImage.image = [[[UIImage alloc]initWithData:data] blurImage];
    }
    else
    {
        _headImage.image = [[UIImage imageNamed:@"IMG_0014"] blurImage];
    }
    
    _headBtn.clipsToBounds = YES;
    _headBtn.layer.cornerRadius = wFrame/2;
    [_headImage addSubview:_headBtn];
    [_tableView addSubview:_headImage];
}
- (void)WphotoDeal:(NSInteger)tag
{
    if (tag==0)
    {
        [self openImagePickerWithAction:0
                              completed:^(UIImage *image,NSString * filePath) {
                                  
                                  fileth = filePath;
//                                  [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
//                                  _headImage.image = [image blurImage];
                                  [self WloadImage:image];
                               }];
    }
    else if(tag==1)
    {
        [self openImagePickerWithAction:1
                              completed:^(UIImage *image,NSString * filePath){
                                  
                                  fileth = filePath;
//                                  [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
//                                  _headImage.image = [image blurImage];
                                  [self WloadImage:image];

                               }];
        
    }
    
}


- (void)loadRequsetData{
    NSLog(@"%@",[UserInfoManager sharedManager].user_id);
    [KSRequestManager postRequestWithUrlString:URL_appinfomation parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if(KSDIC(responseObject, @"user") )
        {
            model = [WInfomationModel whc_ModelWithJson:responseObject keyPath:@"user"];
            [_tableView reloadData];
        }
    } failure:^(id error) {
    }];
}
- (void)WloadImage:(UIImage *)image{
    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:nil images:@[image] success:^(id responseObject)
    {
        if (![KSDIC( responseObject, @"imgs") isEqualToString:@""]) {
            NSString *imageUrl = KSDIC( responseObject, @"imgs");
             [self WUpdateImage:imageUrl];
        }
    } failure:^(NSError *error) {
    }];
    }
- (void)WUpdateImage:(NSString *)imageUrl
{
[KSRequestManager postRequestWithUrlString:URL_appinfoImageChange parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"headimg":imageUrl} success:^(id responseObject) {
         [_headBtn sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL, KSDIC(responseObject, @"headimg"))] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"lww"]];
        NSString *url = StringWithStr(URL_MANURL, KSDIC(responseObject, @"headimg"));
        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
        _headImage.image = [[[UIImage alloc]initWithData:data] blurImage];
        [MBProgressHUD showSuccessMessage:@"头像更新成功!"];
     } failure:^(id error) {
    }];
}
#pragma mark - tableView的代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.nickName.text = _dataSource[indexPath.row];
    cell.cheK.text = _dataSource[indexPath.row];
    cell.checkIde.tag = indexPath.row;
    cell.infoModol = model;
    cell.tag = indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            WNickNameVC *nick = [WNickNameVC new];
            nick.nick = ^(NSDictionary *nick){
                WHeadCell *nickCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                nickCell.cheK.text = nick[@"nick"];
            };
            [self.navigationController pushViewController:nick animated:YES];
        }
            break;
        case 1:
        {
            WCheckIdeVC *Ide = [WCheckIdeVC new];
            [self.navigationController pushViewController:Ide animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 滚动视图的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffSet = scrollView.contentOffset.y;//滚动y值
    CGFloat scale = [UIScreen mainScreen].bounds.size.width*1.0/kImageHeight;
    
    if (yOffSet < -kImageHeight) {
        CGRect imageRect = _headImage.frame;
        imageRect.origin.y = yOffSet;
        imageRect.size.height =  -yOffSet;
        imageRect.size.width = scale * imageRect.size.height;
        imageRect.origin.x = - (imageRect.size.width - [UIScreen mainScreen].bounds.size.width)/2;
        _headImage.frame = imageRect;
        _headBtn.frame = CGRectMake((_headImage.frame.size.width - wFrame)/2, (_headImage.frame.size.height-wFrame)/2, wFrame, wFrame);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
