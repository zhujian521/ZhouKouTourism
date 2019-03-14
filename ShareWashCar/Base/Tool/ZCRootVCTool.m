//
//  ZCRootVCTool.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "ZCRootVCTool.h"
#import "BaseNavigationViewController.h"
#import "BaseTabBarVC.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"
#import "LoginViewController.h"
@implementation ZCRootVCTool

+ (void)chooseRootViewController {
    NSString *userId = [kUserDefaults objectForKey:@"username"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (userId.length == 0) {
//        BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
//        [UIView transitionWithView:window duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            BOOL oldState = [UIView areAnimationsEnabled];
//            [UIView setAnimationsEnabled:NO];
//            window.rootViewController = navi;
//            [UIView setAnimationsEnabled:oldState];
//        } completion:^(BOOL finished) {
//
//        }];
//
//
//    } else {
        [UIView transitionWithView:window duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
                        window.rootViewController = [[BaseTabBarVC alloc]init];
            window.rootViewController = [[BaseTabBarVC alloc] init];
            [UIView setAnimationsEnabled:oldState];
        } completion:^(BOOL finished) {
            
        }];
        
        
//    }
    
}
+ (void)gotoLogin {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    BaseNavigationViewController *navi = [[BaseNavigationViewController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
    [UIView transitionWithView:window duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = navi;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        
    }];
    
}
+ (void)animationWithLunachImage {
    
}
+ (void)changeWindow {
    // 切换控制器 的动画
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView transitionWithView:window duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = [[BaseTabBarVC alloc]init];
//        window.rootViewController = [[BaseNavigationVC alloc]initWithRootViewController:[[MainHomeVC alloc] init]];
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)gotoTabbarControer {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView transitionWithView:window duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = [[BaseTabBarVC alloc]init];
        window.rootViewController = [[BaseTabBarVC alloc] init];
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        
    }];
    
}


@end
