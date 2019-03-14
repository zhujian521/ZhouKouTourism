//
//  ProductDetailViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/6.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductInfomationView.h"
#import "ATChooseCountView.h"
#import <Social/Social.h>
#import "AddressViewController.h"

@interface ProductDetailViewController ()
@property (nonatomic ,strong)ProductInfomationView *informationView;
@property (nonatomic ,strong)ATChooseCountView *chooseCountView;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)AVObject *tempItem;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatProductInformation];
}

- (void)creatProductInformation {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW  , kScreenH - kNavBarHAbove7 - kBottomSafeHeight - 50)];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.informationView = [[[NSBundle mainBundle] loadNibNamed:@"ProductInfomationView" owner:self options:nil] lastObject];
//    self.informationView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:self.informationView];
    self.tableView.tableHeaderView = self.informationView;
    self.informationView.sd_layout.widthIs(kScreenW).heightIs(430).leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0);
    self.informationView.productImageHight.constant = kScreenW * 12 / 19;
    self.informationView.sd_layout.heightIs(460 - 180 + kScreenW * 12 / 19);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSelectAddressAction)];
     UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSelectAddressAction)];
    self.informationView.rightImage.userInteractionEnabled = YES;
    [self.informationView.rightImage addGestureRecognizer:tap1];
    self.informationView.addressLabel.userInteractionEnabled = YES;
    [self.informationView.addressLabel addGestureRecognizer:tap];
   
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.text = @"数量";
    [self.informationView addSubview:countLabel];
countLabel.sd_layout.topSpaceToView(self.informationView.addressLabel, 35).leftSpaceToView(self.informationView, 15).widthIs(90).heightIs(30);
    countLabel.font = [UIFont systemFontOfSize:17];
    
    self.chooseCountView = [[ATChooseCountView alloc]init];
    [self.informationView addSubview:self.chooseCountView];
    self.chooseCountView.countColor = [UIColor redColor];
    self.chooseCountView.canEdit = NO;
    self.chooseCountView.sd_layout.leftSpaceToView(self.informationView, 80).centerYEqualToView(countLabel).heightIs(40).widthIs(150);
    [self.informationView.shareButton addTarget:self action:@selector(handleShareAction) forControlEvents:UIControlEventTouchUpInside];
    [self creatBottoView];
    [self setInformationValue];
    
}

- (void)creatBottoView {
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, kBottomSafeHeight).heightIs(50);
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *payButton = [[UIButton alloc]init];
    [bottomView addSubview:payButton];
    payButton.sd_layout.rightSpaceToView(bottomView, 0).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kScreenW / 2);
    [payButton  setTitle:@"立即购买" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payButton.backgroundColor = [UIColor orangeColor];
    [payButton addTarget:self action:@selector(handlePayForOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *customerButton = [[UIButton alloc]init];
    [bottomView addSubview:customerButton];
    customerButton.sd_layout.centerXEqualToView(bottomView);
    customerButton.sd_layout.leftSpaceToView(bottomView, 20).widthIs(150).heightIs(50);
    [customerButton setImage:[UIImage imageNamed:@"more_aboutwe"] forState:UIControlStateNormal];
    [customerButton setTitle:@"人工客服"
                    forState:UIControlStateNormal];
    [customerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [customerButton addTarget:self action:@selector(handleConsultCustomerAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)setInformationValue {
    AVFile *file =[self.item objectForKey:@"url_image"];
    [self.informationView.productImage sd_setImageWithURL:[NSURL URLWithString:file.url]];
    self.informationView.productPrice.text = [self.item objectForKey:@"price"];
    self.informationView.productDescribe.text = [self.item objectForKey:@"product_describe"];
}

- (void)handleSelectAddressAction {
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    NSLog(@"=====");
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    addressVC.showDeleteButton = YES;
    addressVC.selectAddressBlock = ^(AVObject * _Nonnull item) {
        self.tempItem = item;
        self.informationView.addressLabel.text = [item objectForKey:@"addr"];
    };
    [self.navigationController pushViewController:addressVC animated:YES];
    
}

- (void)handleShareAction {
    AVFile *file =[self.item objectForKey:@"url_image"];
    NSArray *images = @[file.url];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}

- (void)handleConsultCustomerAction {
    [HUDManager showTextHud:@"请先安装QQ应用"];
    NSMutableString *str =[[NSMutableString alloc]initWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"1005608514"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (void)handlePayForOrderAction {
    NSString *userName = [kUserDefaults objectForKey:@"username"];
    if (userName.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if (self.tempItem == nil) {
        [HUDManager showTextHud:@"请选择收件人地址"];
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"目前只支持线下支付,确认提交订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *centain = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        NSString *biaoName = [NSString stringWithFormat:@"Order_%@",AVUser.currentUser.objectId];
        AVObject *todoFolder = [[AVObject alloc] initWithClassName:biaoName];
        
        [todoFolder setObject:[self.tempItem objectForKey:@"name"] forKey:@"name"];
        [todoFolder setObject:[self.tempItem objectForKey:@"phone"] forKey:@"phone"];
        [todoFolder setObject:[self.tempItem objectForKey:@"addr"] forKey:@"addr"];
        [todoFolder setObject:[self.tempItem objectForKey:@"addreDetails"] forKey:@"addreDetails"];
        
        [todoFolder setObject:[self.item objectForKey:@"title"] forKey:@"productName"];
        AVFile *file = [self.item objectForKey:@"url_image"];
        [todoFolder setObject:file.url forKey:@"url"];
        
        
        NSInteger inter =[self.chooseCountView getCurrentCount];
        CGFloat flo = [[self.item objectForKey:@"price"] floatValue];
        
        [todoFolder setObject:[NSString stringWithFormat:@"%ld",inter] forKey:@"productNum"];
        
        [todoFolder setObject:[NSString stringWithFormat:@"%.2f",inter*flo] forKey:@"productPrice"];
        [todoFolder setObject:[self.item objectForKey:@"price"] forKey:@"price"];
        
        NSString *orderNo = [NSString stringWithFormat:@"%@",self.item.objectId];
        [todoFolder setObject:orderNo forKey:@"orderNo"];
        [todoFolder setObject:@"1" forKey:@"status"];//1 2 3 4 0
        [todoFolder setObject:[self.item objectForKey:@"product_describe"] forKey:@"product_describe"];
        
        [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功,可在我的订单界面查看" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *centain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:centain];
                [self presentViewController:alert animated:YES completion:nil];
                
            }else{
                NSLog(@"error === %@",error);
            }
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alert addAction:centain];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
@end
