//
//  AddViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/7.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "AddViewController.h"
#import "JWAddressPickerView.h"

@interface AddViewController ()
- (IBAction)tapSelectAddressAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"增加收获地址";
}


- (IBAction)tapSelectAddressAction:(id)sender {
    [self.view endEditing:YES];
    [JWAddressPickerView showWithAddressBlock:^(NSString *province, NSString *city, NSString *area) {
        NSString *title = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];
        self.addressLabel.text = title;
        self.addressLabel.textColor = [UIColor blackColor];
    }];
    
}
- (IBAction)saveAction:(id)sender {
    if (self.inputName.text.length == 0) {
        [HUDManager showTextHud:@"请输入收货人姓名"];
        return;
    }
    if (self.phoneField.text.length == 0) {
        [HUDManager showTextHud:@"请输入收货人姓名"];
        return;
    }
    NSString *biaoName = [NSString stringWithFormat:@"Address_%@",AVUser.currentUser.objectId];
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:biaoName];
    [todoFolder setObject:self.inputName.text forKey:@"name"];
    [todoFolder setObject:self.phoneField.text forKey:@"phone"];
    [todoFolder setObject:self.addressLabel.text forKey:@"addr"];
    [todoFolder setObject:self.addressTextField.text forKey:@"addreDetails"];
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [HUDManager showTextHud:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [HUDManager showTextHud:@"保存失败"];
            
        }
    }];
}
@end
