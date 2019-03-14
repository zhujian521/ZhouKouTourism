//
//  LoginViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "LoginViewController.h"
#import "ZCCustomInputTextField.h"
#import "RegisterViewController.h"
#import "BaseNavigationViewController.h"
#import "ZCRootVCTool.h"
#import "MyColor.h"
@interface LoginViewController ()
@property (nonatomic, strong)UIButton *loginButton1;
@property (nonatomic ,strong)ZCCustomInputTextField *passwordText;
@property (nonatomic, strong)ZCCustomInputTextField *AcountText;
@property(nonatomic,strong)MBProgressHUD *HUD;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"周口旅游指南";
//     [self.navigationController.navigationBar setBarTintColor:RGBCOLOR(17, 27, 29)];
    UIImageView *bgimage = [[UIImageView alloc]init];
    bgimage.userInteractionEnabled = YES;
    [self.view addSubview:bgimage];
    bgimage.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    bgimage.image = [UIImage imageNamed:@"WechatIMG27"];
    
    ZCCustomInputTextField *userName = [[ZCCustomInputTextField alloc]init];
    userName.backgroundColor = [UIColor whiteColor];
    self.AcountText = userName;
    [self.view addSubview:userName];
    userName.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).topSpaceToView(self.view,200).heightIs(40);
    userName.font = kFont15WithHelveticaNeu;
    userName.placeholder = @"请输入用户名";
    userName.inputType = UITextFieldInputStyleCustom;
    [userName addTarget:self action:@selector(AcounttextFieldChange) forControlEvents:UIControlEventEditingChanged];
    
    self.passwordText = [[ZCCustomInputTextField alloc]init];
    [self.view addSubview:self.passwordText];
    self.passwordText.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).topSpaceToView(userName,30).heightIs(40);
    self.passwordText.font = kFont15WithHelveticaNeu;
    _passwordText.placeholder = @"请输入密码";
    _passwordText.inputType = UITextFieldInputStyleCustom;
    [_passwordText addTarget:self action:@selector(AcounttextFieldChange) forControlEvents:UIControlEventEditingChanged];
    [self setupLoginbutton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar setBarTintColor:[MyColor navigationBarColor]];
}

- (void)setupLoginbutton {
    self.loginButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginButton1];
    self.loginButton1.sd_layout.topSpaceToView(self.passwordText,50).leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).heightIs(40);
    [self.loginButton1 setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton1.titleLabel.font =kFont15WithHelveticaNeu;
    [self.loginButton1 addTarget:self action:@selector(loginForAcount:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton1 subMitBtn];
    self.loginButton1.enabled = YES;
    
    UIButton *registerButton = [[UIButton alloc]init];
    [self.view addSubview:registerButton];
    registerButton.sd_layout.topSpaceToView(self.loginButton1, 10).centerXEqualToView(self.view).widthIs(120).heightIs(44);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font =kFont15WithHelveticaNeu;
    [registerButton addTarget:self action:@selector(handleGoRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loginForAcount:(UIButton *)sender {
    if (self.AcountText.text.length == 0) {
        [HUDManager showTextHud:@"请输入用户名"];
        return;
    }
    if (self.passwordText.text.length == 0) {
        [HUDManager showTextHud:@"请输入密码"];
        return;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    _HUD.mode = MBProgressHUDModeText;
    [_HUD showAnimated:YES];
    [AVUser logInWithUsernameInBackground:self.AcountText.text password:self.passwordText.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [kUserDefaults setObject:self.AcountText.text forKey:@"username"];
            [kUserDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
           
        } else {
            [self.HUD hideAnimated:YES];
            
            [self loginError];
        }
    }];
}

- (void)loginError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败，请检查网络后重试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:centain];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)handleGoRegisterAction {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    BaseNavigationViewController *navigation = [[BaseNavigationViewController alloc]initWithRootViewController:registerVC];
    [self presentViewController:navigation animated:YES completion:nil];
    
}

- (void)AcounttextFieldChange {
    if (self.AcountText.text.length != 0 && self.passwordText.text.length != 0 ) {
        _loginButton1.enabled = YES;
    } else {
        _loginButton1.enabled = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
