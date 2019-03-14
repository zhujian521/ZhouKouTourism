//
//  SettingViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/8.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "MyColor.h"
#import "UIAlertController+Blocks.h"
#import "ZCRootVCTool.h"
#import "AddressViewController.h"
#import "UserFeedBackViewController.h"
#import "MessageController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSArray *dataArr;
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"地址管理",@"消息通知",@"意见反馈",@"清除缓存"];
    self.title = @"设置";
    [self creatView];
}

- (void)creatView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH - kNavBarHAbove7 - kBottomSafeHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    footView.backgroundColor = [UIColor clearColor];
    
    UIButton *nextButton = [[UIButton alloc]init];
    [footView addSubview:nextButton];
    nextButton.sd_layout.leftSpaceToView(footView,10).rightSpaceToView(footView,10).heightIs(44).centerYEqualToView(footView);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"chongzhi_sel"] forState:UIControlStateNormal];
    [nextButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(handleNext) forControlEvents:UIControlEventTouchUpInside];
    nextButton.backgroundColor = [MyColor navigationBarColor];
    self.tableView.tableFooterView = footView;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AddressViewController *addressVC = [[AddressViewController alloc]init];
        [self.navigationController pushViewController:addressVC animated:YES];
    }else if (indexPath.row == 1) {
        MessageController *messageVC = [[MessageController alloc]init];
        messageVC.title = @"消息";
        [self.navigationController pushViewController:messageVC animated:YES];
        
    }else if (indexPath.row == 2) {
        UserFeedBackViewController *VC = [[UserFeedBackViewController alloc]init];
        VC.title = @"意见反馈";
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 3) {
        [HUDManager showTextHud:@"清除缓存成功"];
    }
   
    
}

- (void)handleNext {
    __weak typeof(self)weakSelf = self;
    [UIAlertController showAlertInViewController:self withTitle:@"退出登录？" message:@"确定要退出本次登录吗？" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil paras:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex, id  _Nonnull paras) {
        if (buttonIndex == 1) {
            [kUserDefaults setObject:@"" forKey:@"username"];
            [kUserDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}





@end
