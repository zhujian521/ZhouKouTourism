//
//  MyOrderViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/8.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderTableViewCell.h"
#import "UIAlertController+Blocks.h"
#import "OrderDetailViewController.h"
@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation MyOrderViewController

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


- (void)loadData {
    __weak typeof(self)weakSelf = self;
    NSString *biaoName = [NSString stringWithFormat:@"Order_%@",AVUser.currentUser.objectId];
    [HUDManager showLoading];
    AVQuery *query = [AVQuery queryWithClassName:biaoName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"%@",objects);
        [HUDManager hidenHud];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableView reloadData];
    }];

    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH - kNavBarHAbove7 - kBottomSafeHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = self.dataArray[indexPath.row];
    cell.productTitle.text = [NSString stringWithFormat:@"名称：%@",[item objectForKey:@"productName"]];
    cell.priceLabel.text = [NSString stringWithFormat:@"价格：%@元",[item objectForKey:@"price"]];
    cell.accountLabel.text = [NSString stringWithFormat:@"数量：%@",[item objectForKey:@"productNum"]];
    cell.totalLabel.text = [NSString stringWithFormat:@"总价：¥%@",[item objectForKey:@"productPrice"]];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:[item objectForKey:@"url"]]];
    cell.productDescribe.text = [item objectForKey:@"product_describe"];
    cell.deleteOrderButton.tag = indexPath.row;
    [cell.deleteOrderButton addTarget:self action:@selector(handleDeleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    if ([[item objectForKey:@"status"] isEqualToString:@"1"]) {
        cell.orderStatusLabel.text = @"状态：待发货";
        cell.deleteOrderButton.hidden = NO;
    }else if ([[item objectForKey:@"status"] isEqualToString:@"2"]) {
        cell.orderStatusLabel.text = @"状态：已发货";
        cell.deleteOrderButton.hidden = YES;
    }else if ([[item objectForKey:@"status"] isEqualToString:@"3"]) {
        cell.orderStatusLabel.text = @"状态：已签收";
        cell.deleteOrderButton.hidden = YES;
    }else{
        cell.orderStatusLabel.text = @"状态：已取消";
        cell.deleteOrderButton.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 241;
}

    
- (void)handleDeleteOrder:(UIButton *)sender {
    [UIAlertController showAlertInViewController:self withTitle:@"提示" message:@"是否取消该订单？" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil paras:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex, id  _Nonnull paras) {
        if (buttonIndex == 1) {
            AVObject *item = self.dataArray[sender.tag];
            NSString *biaoName = [NSString stringWithFormat:@"Order_%@",AVUser.currentUser.objectId];
            AVQuery *query = [AVQuery queryWithClassName:biaoName];
            [query whereKey:@"objectId" equalTo:item.objectId];
            [item setObject:@"0" forKey:@"status"];
            AVSaveOption *option = [[AVSaveOption alloc]init];
            option.query = query;
            [item saveInBackgroundWithOption:option block:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [self loadData];
                }else{
                    NSLog(@"%@",error);
                }
            }];
        
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVObject *item = self.dataArray[indexPath.row];
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc]init];
    orderDetailVC.item = item;
    orderDetailVC.title = @"订单详情";
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}


@end
