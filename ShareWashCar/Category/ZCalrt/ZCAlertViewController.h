//
//  ZCAlertViewController.h
//  BikeManager
//
//  Created by zhujian on 17/11/14.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCAlertAction;
typedef void (^AlertActionBlock)(ZCAlertAction *action);

@interface ZCAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(ZCAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;

@property(nonatomic, strong) UIColor *color;

@end


@interface ZCAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<ZCAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property(nonatomic, copy) NSString  *imageName;
@property (nonatomic, assign) NSTextAlignment messageAlignment;
@property (nonatomic, assign) NSTextAlignment titleAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message imageName:(NSString *)imageName;
- (void)addAction:(ZCAlertAction *)action;

@end
