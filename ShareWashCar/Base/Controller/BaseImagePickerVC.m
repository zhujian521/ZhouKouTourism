//
//  BaseImagePickerVC.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/8.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "BaseImagePickerVC.h"
#import "MyColor.h"
@interface BaseImagePickerVC ()

@end

@implementation BaseImagePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[MyColor navigationBarColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [self.navigationBar setTitleTextAttributes:attrs];
    self.allowsEditing = YES;
}



@end
