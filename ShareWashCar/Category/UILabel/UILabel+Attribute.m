//
//  UILabel+Attribute.m
//  ShareBike
//
//  Created by zhujian on 17/9/22.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import "UILabel+Attribute.h"

@implementation UILabel (Attribute)
- (void)setText:(NSString *)text andFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment )alignment{
    self.text = text;
    self.font = font;
    self.textColor = textColor;
    self.textAlignment = alignment;
}
@end
