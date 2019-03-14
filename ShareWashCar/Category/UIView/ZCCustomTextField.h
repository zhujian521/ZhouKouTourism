//
//  CustomTextField.h
//  TextField
//
//  Created by ZhiCheng on 2016/10/14.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCCustomTextField : UIView

@property(nonatomic, assign) NSInteger textFieldCount;

-(void)becomeFirstRegister;

-(void)cleanNum;

-(void)setText:(NSString *)text;

-(NSString *)getText;

@property(nonatomic, copy) void(^textFieldDidInputEnd)(NSString *text);

@property(nonatomic, copy) void(^textFieldTextWillChange)(NSString *text);

@end



@class ZCDeleteTextField;
@protocol ZCDeleteTextFieldDelegate <NSObject>
- (void)textFieldDeleteBackward:(ZCDeleteTextField *)textField;
@end

@interface ZCDeleteTextField : UITextField
@property (nonatomic, assign) id <ZCDeleteTextFieldDelegate> delete_delegate;
@end
