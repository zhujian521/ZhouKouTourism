//
//  UIButton+Extension.m
//  ZCParking
//
//  Created by ChenJun on 16/3/24.
//  Copyright © 2016年 zhichan. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIImage+Color.h"
#import "NSString+ZCExtension.h"

#define kZCNormalBtnColor [UIColor redColor]
#define kZCDisabledBtnColor [UIColor colorWithRed:200 / 255.0 green:50 / 255.0 blue:20 / 255.0 alpha:1]

@implementation UIButton (Extension)

/**
 *  文字和图片位置对换
 */
- (void)titleAndImageSwapPosition {
    UIImage *image = [self currentImage];
    CGFloat w = self.titleLabel.bounds.size.width;
    if (w == 0) {
        CGSize size = [self.titleLabel.text sizeWithStringFont:self.titleLabel.font andMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        w = size.width;
    }

    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0,
                                              image.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, w, 0, -w)];
}

- (void)subMitBtn {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0;
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self setBackgroundImage:[UIImage imageFromContextWithColor:kZCNormalBtnColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromContextWithColor:kZCDisabledBtnColor] forState:UIControlStateDisabled];
    self.enabled = NO;
}
- (void)CannotClick {
    [self setBackgroundImage:[UIImage imageFromContextWithColor:kZCNormalBtnColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageFromContextWithColor:kZCDisabledBtnColor] forState:UIControlStateDisabled];
    self.enabled = NO;
}
-(void)normalState{
    self.enabled = YES;
}

-(void)disableState{
    self.enabled = NO;
}
- (void)verticalImageAndTitle:(CGFloat)spacing
{
    self.titleLabel.backgroundColor = [UIColor greenColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}


@end
