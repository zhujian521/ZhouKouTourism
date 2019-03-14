//
//  UIButton+VerifyCode.h
//  ZCLib_IOS
//
//  Created by ZhiCheng on 2016/10/17.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (VerifyCode)

- (void)disableSendCaptchaButton;

- (void)normalButton;

@property(nonatomic, assign) NSInteger secondCount;

@end
