//
//  UIButton+VerifyCode.m
//  ZCLib_IOS
//
//  Created by ZhiCheng on 2016/10/17.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import "UIButton+VerifyCode.h"
#import <objc/runtime.h>
@interface UIButton()

@property(nonatomic, copy) NSString  *captchaCode;

@property(nonatomic, strong) NSTimer  *captchaTimer;

@end

#define kCaptchaSecondLimit 60

static void * CaptchaCodePorpertyKey = (void *)@"CaptchaCodePorpertyKey";
static void * CaptchaTimerPorpertyKey = (void *)@"CaptchaTimerPorpertyKey";
static void * SecondCountPorpertyKey = (void *)@"SecondCountPorpertyKey";

@implementation UIButton (VerifyCode)

- (void)disableSendCaptchaButton {
    self.secondCount = kCaptchaSecondLimit;
    self.enabled = NO;
    self.captchaTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changeButtonTitle:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.captchaTimer forMode:NSDefaultRunLoopMode];
    [self.captchaTimer fire];
}

- (void)changeButtonTitle:(id)sender {
    self.secondCount--;
    if (self.secondCount == 0) {
        [self setEnabled:YES];
        [self.captchaTimer invalidate];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitle:@"重新获取" forState:UIControlStateDisabled]; // 微妙的效果
    } else {
        [self setTitle:[NSString stringWithFormat:@"%ld秒", (long) self.secondCount] forState:UIControlStateNormal];
        [self setTitle:[NSString stringWithFormat:@"%ld秒", (long) self.secondCount] forState:UIControlStateDisabled];
        
    }
}

-(void)normalButton{
    self.enabled = YES;
}


-(NSString *)captchaCode{
    return objc_getAssociatedObject(self, CaptchaCodePorpertyKey);
}

-(void)setCaptchaCode:(NSString *)captchaCode{
    objc_setAssociatedObject(self, CaptchaCodePorpertyKey, captchaCode, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimer *)captchaTimer{
    return objc_getAssociatedObject(self, CaptchaTimerPorpertyKey);
}

-(void)setCaptchaTimer:(NSTimer *)captchaTimer{
    objc_setAssociatedObject(self, CaptchaTimerPorpertyKey, captchaTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)secondCount{
    return [objc_getAssociatedObject(self, SecondCountPorpertyKey) integerValue];
}

-(void)setSecondCount:(NSInteger)secondCount{
    objc_setAssociatedObject(self, SecondCountPorpertyKey, [NSNumber numberWithInteger:secondCount], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
