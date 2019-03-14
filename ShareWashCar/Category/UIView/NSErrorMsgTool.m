//
//  NSErrorMsgTool.m
//  BikeManager
//
//  Created by zhujian on 17/11/14.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import "NSErrorMsgTool.h"

@implementation NSErrorMsgTool
+ (NSString *)convertNSErrorCodeToName:(NSInteger)statusCode{
    NSString *msg = @"与服务器连接失败，请稍后重试！";
    
    switch (statusCode) {
        case NSURLErrorTimedOut:
            msg = @"与服务器连接超时，请检查网络！";
            break;
        case NSURLErrorNotConnectedToInternet:
            msg = @"似乎已断开与互联网的连接，请检查网络！";
            break;
        default:
            break;
    }
    return msg;
}


@end
