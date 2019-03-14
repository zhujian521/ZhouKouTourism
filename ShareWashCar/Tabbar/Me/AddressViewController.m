//
//  AddressViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/7.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "AddViewController.h"
@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理收获地址";
    self.dataArray = [NSMutableArray array];
    [self creatTableView];
    UIButton *addAddressButton = [[UIButton alloc]init];
    [self.view addSubview:addAddressButton];
    addAddressButton.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, kBottomSafeHeight).heightIs(44);
    addAddressButton.backgroundColor = [UIColor redColor];
    [addAddressButton setTitle:@"新增收获地址" forState:UIControlStateNormal];
    [addAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddressButton addTarget:self action:@selector(handleAddAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [self setUpRefresh];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH - kNavBarHAbove7 - kBottomSafeHeight - 50)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = self.dataArray[indexPath.row];
    cell.phoneLable.text = [item objectForKey:@"phone"];
    cell.nameLabel.text = [item objectForKey:@"name"];
    cell.addressLabel.text = [item objectForKey:@"addr"];
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(handleDeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVObject *item = self.dataArray[indexPath.row];
    if (self.showDeleteButton) {
        if (self.selectAddressBlock) {
            self.selectAddressBlock(item);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)handleAddAddressAction {
    AddViewController *addVC = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)setUpRefresh{
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadAddressData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadAddressData {
    __weak typeof(self)weakSelf = self;
    NSString *biaoName = [NSString stringWithFormat:@"Address_%@",AVUser.currentUser.objectId];
    AVQuery *query = [AVQuery queryWithClassName:biaoName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"%@",objects);
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)handleDeleteAddress:(UIButton *)sender {
    AVObject *deleteItem = self.dataArray[sender.tag];
     NSString *biaoName = [NSString stringWithFormat:@"Address_%@",AVUser.currentUser.objectId];
    AVQuery *query = [AVQuery queryWithClassName:biaoName];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (AVObject *item in objects) {
            NSLog(@"%@",item);
            if ([[item objectForKey:@"objectId"]isEqualToString:[deleteItem objectForKey:@"objectId"]]) {
                [deleteItem deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        [HUDManager showTextHud:@"删除地址成功"];
                        [self.dataArray removeObject:deleteItem];
                        [self.tableView reloadData];

                    } else {
                        [HUDManager showTextHud:@"删除地址失败"];
                    }

                }];
            }
        }
    }];
}

@end
