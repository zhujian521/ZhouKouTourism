//
//  CustomInputTextField.m
//  ZCParking
//
//  Created by ZhiCheng on 16/8/25.
//  Copyright © 2016年 zhichan. All rights reserved.
//

#import "ZCCustomInputTextField.h"
#import "UIButton+Extension.h"
#import "UIView+ZCFrame.h"

// 短信提醒间隔秒数
#define kCaptchaSecondLimit 60

@interface ZCCustomInputTextField () {
    //短信验证码计时器
    NSTimer *_captchaTimer;
    //计时
    NSInteger _secondCount;
    //验证码
    NSString *_captchaCode;
}
    
@property (nonatomic, weak) UIButton *verifyCodeBtn;
    
@end

@implementation ZCCustomInputTextField
    
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEnd];
        self.borderStyle = UITextBorderStyleRoundedRect;
//        self.layer.cornerRadius=3.0f;
//        self.layer.masksToBounds=YES;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEnd];
//        self.borderStyle = UITextBorderStyleRoundedRect;
//        self.layer.cornerRadius=3.0f;
//        self.layer.masksToBounds=YES;
    }
    return self;
}


-(void)beginEdit{
    self.layer.borderColor=[[UIColor colorWithRed:39.0 / 255.0
                                            green:142.0 / 255.0
                                             blue:246.0 / 255.0
                                            alpha:1] CGColor];
    self.layer.borderWidth= 1.0f;
}

-(void)endEdit{
    self.layer.borderColor=[[UIColor clearColor]CGColor];
    self.layer.borderWidth= 1.0f;
}

- (void)setTextFieldWithInputStyle:(UITextFieldInputStyle)style layerStyle:(UITextFieldLayerStyle)layerStyle {
    self.layerStyle = layerStyle;
    self.inputType = style;
}

- (void)setInputType:(UITextFieldInputStyle)inputType {
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    _inputType = inputType;
    switch (inputType) {
        case UITextFieldInputStylePassword:
            [self createPassWordTextField];
            break;
        case UITextFieldInputStyleAccount:
            [self createAccountTextField];
            break;
        case UITextFieldInputStyleCode:
            [self createCodeTextField];
            break;
        case UITextFieldInputStyleVerifycode:
            [self createVerifycodeTextField];
            break;
        case UITextFieldInputStyleScan:
            [self createAccountTextField];
            break;
        case UITextFieldInputStyleCustom:
            break;
            
        case UITextFieldInputStyleCarAuthCode:
            [self createCarAuthCodeTextField];
            break;
        default:
            break;
    }
}

#pragma mark密码输入框
- (void)createPassWordTextField {
    self.secureTextEntry = YES;
    //在密码文本框左侧加图片
    [self addLeftViewWithImageName:(NSString *)kPasswordImageName];
    UIButton *button = [self createButton:(NSString *)kPasswordEyeImageName_Nor selectedName:(NSString *)kPasswordEyeImageName_Press title:@"" frameW:40 action:@selector(showPassword:)];
    [self addRightView:button];
}

- (void)createAccountTextField {
    [self addLeftViewWithImageName:(NSString *)kPhoneImageName];
}

- (void)createVerifycodeTextField {
    [self addLeftViewWithImageName:(NSString *)kMailImageName];
}

