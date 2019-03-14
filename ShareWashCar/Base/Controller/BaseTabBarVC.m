//
//  BaseTabBarVC.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"
#import "BaseNavigationViewController.h"
#import "MyColor.h"
@interface BaseTabBarVC ()

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addChildVC:[HomeViewController new] title:@"首页" titleNormalColor:[UIColor lightGrayColor] titleSelectColor:[MyColor navigationBarColor] normalImage:@"zhoukou_normal_home" selectImage:@"zhoukou_select_home"];
     [self addChildVC:[MessageViewController new] title:@"特产" titleNormalColor:[UIColor lightGrayColor] titleSelectColor:[MyColor navigationBarColor] normalImage:@"zhoukou_normal_shop" selectImage:@"zhoukou_select_shop"];
    [self addChildVC:[MeViewController new] title:@"我的" titleNormalColor:[UIColor lightGrayColor] titleSelectColor:[MyColor navigationBarColor] normalImage:@"zhoukou_normal_my" selectImage:@"zhoukou_select_my"];

}

- (void)addChildViewControllerWithClassName:(NSString *)className
                                  imageName:(NSString *)imgName
                                      title:(NSString *)title
{
    UIViewController *controller = [[NSClassFromString(className) alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:controller];
    nav.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imgName];
    //取消选中变色,使用原图
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imgName stringByAppendingString:@"_s"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}
- (void)addChildVC:(BaseViewController *)childVC title:(NSString *)title titleNormalColor:(UIColor *)normalColor titleSelectColor:(UIColor *)selectColor normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage {
    BaseNavigationViewController *navigationVC = [[BaseNavigationViewController alloc]initWithRootViewController:childVC];
    navigationVC.tabBarItem.title = title;
    
    navigationVC.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navigationVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = normalColor;
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = selectColor;
    [navigationVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [navigationVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    [self addChildViewController:navigationVC];
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
