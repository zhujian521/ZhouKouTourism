//
//  NSString+ZCDate.h
//  ZCLib_IOS
//
//  Created by ZhiCheng on 16/9/19.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZCDate)

/**
 将时间戳转换成字符

 @param self   时间戳
 @param format 所需要的输出格式

 @return 转换后的字符串
*/
- (NSString *)getDataNSStringFormat:(NSString *)format;

+ (NSString *)getTimeWithTimeStamp:(NSString *)timeStampStr;
//获取当前时间
+ (NSString *)getCurrentTime;
//计算两个时间的差距多少秒
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 将时间格式修改成另外的格式 如：2000/01/01 -> 2000-01-01

 @param inputFormat  现在的格式
 @param outputFormat 需要修改显示的格式

 @return 格式转换后的字符串
 */
- (NSString *)getDataWithInputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;


/**
 和当前时间比较

 @param str 时间比较

 @return 返回几秒前，几分前，几小时前...
 */
- (NSString *)compareCurrentTime;


/**
 @return  返回星期几
 */
- (NSString *)weekdayStringFromDate;

/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;


@end
