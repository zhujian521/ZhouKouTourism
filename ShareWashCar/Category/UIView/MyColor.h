//
//  MyColor.h
//  ZCParking
//
//  Created by ChenJun on 16/3/21.
//  Copyright © 2016年 zhichan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyColor : UIViewController

/**
 *  确认按钮按钮蓝
 *
 */
+ (UIColor *)buttonConfirmColor;

+ (UIColor *)buttonDisabledConfirmColor;
/**
 *  橘色
 *
 *  @return <#return value description#>
 */
+ (UIColor *)orgColor;

/**
 *  导航栏颜色
 *
 */
+ (UIColor *)navigationBarColor;

/**
 *  提示背景色
 *
 *  @return color
 */
+ (UIColor *)tipBackgroundColor;

/**
 *  提示字体色
 *
 *  @return color
 */
+ (UIColor *)tipFontColor;

/**
 *  标题颜色
 *
 *  @return color
 */
+ (UIColor *)titleColor;

/**
 *  值颜色
 *
 *  @return color
 */
+ (UIColor *)valueColor;

/**
 *  字体颜色52
 *
 */
+ (UIColor *)color52;

+ (UIColor *)color189;
/**
 *  字体颜色103
 *
 */
+ (UIColor *)color103;

/**
 *  字体颜色130
 *
 */
+ (UIColor *)color130;

/**
 *  字体颜色157
 *
 */
+ (UIColor *)color157;

+ (UIColor *)color243;
+ (UIColor *)colorwith:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
@end
