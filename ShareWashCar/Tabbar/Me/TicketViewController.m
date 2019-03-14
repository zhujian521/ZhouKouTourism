//
//  TicketViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/8.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "TicketViewController.h"

@interface TicketViewController ()

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatImageView];
}

- (void)creatImageView {
    UIImageView *placeImageView = [[UIImageView alloc]init];
    [self.view addSubview:placeImageView];
    placeImageView.image = [UIImage imageNamed:@"noCycling_securities"];
    placeImageView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view).widthIs(100).heightIs(100);
}



@end
