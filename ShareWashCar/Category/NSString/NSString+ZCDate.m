//
//  NSString+ZCDate.m
//  ZCLib_IOS
//
//  Created by ZhiCheng on 16/9/19.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import "NSString+ZCDate.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZCDate)
    
- (NSString *)getDataNSStringFormat:(NSString *)format{
    
    NSString *input = self;
    if (input.length == 13) {
        input = [input substringToIndex:10];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[input longLongValue]];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:format];
    return [formatter2 stringFromDate:date];
}
    
-(NSString *)getDataWithInputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:inputFormat];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:self]; //------------将字符串按formatter转
    [formatter setDateFormat:outputFormat];
    return [formatter stringFromDate:date];
}
+ (NSString *)getTimeWithTimeStamp:(NSString *)timeStampStr {
    NSTimeInterval interval = [timeStampStr doubleValue] / 1000.0;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:interval];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    return nowtimeStr;
}
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    //    int second = (int)value %60;//秒
    //    int minute = (int)value /60%60;
    //    int house = (int)value / (24 * 3600)%3600;
    //    int day = (int)value / (24 * 3600);
    NSString *str = [NSString stringWithFormat:@"%.0lf",value];;
    //    if (day != 0) {
    //        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
    //    }else if (day==0 && house != 0) {
    //        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
    //    }else if (day== 0 && house== 0 && minute!=0) {
    //        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
    //    }else{
    //        str = [NSString stringWithFormat:@"耗时%d秒",second];
    //    }
    return str;
    
}

- (NSString *)compareCurrentTime{
    
    NSString *str = self;
    if (str.length == 13) {
        str = [str substringToIndex:10];
    }

    NSDate *compareDate = [NSDate dateWithTimeIntervalSince1970:[str longLongValue]];
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
    
    
- (NSString*)weekdayStringFromDate{
    
    NSString *input = self;
    if (input.length == 13) {
        input = [input substringToIndex:10];
    }
    
    NSDate *inputDate = [NSDate dateWithTimeIntervalSince1970:[input longLongValue]];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


    
@end
