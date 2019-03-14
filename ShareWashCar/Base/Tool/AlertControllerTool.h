//
//  AlertControllerTool.h
//  ShareBike
//
//  Created by zhujian on 17/11/17.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
typedef void (^TapAction)(id json);
@interface AlertControllerTool : NSObject
+ (void)alertController:(UIViewController *)VC AndAlertTitle:(NSString *)title AndMessage:(NSString *)message AndActionTitle:(NSString *)actionTitle AndActionBolck:(TapAction )Action;

+ (void)alertController:(BaseViewController *)VC AndAlertTitle:(NSString *)title AndMessage:(NSString *)message AndActionTitle1:(NSString *)actionTitle1 AndActionBolck1:(TapAction )Action1 AndActionTitle2:(NSString *)actionTitle2 AndActionBlock2:(TapAction )Action2;
@end
