//
//  RegisterViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZCCustomInputTextField.h"
@interface RegisterViewController ()
@property (nonatomic ,strong)ZCCustomInputTextField *passwordText;
@property (nonatomic, strong)ZCCustomInputTextField *acountText;
@property (nonatomic, strong)ZCCustomInputTextField *emailText;
@property (nonatomic, strong)UIButton *registerButton;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBarTintColor:RGBCOLOR(17, 27, 29)];
    
    self.title = @"注册";
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    itemSpace.width = -10;
    
    self.navigationItem.leftBarButtonItems =@[itemSpace,[UIBarButtonItem itemWithTarget:self action:@selector(handleDismissAction) image:@"btn_back_white" highImage:@""]];
    
    ZCCustomInputTextField *userName = [[ZCCustomInputTextField alloc]init];
    userName.backgroundColor = [UIColor whiteColor];
    self.acountText = userName;
    [self.view addSubview:userName];
    userName.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).topSpaceToView(self.view,100).heightIs(40);
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
    
    self.emailText = [[ZCCustomInputTextField alloc]init];
    [self.view addSubview:self.emailText];
    self.emailText.sd_layout.leftSpaceToView(self.view,20).rightSpaceToView(self.view, 20).topSpaceToView(self.passwordText, 30).heightIs(40);
    self.emailText.inputType = UITextFieldInputStyleCustom;
    self.emailText.placeholder = @"请输入邮箱";
    
    [self setupLoginbutton];
}

- (void)setupLoginbutton {
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.registerButton];
    self.registerButton.sd_layout.topSpaceToView(self.emailText,50).leftSpaceToView(self.view,20).rightSpaceToView(self.view,20).heightIs(40);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    self.registerButton.titleLabel.font =kFont15WithHelveticaNeu;
    [self.registerButton addTarget:self action:@selector(registerAccountAction) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton subMitBtn];
    self.registerButton.enabled = true;
    
    
}

- (void)registerAccountAction {
    if (self.acountText.text.length == 0) {
        [HUDManager showTextHud:@"请输入用户名"];
        return;
    } else if (self.passwordText.text.length == 0) {
        [HUDManager showTextHud:@"请输入密码"];
        return;
    } else if(self.emailText.text.length == 0) {
        [HUDManager showTextHud:@"请输入邮箱"];
        return;
    }
    AVUser *user = [AVUser user];
    user.username = self.acountText.text;
    user.password = self.passwordText.text;
    user.email = self.emailText.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //NSLog(@"注册成功");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:centain];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            //NSLog(@"失败的原因可能有多种，常见的是用户名已经存在。===%@",error);
        }
    }];
    
}


- (void)handleDismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)AcounttextFieldChange {
    
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
