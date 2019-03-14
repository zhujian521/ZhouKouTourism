//
//  MyColor.m
//  ZCParking
//
//  Created by ChenJun on 16/3/21.
//  Copyright © 2016年 zhichan. All rights reserved.
//

#import "MyColor.h"

@implementation MyColor
/**
 *  确认按钮按钮蓝色
 *
 */
+ (UIColor *)buttonConfirmColor {
    //    return [UIColor colorWithRed:39.0 / 255.0
    //                           green:142.0 / 255.0
    //                            blue:246.0 / 255.0
    //                           alpha:1];
    return [UIColor colorWithRed:0.00 green:0.48 blue:1.00 alpha:1.00];
}

+ (UIColor *)buttonDisabledConfirmColor {
    return [UIColor colorWithRed:135.0 / 255.0
                           green:186.0 / 255.0
                            blue:255.0 / 255.0
                           alpha:1];
}

/**
 *  导航栏颜色
 *
 */
+ (UIColor *)navigationBarColor {
        return [UIColor colorWithRed:255.0 / 255.0
                               green:64.0 / 255.0
                                blue:129.0 / 255.0
                               alpha:1];
}



+ (UIColor *)tipBackgroundColor {
    return [UIColor colorWithRed:255.0 / 255.0
                           green:242.0 / 255.0
                            blue:214.0 / 255.0
                           alpha:1];
}
+ (UIColor *)tipFontColor {
    return [UIColor colorWithRed:246.0 / 255.0
                           green:143.0 / 255.0
                            blue:18.0 / 255.0
                           alpha:1];
}

/**
 *  标题颜色
 *
 *  @return <#return value description#>
 */
+ (UIColor *)titleColor {
    return [MyColor color130];
}

/**
 *  值的颜色
 *
 *  @return <#return value description#>
 */
+ (UIColor *)valueColor {
    return [MyColor color52];
}

+ (UIColor *)color157 {
    return [UIColor colorWithRed:157.0 / 255.0
                           green:157.0 / 255.0
                            blue:157.0 / 255.0
                           alpha:1];
}

+ (UIColor *)color189 {
    return [UIColor colorWithRed:189.0 / 255.0
                           green:189.0 / 255.0
                            blue:189.0 / 255.0
                           alpha:1];
}

+ (UIColor *)color130 {
    return [UIColor colorWithRed:130.0 / 255.0
                           green:130.0 / 255.0
                            blue:130.0 / 255.0
                           alpha:1];
}

+ (UIColor *)color103 {
    return [UIColor colorWithRed:103.0 / 255.0
                           green:103.0 / 255.0
                            blue:103.0 / 255.0
                           alpha:1];
}

+ (UIColor *)color52 {
    return [UIColor colorWithRed:52.0 / 255.0
                           green:52.0 / 255.0
                            blue:52.0 / 255.0
                           alpha:1];
}

+ (UIColor *)orgColor {
    return [UIColor colorWithRed:246.0 / 255.0
                           green:143.0 / 255.0
                            blue:18.0 / 255.0
                           alpha:1];
}
+ (UIColor *)color243 {
    return [UIColor colorWithRed:243.0 / 255.0
                           green:243.0 / 255.0
                            blue:243.0 / 255.0
                           alpha:1];
}
+ (UIColor *)colorwith:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red / 255.0
                           green:green / 255.0
                            blue:blue / 255.0
                           alpha:1];
}
@end
