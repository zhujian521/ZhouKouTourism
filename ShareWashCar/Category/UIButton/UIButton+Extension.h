//
//  UIButton+Extension.h
//  ZCParking
//
//  Created by ChenJun on 16/3/24.
//  Copyright © 2016年 zhichan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  文字和图片位置对换
 */
- (void)titleAndImageSwapPosition;
- (void)verticalImageAndTitle:(CGFloat)spacing;
- (void)subMitBtn;
- (void)normalState;
- (void)disableState;
- (void)CannotClick;

@end
