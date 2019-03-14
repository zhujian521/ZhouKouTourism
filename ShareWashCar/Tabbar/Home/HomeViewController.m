//
//  HomeViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeDetailViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.dataArray = [NSMutableArray array];
    [self creatTableView];
    [self lodData];
}


- (void)lodData{
    __weak typeof(self)weakSelf = self;
    [HUDManager showLoading];
    AVQuery *query = [AVQuery queryWithClassName:@"tb_city"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [HUDManager hidenHud];
                for (AVObject *item in objects) {
                    NSLog(@"aaa--------%@",[item objectForKey:@"title"]);
                    NSLog(@"%@",item);
                    
                }
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableView reloadData];
    }];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH - kNavBarHAbove7 - kTabBarHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = self.dataArray[indexPath.row];
    cell.titleLabel.text = [item objectForKey:@"title"];
    cell.attentionLabel.text = [NSString stringWithFormat:@"开放时间：%@",[item objectForKey:@"tb_attention"]];
    cell.priceLabel.text = [item objectForKey:@"tb_money"];
    AVFile *file = [item objectForKey:@"tb_image"];
    NSLog(@"%@",file.url);
    [cell.imagePicture sd_setImageWithURL:[NSURL URLWithString:file.url]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVObject *item = self.dataArray[indexPath.row];
    HomeDetailViewController *homeVC = [[HomeDetailViewController alloc]init];
    homeVC.item = item;
    homeVC.title = [item objectForKey:@"title"];
    homeVC.commentClassName = [NSString stringWithFormat:@"comment%@",[item objectForKey:@"objectId"]];
    [self.navigationController pushViewController:homeVC animated:YES];
    
}



@end
