//
//  MBProgressHUD+NJ.h
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 ChenJun. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Category)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success afterDelay:(NSTimeInterval)delay;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
         afterDelay:(NSTimeInterval)delay;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error afterDelay:(NSTimeInterval)delay;
+ (void)showError:(NSString *)error
           toView:(UIView *)view
       afterDelay:(NSTimeInterval)delay;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view afterDelay:(NSTimeInterval)delay;

+ (void)showInfo:(NSString *)info;
+ (void)showInfo:(NSString *)info toView:(UIView *)view;
+ (void)showInfo:(NSString *)info afterDelay:(NSTimeInterval)delay;
+ (void)showInfo:(NSString *)info toView:(UIView *)view
      afterDelay:(NSTimeInterval)delay;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
