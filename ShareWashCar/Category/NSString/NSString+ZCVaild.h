//
//  NSString+ZCVaild.h
//  ZCLib_IOS
//
//  Created by ZhiCheng on 16/9/19.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZCVaild)

#pragma mark 验证
/**
 *  邮箱验证
 */
- (BOOL)validateEmail;

/**
 *  手机号码验证
 */
- (BOOL)validateMobile;

/**
 *  身份证号码验证
 */
//- (BOOL)validateIdentityCard;

/**
 *  车牌号码验证
 */
- (BOOL)validateCarNo;

/**
 *  密码验证
 */
- (BOOL)validatePassword;
    
@end
