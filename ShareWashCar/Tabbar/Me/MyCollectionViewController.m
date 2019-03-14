//
//  MyCollectionViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/8.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "HomeTableViewCell.h"
#import "HomeDetailViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self creatTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)refreshData {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
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


- (void)loadData {
    __weak typeof(self)weakSelf = self;
    AVUser *user = [AVUser currentUser];
    NSString *string = [NSString stringWithFormat:@"collection_%@",user.objectId];
    AVQuery *query = [AVQuery queryWithClassName:string];
    [HUDManager showLoading];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"%@",objects);
        [HUDManager hidenHud];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableView reloadData];
    }];
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
    homeVC.commentClassName = [NSString stringWithFormat:@"comment%@",[item objectForKey:@"id"]];
    homeVC.pushFromMyStatus = YES;
    [self.navigationController pushViewController:homeVC animated:YES];
    
}

    

@end
