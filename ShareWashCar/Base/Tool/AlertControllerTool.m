//
//  AlertControllerTool.m
//  ShareBike
//
//  Created by zhujian on 17/11/17.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import "AlertControllerTool.h"

@implementation AlertControllerTool
+ (void)alertController:(UIViewController *)VC AndAlertTitle:(NSString *)title AndMessage:(NSString *)message AndActionTitle:(NSString *)actionTitle AndActionBolck:(TapAction )Action {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Action(@"tap");
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [VC presentViewController:alert animated:YES completion:nil];

}
+ (void)alertController:(BaseViewController *)VC AndAlertTitle:(NSString *)title AndMessage:(NSString *)message AndActionTitle1:(NSString *)actionTitle1 AndActionBolck1:(TapAction )Action1 AndActionTitle2:(NSString *)actionTitle2 AndActionBlock2:(TapAction )Action2 {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {}];
    
    UIAlertAction*fromPhotoAction = [UIAlertAction actionWithTitle:actionTitle1 style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        Action1(actionTitle1);
        
        
    }];
    UIAlertAction*fromCameraAction = [UIAlertAction actionWithTitle:actionTitle2 style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            Action2(actionTitle2);
        } else {
            [HUDManager showTextHud:@"相机不可用"];
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:fromCameraAction];
    [alert addAction:fromPhotoAction];
    [VC presentViewController:alert animated:YES completion:nil];

}
@end
