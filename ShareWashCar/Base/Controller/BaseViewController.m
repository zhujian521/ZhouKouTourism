//
//  BaseViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/2/17.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //navigationController是否透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //navigation返回Item颜色//字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    
    //navigation背景色
    //    self.navigationController.navigationBar.barTintColor = RGBColor(14,84,180);
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithRed:0.25 green:0.54 blue:1.00 alpha:1.00]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageFromContextWithColor:[UIColor colorWithRed:0.25 green:0.54 blue:1.00 alpha:1.00]]];
    
    
    //navigationItem颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setUpForDismissKeyboard];

}

- (void)setUpForDismissKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    __weak typeof(self)weakself = self;
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakself.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakself.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
    
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
