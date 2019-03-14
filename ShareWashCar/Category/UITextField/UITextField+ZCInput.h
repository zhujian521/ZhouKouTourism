//
//  UITextField+ZCInput.h
//  ZCLib_IOS
//
//  Created by ZhiCheng on 2016/10/17.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^InputTextFieldCallback)(UIButton *button);
typedef void (^TextChangeCallback)(UITextField *textField);
typedef void (^ButtonStyle)(UIButton *button);

@interface UITextField (ZCInput)

@property(nonatomic, weak) UIButton *rightButton;
@property(nonatomic, weak) UIButton *leftButton;

-(void)addLeftViewWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName frameWidth:(CGFloat )frameWidth clickCallback:(InputTextFieldCallback)clickCallback;

-(void)addRightViewWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName frameWidth:(CGFloat )frameWidth clickCallback:(InputTextFieldCallback)clickCallback;

-(void)addRightViewSize:(CGSize)size button:(ButtonStyle)button clickCallback:(InputTextFieldCallback)clickCallback textChange:(TextChangeCallback)textChange;

@end
