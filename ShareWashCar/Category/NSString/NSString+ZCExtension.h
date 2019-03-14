//
//  NSString+ZCExtension.h
//  ZCLib_IOS
//
//  Created by ZhiCheng on 16/9/19.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (ZCExtension)

    
    
#pragma mark 计算字符串Frame
/**
 *  类方法计算size大小
 *
 *  @param str  需要计算的字符串
 *  @param font 字体
 *  @param size 大小的范围
 *
 *  @return 大小
 */
- (CGSize)sizeWithStringFont:(UIFont *)font
                  andMaxSize:(CGSize)size;
/**
 *  对象方法计算size大小
 *
 *  @param font 字体
 *  @param size 大小的范围
 *
 *  @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)size;
    

//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
@end
