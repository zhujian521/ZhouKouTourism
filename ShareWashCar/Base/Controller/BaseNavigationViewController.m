//
//  BaseNavigationViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "MyColor.h"
#import "UIBarButtonItem+Extension.h"
@interface BaseNavigationViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation BaseNavigationViewController
/**
 *  类只初始化一次（不管该类被创建了多少个对象）
 */
+ (void)initialize {
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleAttr[NSFontAttributeName] = kFont17WithHelveticaNeu;
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName : kFont17WithHelveticaNeu,
       NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationBar setBarTintColor:[MyColor navigationBarColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    //左滑pop代理
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        itemSpace.width = -10;

        viewController.navigationItem.leftBarButtonItems =@[itemSpace,[UIBarButtonItem itemWithTarget:self action:@selector(goBack) image:@"btn_back_white" highImage:@""]];

    }
    [super pushViewController:viewController animated:YES];

}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]) {
        //如果在根控制器下不将interactivePopGestureRecognizer.delegate置回原有delegate
        //再左滑一次，点击跳转回死掉
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    } else {
        //如果是自定义左边的返回按钮必须清空interactivePopGestureRecognizer.delegate才能使用左滑返回
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)goBack {
    [self popViewControllerAnimated:YES];
}



@end