-(void)createCarAuthCodeTextField{
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 9, 22, 22)];
    [imageView setImage:[UIImage imageNamed:@"icon_vehicle"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [leftView addSubview:imageView];
    [self addLeftView:leftView];
    
    [self addTarget:self action:@selector(textFieldCarNOChange) forControlEvents:UIControlEventEditingChanged];
    UIButton *button = [self createButton:@"" selectedName:@"" title:@"获取验证码" frameW:85 action:@selector(sendCode)];
    button.frameHeight = 30;
    button.frameX = 85;
    [button.titleLabel setFont:kFont14];
    [button subMitBtn];
    
    
    UIButton *button2 = [self createButton:@"icon_down15" selectedName:@"" title:@"选择车辆" frameW:80 action:@selector(sendCode)];
    button2.frameHeight = 30;
    button2.frameX = 0;
    [button2 setTitleColor:[UIColor colorWithRed:53 /255.0 green:53 /255.0 blue:53 /255.0 alpha:1.0] forState:UIControlStateNormal];
    [button2.titleLabel setFont:kFont14];
    [button2 titleAndImageSwapPosition];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 80, 30)];
    [view addSubview:button2];
    [self addRightView:view];
    _verifyCodeBtn = button;
}

-(void)normalButton{
    _verifyCodeBtn.enabled = YES;
}

- (void)createCodeTextField {
    [self addLeftViewWithImageName:(NSString *)kPhoneImageName];
    [self addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];
    UIButton *button = [self createButton:@"" selectedName:@"" title:@"获取验证码" frameW:85 action:@selector(sendCode)];
    button.frameHeight = 30;
    button.frameCenterX = 50;
    [button.titleLabel setFont:kFont14];
    [button subMitBtn];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 100, 30)];
    [view addSubview:button];
    [self addRightView:view];
    _verifyCodeBtn = button;
}

- (void)showPassword:(UIButton *)btn {
    btn.selected = !btn.selected;
    NSString *tempString = self.text;
    self.text = @"";
    self.secureTextEntry = !self.secureTextEntry;
    self.text = tempString;
}

- (void)sendCode {
    if (self.sendCodeClick) {
        self.sendCodeClick();
    }
}

- (void)setLayerStyle:(UITextFieldLayerStyle)layerStyle {
    _layerStyle = layerStyle;
    
    if (_layerStyle == UITextFieldInputStyleRadus) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0;
    } else {
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 0;
    }
}

/**
 *  创建图片
 */
- (UIImageView *)createImageView:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [imageView setContentMode:UIViewContentModeRight];
    return imageView;
}

/**
 *  创建显示和隐藏密码的图标
 *
 *  @param imageName 图标名
 *
 *  @return 显示图标
 */
- (UIButton *)createButton:(NSString *)imageName selectedName:(NSString *)selectedName title:(NSString *)title frameW:(CGFloat)frameW action:(SEL)action {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frameW, 40)];
    
    if (imageName.length != 0) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (selectedName.length != 0) {
        [btn setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    }
    
    if (title.length != 0) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)addLeftView:(UIView *)view {
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)addRightView:(UIView *)view {
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)addLeftViewWithImageName:(NSString *)imageName {
    [self addLeftView:[self createImageView:imageName]];
}

- (void)disableSendCaptchaButton {
    _secondCount = kCaptchaSecondLimit;
    _verifyCodeBtn.enabled = NO;
    _captchaTimer =
    [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changeButtonTitle:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_captchaTimer forMode:NSDefaultRunLoopMode];
    [_captchaTimer fire];
}

- (void)changeButtonTitle:(id)sender {
    _secondCount--;
    if (_secondCount == 0) {
        [_verifyCodeBtn setEnabled:YES];
        [_captchaTimer invalidate];
        [_verifyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_verifyCodeBtn setTitle:@"重新获取" forState:UIControlStateDisabled]; // 微妙的效果
    } else {
        [_verifyCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long) _secondCount]
                        forState:UIControlStateDisabled];
    }
}

- (void)textFieldChange {
    if (self.text.length == 11 && _secondCount == 0) {
        _verifyCodeBtn.enabled = YES;
    } else {
        _verifyCodeBtn.enabled = NO;
    }
}

- (void)textFieldCarNOChange {
//    if ([MyFunctions validateCarNo:self.text] && _secondCount == 0) {
//        _verifyCodeBtn.enabled = YES;
//    } else {
//        _verifyCodeBtn.enabled = NO;
//    }
}

    
@end
