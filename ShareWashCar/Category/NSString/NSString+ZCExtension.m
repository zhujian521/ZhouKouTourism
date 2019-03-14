//
//  NSString+ZCExtension.m
//  ZCLib_IOS
//
//  Created by ZhiCheng on 16/9/19.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import "NSString+ZCExtension.h"

@implementation NSString (ZCExtension)

/**
 *  类方法计算size大小
 *
 *  @param str  需要计算的字符串
 *  @param font 字体
 *  @param size 大小的范围
 *
 *  @return 大小
 */
- (CGSize)sizeWithStringFont:(UIFont *)font andMaxSize:(CGSize)size {
    if (self.length== 0) {
        return CGSizeMake(0, 0);
    }
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
    
/**
 *  对象方法计算size大小
 *
 *  @param font 字体
 *  @param size 大小的范围
 *
 *  @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)size;
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
    
@end
