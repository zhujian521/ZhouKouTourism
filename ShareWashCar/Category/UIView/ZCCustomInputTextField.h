//
//  CustomInputTextField.h
//  ZCParking
//
//  Created by ZhiCheng on 16/8/25.
//  Copyright © 2016年 zhichan. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSString *kPasswordImageName = @"ic_password-15";
static const NSString *kPasswordEyeImageName_Nor = @"ic_view_15";
static const NSString *kPasswordEyeImageName_Press = @"ic_view2_15";
static const NSString *kMailImageName = @"ic_mail-15";
static const NSString *kPhoneImageName = @"ic_phone-16";
#define kFont14 [UIFont systemFontOfSize:14.0]

typedef enum {
    UITextFieldInputStylePassword,   //密码
    UITextFieldInputStyleAccount,    //账户
    UITextFieldInputStyleCode,       //带验证码输入框
    UITextFieldInputStyleCarAuthCode,//带验证码车辆验证
    UITextFieldInputStyleVerifycode, //输入验证码
    UITextFieldInputStyleScan,       //二维码、条形码扫描
    UITextFieldInputStyleCustom      //自定义
} UITextFieldInputStyle;

typedef enum {
    UITextFieldLayerStyleRect,  //矩形
    UITextFieldInputStyleRadus, //圆角
} UITextFieldLayerStyle;

@interface ZCCustomInputTextField : UITextField

@property (nonatomic, assign) UITextFieldInputStyle inputType;

@property (nonatomic, assign) UITextFieldLayerStyle layerStyle;

- (void)addLeftViewWithImageName:(NSString *)imageName;

#pragma mark 发送验证码
@property (nonatomic, copy) void (^sendCodeClick)();

- (void)disableSendCaptchaButton;

- (void)normalButton;

@end
