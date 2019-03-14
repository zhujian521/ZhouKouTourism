//
//  MessageViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/8.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatImageView];
}

- (void)creatImageView {
    UIImageView *placeImageView = [[UIImageView alloc]init];
    [self.view addSubview:placeImageView];
    placeImageView.image = [UIImage imageNamed:@"noMessage"];
    placeImageView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).widthIs(100).heightIs(100);
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
