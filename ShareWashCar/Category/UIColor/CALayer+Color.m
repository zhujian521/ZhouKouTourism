//
//  CALayer+Color.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/7.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "CALayer+Color.h"

@implementation CALayer (Color)

-(void)setBorderUIColor:(UIColor*)color {
    self.borderColor= color.CGColor;
}

-(UIColor*)borderUIColor {
    return[UIColor colorWithCGColor:self.borderColor];
}

@end
