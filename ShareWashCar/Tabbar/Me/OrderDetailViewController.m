//
//  OrderDetailViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/9.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderView.h"
#import "UIAlertController+Blocks.h"
@interface OrderDetailViewController ()
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIButton *cancleButton;
@property (nonatomic ,strong)OrderView *order;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadOrderView];
}

- (void)loadOrderView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH - kNavBarHAbove7 - kBottomSafeHeight - 50)];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    OrderView *orderView = [[[NSBundle mainBundle] loadNibNamed:@"OrderView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView = orderView;
    orderView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).heightIs(305);
    self.order = orderView;
    
    UIButton *addAddressButton = [[UIButton alloc]init];
    [self.view addSubview:addAddressButton];
    addAddressButton.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, kBottomSafeHeight).heightIs(44);
    addAddressButton.backgroundColor = [UIColor redColor];
    [addAddressButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [addAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddressButton addTarget:self action:@selector(handleAddAddressAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancleButton = addAddressButton;
    [self setOrderValue];
    
}

- (void)setOrderValue {
    if ([[self.item objectForKey:@"status"] isEqualToString:@"1"]) {
        self.order.orderStatusLabel.text = @"状态：待发货";
        self.cancleButton.hidden = NO;
    }else if ([[self.item objectForKey:@"status"] isEqualToString:@"2"]) {
        self.order.orderStatusLabel.text = @"状态：已发货";
        self.cancleButton.hidden = YES;
    }else if ([[self.item objectForKey:@"status"] isEqualToString:@"3"]) {
        self.order.orderStatusLabel.text = @"状态：已签收";
        self.cancleButton.hidden = YES;
    }else{
        self.order.orderStatusLabel.text = @"状态：已取消";
        self.cancleButton.hidden = YES;
    }
    self.order.productTitle.text = [NSString stringWithFormat:@"名称：%@",[self.item objectForKey:@"productName"]];
    self.order.priceLabel.text = [NSString stringWithFormat:@"价格：%@",[self.item objectForKey:@"price"]];
    self.order.accountLabel.text = [NSString stringWithFormat:@"数量：%@",[self.item objectForKey:@"productNum"]];
    self.order.totalPrice.text = [NSString stringWithFormat:@"总价：¥%@",[self.item objectForKey:@"productPrice"]];
    [self.order.productImage sd_setImageWithURL:[NSURL URLWithString:[self.item objectForKey:@"url"]]];
    self.order.userName.text = [NSString stringWithFormat:@"联系人姓名：%@",[self.item objectForKey:@"name"]];
    self.order.userPhone.text = [NSString stringWithFormat:@"联系人电话：%@",[self.item objectForKey:@"phone"]];
    self.order.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@ %@",[self.item objectForKey:@"addr"],[self.item objectForKey:@"addreDetails"]];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *string = [fmt stringFromDate:self.item.createdAt];
    self.order.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",string];
    
    
    
}

- (void)handleAddAddressAction {
    [UIAlertController showAlertInViewController:self withTitle:@"提示" message:@"是否取消该订单？" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil paras:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex, id  _Nonnull paras) {
        if (buttonIndex == 1) {
            NSString *biaoName = [NSString stringWithFormat:@"Order_%@",AVUser.currentUser.objectId];
            AVQuery *query = [AVQuery queryWithClassName:biaoName];
            [query whereKey:@"objectId" equalTo:self.item.objectId];
            [self.item setObject:@"0" forKey:@"status"];
            AVSaveOption *option = [[AVSaveOption alloc]init];
            option.query = query;
            [self.item saveInBackgroundWithOption:option block:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [HUDManager showTextHud:@"取消成功"];
                    self.cancleButton.hidden = YES;
                    
                }else{
                    NSLog(@"%@",error);
                }
            }];
        }
    }];
    
}


@end
