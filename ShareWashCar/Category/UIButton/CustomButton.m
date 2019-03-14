//
//  CustomButton.m
//  BikeManager
//
//  Created by zhujian on 17/12/1.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 30);
    self.imageView.center = CGPointMake(midX, midY - 10);
    self.titleLabel.font = kFont15WithHelveticaNeu;
}

@end
