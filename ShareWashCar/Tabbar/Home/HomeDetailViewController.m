//
//  HomeDetailViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/4.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "CommentViewController.h"
#import "InformationView.h"
#import "HomeDetailTableViewCell.h"
@interface HomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIView *tableHeadView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)InformationView *informationView;
@property (nonatomic ,assign)BOOL collectionStatus;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"评论" style:UIBarButtonItemStyleDone target:self action:@selector(handleCommontAction)];
    self.dataArray = [NSMutableArray array];
    [self creatTableView];
    [self creatHeadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadComment];
    [self checkCollectionStatus];
}

- (void)handleCommontAction {
    NSString *user = [kUserDefaults objectForKey:@"username"];
    if (user.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    CommentViewController *commentVC = [[CommentViewController alloc]init];
    commentVC.commentClassName = self.commentClassName;
    commentVC.item = self.item;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavBarHAbove7 - kBottomSafeHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)creatHeadView {
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2)];
    self.tableView.tableHeaderView = self.tableHeadView;
//    self.tableHeadView.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 2 / 3)];
    [self.tableHeadView addSubview:imageView];
    AVFile *file = [self.item objectForKey:@"tb_image"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:file.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"%@",image);
   
    }];
    
    InformationView *informationView = [[[NSBundle mainBundle] loadNibNamed:@"InformationView" owner:nil options:nil] lastObject];
    self.informationView = informationView;
    [informationView.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    [informationView.collectionButton setTitle:@"取消收藏" forState:UIControlStateSelected];
    [informationView.collectionButton addTarget:self action:@selector(handleCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tableHeadView addSubview:informationView];
    informationView.sd_layout.topSpaceToView(imageView, 10).heightIs(100).widthIs(kScreenW);
//    informationView.backgroundColor = [UIColor redColor];
    informationView.priceLabel.text = [self.item objectForKey:@"tb_money"];
    informationView.timeAttention.text = [NSString stringWithFormat:@"开放时间：%@",[self.item objectForKey:@"tb_attention"]];
    informationView.addressLabel.text = [self.item objectForKey:@"address"];
    
    CGFloat textHeight = [NSString heightForString:[self.item objectForKey:@"content"] fontSize:17 andWidth:kScreenW - 20];
    NSLog(@"%lf==%@",textHeight,[self.item objectForKey:@"content"]);
   
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:17];
    contentLabel.text = [self.item objectForKey:@"content"];
    [self.tableHeadView addSubview:contentLabel];
    contentLabel.sd_layout.leftSpaceToView(self.tableHeadView,10).rightSpaceToView(self.tableHeadView, 10).topSpaceToView(informationView, 0).heightIs(textHeight + 10);
    self.tableHeadView.sd_layout.heightIs(textHeight + imageView.height + informationView.height + 100);
    
    UIView *blueView = [[UIView alloc]init];
    [self.tableHeadView addSubview:blueView];
    blueView.sd_layout.leftSpaceToView(self.tableHeadView, 10).topSpaceToView(contentLabel, 45).widthIs(6).heightIs(25);
    blueView.backgroundColor = RGBColor(110, 144, 213);
    blueView.layer.masksToBounds = YES;
    blueView.layer.cornerRadius = 2;
    
    UILabel *headLabel = [[UILabel alloc]init];
    [self.tableHeadView addSubview:headLabel];
    headLabel.sd_layout.centerYEqualToView(blueView).leftSpaceToView(blueView, 10).heightIs(20).rightSpaceToView(self.tableHeadView, 10);
    headLabel.text = @"评论";
    
    UILabel *line = [[UILabel alloc]init];
    [self.tableHeadView addSubview:line];
    line.sd_layout.bottomSpaceToView(self.tableHeadView, 0).heightIs(1).leftSpaceToView(self.tableHeadView, 0).rightSpaceToView(self.tableHeadView, 0);
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *contentBottom = [[UIView alloc]init];
    [self.tableHeadView addSubview:contentBottom];
    contentBottom.sd_layout.leftSpaceToView(self.tableHeadView, 0).rightSpaceToView(self.tableHeadView, 0).topSpaceToView(contentLabel, 5).heightIs(15);
    contentBottom.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)loadComment {
    AVQuery *query = [AVQuery queryWithClassName:self.commentClassName];
    [HUDManager showLoadingHud:@"加载中" onView:self.view];
    __weak typeof(self)weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"%@",objects);
        [HUDManager hidenHudFromView:weakSelf.view];
        [weakSelf.dataArray removeAllObjects];
        for (AVObject *item1 in objects) {
            NSLog(@"%@",[item1 objectForKey:@"content"]);
            NSLog(@"%@",[item1 objectForKey:@"name"]);
            NSLog(@"%@",[item1 objectForKey:@"createdAt"]);
            [weakSelf.dataArray addObject:item1];
        }
        [weakSelf.tableView reloadData];
    }];

}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = self.dataArray[indexPath.row];
    cell.userName.text = [item objectForKey:@"name"];
    cell.contentLabel.text = [item objectForKey:@"content"];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *string = [fmt stringFromDate:item.createdAt];
    cell.creatTime.text = string;
    AVFile * avatarFile = [item objectForKey:@"avatar"];
    if (avatarFile) {
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:avatarFile.url]
                                      placeholderImage:[UIImage imageNamed:@"WechatIMG1792"]];
    } else {
        cell.userImage.image = [UIImage imageNamed:@"user"];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)handleCollectionAction {
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    AVUser *user = [AVUser currentUser];
    NSString *string = [NSString stringWithFormat:@"collection_%@",user.objectId];
    if (!self.collectionStatus) {
        AVFile *file = [self.item objectForKey:@"tb_image"];
        AVObject *todoFolder = [[AVObject alloc] initWithClassName:string];
        [todoFolder setObject:self.item.objectId forKey:@"id"];
        [todoFolder setObject:file forKey:@"tb_image"];
        [todoFolder setObject:[self.item objectForKey:@"tb_money"] forKey:@"tb_money"];
        [todoFolder setObject:[self.item objectForKey:@"tb_attention"] forKey:@"tb_attention"];
        [todoFolder setObject:[self.item objectForKey:@"address"] forKey:@"address"];
        [todoFolder setObject:[self.item objectForKey:@"content"] forKey:@"content"];
        [todoFolder setObject:[self.item objectForKey:@"title"] forKey:@"title"];
        [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [HUDManager showTextHud:@"收藏成功"];
                self.collectionStatus = YES;
                self.informationView.collectionButton.selected = YES;
                
            } else {
                [HUDManager showTextHud:@"收藏失败"];
            }
            
        }];
    } else {
        AVQuery *query = [AVQuery queryWithClassName:string];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            for (AVObject *item in objects) {
                if (self.pushFromMyStatus) {
                    if ([[item objectForKey:@"id"]isEqualToString:[self.item objectForKey:@"id"]]) {
                        [item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                            if (succeeded) {
                                [HUDManager showTextHud:@"取消收藏"];
                                self.collectionStatus = NO;
                                self.informationView.collectionButton.selected = NO;
                            } else {
                                [HUDManager showTextHud:@"取消收藏失败"];
                            }
                            
                        }];
                    }
                    
                } else {
                    if ([[item objectForKey:@"id"]isEqualToString:[self.item objectForKey:@"objectId"]]) {
                        [item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                            if (succeeded) {
                                [HUDManager showTextHud:@"取消收藏"];
                                self.collectionStatus = NO;
                                self.informationView.collectionButton.selected = NO;
                            } else {
                                [HUDManager showTextHud:@"取消收藏失败"];
                            }
                            
                        }];
                    }
                    
                }
               
            }
        }];

    }
  
}

- (void)checkCollectionStatus {
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        return;
    }
    AVUser *user = [AVUser currentUser];
    NSString *string = [NSString stringWithFormat:@"collection_%@",user.objectId];
    AVQuery *query = [AVQuery queryWithClassName:string];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (AVObject *item in objects) {
            if (self.pushFromMyStatus) {
                if ([[item objectForKey:@"id"]isEqualToString:[self.item objectForKey:@"id"]]) {
                    self.collectionStatus = YES;
                    self.informationView.collectionButton.selected = YES;
                }
                
            } else {
                if ([[item objectForKey:@"id"]isEqualToString:[self.item objectForKey:@"objectId"]]) {
                    self.collectionStatus = YES;
                    self.informationView.collectionButton.selected = YES;
                }
            }
          

        }
        
    }];
}
@end
