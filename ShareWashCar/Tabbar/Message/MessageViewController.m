//
//  MessageViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "MessageViewController.h"
#import "WWCollectionViewCell.h"
#import "ProductDetailViewController.h"
@interface MessageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"特产";
    self.dataArr = [NSMutableArray array];
    [self creatCollection];
    [self refreshData];
}

- (void)refreshData {
    __weak typeof (self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)loadData {
    __weak typeof(self)weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:@"specialty"];
    [HUDManager showLoading];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [HUDManager hidenHud];
        NSLog(@"%@",objects);
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.dataArr removeAllObjects];
        [weakSelf.dataArr addObjectsFromArray:objects];
        [weakSelf.collectionView reloadData];
    }];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavBarHAbove7 - kTabBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
    }
    return _collectionView;
}

- (void)creatCollection {
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WWCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark =================  注释内容 =============
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
//    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    AVObject *item = [self.dataArr objectAtIndex:indexPath.row];
    AVFile *file =[item objectForKey:@"url_image"];
    cell.urlImage.contentMode = UIViewContentModeScaleAspectFit;
    [cell.urlImage sd_setImageWithURL:[NSURL URLWithString:file.url]];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"title"]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float width=(kScreenW - 4)/2;
    return CGSizeMake(width, width);
}

//设置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0f;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1.0f, 0.0f, 1.0f, 0.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AVObject *item = [self.dataArr objectAtIndex:indexPath.row];
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
    productVC.item = item;
    productVC.title = [item objectForKey:@"title"];
    [self.navigationController pushViewController:productVC animated:YES];
}

@end
