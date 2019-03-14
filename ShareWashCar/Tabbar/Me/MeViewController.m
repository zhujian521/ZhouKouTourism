//
//  MeViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "MeViewController.h"
#import "TableHeadView.h"
#import "PersonCell.h"
#import "BaseImagePickerVC.h"
#import "AlertControllerTool.h"
#import "UserFeedBackViewController.h"
#import "TicketViewController.h"
#import "SettingViewController.h"
#import "MyOrderViewController.h"
#import "MyCollectionViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *titleArr;
@property (nonatomic ,strong)NSMutableArray *pictureArr;
@property (nonatomic ,strong)TableHeadView *headView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(246, 246, 246);
    self.title = @"我的";
    self.titleArr = [NSMutableArray arrayWithObjects:@"我的收藏",@"我的订单",@"优惠券",@"更多",nil];
    self.pictureArr = [NSMutableArray arrayWithObjects:@"colloction",@"jietu",@"jfsc",@"xtsz",@"leftmenu_invate",@"leftmenu_user-guide",@"leftmenu_more", nil];
    [self creatView];

}

- (void)creatView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self creatTableHeadView];
     self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[PersonCell class] forCellReuseIdentifier:@"cell"];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleToInfomation)];
    [self.headView.pictureImage addGestureRecognizer:tap1];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)creatTableHeadView {
    TableHeadView *headView = [[TableHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , kScreenW * 10 / 17)];
    self.headView = headView;
    self.tableView.tableHeaderView = headView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUserValue];

}

- (void)setUserValue {
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        self.headView.phoneLabel.text = @"点击请登录";
        self.headView.pictureImage.image = [UIImage imageNamed:@"user"];
       
    } else {
        AVUser *currentUser = [AVUser currentUser];
        self.headView.phoneLabel.text = currentUser.username;
        AVFile * avatarFile = [currentUser objectForKey:@"avatar"];
        if (avatarFile) {
            [self.headView.pictureImage sd_setImageWithURL:[NSURL URLWithString:avatarFile.url]
                                          placeholderImage:[UIImage imageNamed:@"WechatIMG1792"]];
        }
        
    }
   
    
}

- (void)handleToInfomation {
    NSLog(@"======");
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    __weak typeof(self)weakself = self;
    [AlertControllerTool alertController:weakself AndAlertTitle:nil AndMessage:nil AndActionTitle1:@"从相册" AndActionBolck1:^(id json) {
        BaseImagePickerVC *imagePicker = [[BaseImagePickerVC alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = weakself;
        [weakself presentViewController:imagePicker animated:YES completion:nil];
        
    } AndActionTitle2:@"相机" AndActionBlock2:^(id json) {
        BaseImagePickerVC *imagePicker = [[BaseImagePickerVC alloc] init];
        imagePicker.delegate = weakself;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [weakself presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.headView.pictureImage.image = image;
    NSData * imageData = UIImagePNGRepresentation(image);
    AVUser *currentuser = [AVUser currentUser];
    AVFile *avatarFile = [AVFile fileWithData:imageData];
    [currentuser setObject:avatarFile forKey:@"avatar"];
    [currentuser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [HUDManager showTextHud:@"头像上传成功"];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setPicturePath:self.pictureArr[indexPath.row] AndTitleName:self.titleArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if (indexPath.row == 2) {
        TicketViewController *ticketVC = [[TicketViewController alloc]init];
        ticketVC.title = @"我的优惠券";
        [self.navigationController pushViewController:ticketVC animated:YES];
        
    } else if(indexPath.row == 3) {
        SettingViewController *settingVC = [[SettingViewController alloc]init];
        settingVC.title = @"我的设置";
        [self.navigationController pushViewController:settingVC animated:YES];
        
    } else if(indexPath.row == 0) {
        MyCollectionViewController *collectionVC = [[MyCollectionViewController alloc]init];
        collectionVC.title = @"我的收藏";
        [self.navigationController pushViewController:collectionVC animated:YES];
    }else {
        MyOrderViewController *orderVC = [[MyOrderViewController alloc]init];
        orderVC.title = @"我的订单";
        [self.navigationController pushViewController:orderVC animated:YES];
    }

}


@end
