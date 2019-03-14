//
//  NSErrorMsgTool.h
//  BikeManager
//
//  Created by zhujian on 17/11/14.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSErrorMsgTool : NSObject
+ (NSString *)convertNSErrorCodeToName:(NSInteger)statusCode;

@end
