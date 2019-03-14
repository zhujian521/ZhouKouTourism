//
//  MBProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 ChenJun. All rights reserved.
//

#import "MBProgressHUD+Category.h"
@implementation MBProgressHUD (Category)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    [hud.label setFont:kFont12WithHelveticaNeu];
    // 设置图片
    hud.customView = [[UIImageView alloc]
        initWithImage:
            [UIImage
                imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@",
                                                      icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:2.5];
}
/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text
        icon:(NSString *)icon
        view:(UIView *)view
  afterDelay:(NSTimeInterval)delay {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    [hud.label setTextAlignment:NSTextAlignmentCenter];
    [hud.label setFont:kFont12WithHelveticaNeu];
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@",
                                                      icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:delay];
}
/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}
/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success afterDelay:(NSTimeInterval)delay {
    [self showSuccess:success toView:nil afterDelay:delay];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view
         afterDelay:(NSTimeInterval)delay {
    [self show:success icon:@"success.png" view:view afterDelay:delay];
}
/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}
/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error afterDelay:(NSTimeInterval)delay {
    [self showError:error toView:nil afterDelay:delay];
}
/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}
/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error
           toView:(UIView *)view
       afterDelay:(NSTimeInterval)delay {
    [self show:error icon:@"error.png" view:view afterDelay:delay];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor clearColor];
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.4f];

    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD {
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows firstObject];
    [self hideHUDForView:view animated:YES];
}

/**
 *  显示信息
 *
 *  @param info 信息内容
 */
+ (void)showInfo:(NSString *)info {
    [self showSuccess:info toView:nil];
}
/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showInfo:(NSString *)success afterDelay:(NSTimeInterval)delay {
    [self showSuccess:success toView:nil afterDelay:delay];
}

/**
 *  显示信息
 *
 *  @param info 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showInfo:(NSString *)info
          toView:(UIView *)view
      afterDelay:(NSTimeInterval)delay {
    [self show:info icon:@"info.png" view:view afterDelay:delay];
}
/**
 *  显示成功信息
 *
 *  @param info 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showInfo:(NSString *)info toView:(UIView *)view {
    [self show:info icon:@"info.png" view:view];
}

@end
