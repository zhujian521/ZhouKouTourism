//
//  CustomTextField.m
//  TextField
//
//  Created by ZhiCheng on 2016/10/14.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import "ZCCustomTextField.h"
#import <objc/runtime.h>
#define kCustomPasswordTextFieldH 44

@interface ZCCustomTextField()<UITextFieldDelegate,ZCDeleteTextFieldDelegate>

@property(nonatomic, strong) NSMutableArray  *textFieldList;

@property(nonatomic, assign) BOOL  isComeFromNextAction;

@end

@implementation ZCCustomTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBorder];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupBorder];
    }
    return self;
}

-(void)setupBorder{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 4.0;
}

-(void)setTextFieldCount:(NSInteger)textFieldCount{
    _textFieldCount = textFieldCount;
    for (int i = 0; i< textFieldCount; i++) {
        ZCDeleteTextField *textField = [[ZCDeleteTextField alloc]init];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.textColor = [UIColor colorWithRed:34.0 /255.0 green:34.0 /255.0 blue:34.0 /255.0 alpha:1.0];
        textField.font = [UIFont systemFontOfSize:14.0];
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.delegate = self;
        textField.delete_delegate = self;
        if (i != 0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, kCustomPasswordTextFieldH)];
            [view setBackgroundColor:[UIColor lightGrayColor]];
            textField.leftView = view;
            textField.leftViewMode = UITextFieldViewModeAlways;
        }
        [self addSubview:textField];
    }
    [self setNeedsLayout];
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / self.subviews.count;
    
    NSInteger i=0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            view.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
            i++;
        }
    }
}


- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField.text.length > 1) {
        textField.text = [textField.text substringWithRange:NSMakeRange(1, 1)];
    }
    
    if (textField.text.length > 0) {
        [self goNextTextField];
        
        if (textField == [self.subviews lastObject]) {
            [textField resignFirstResponder];
            if (self.textFieldDidInputEnd) {
                self.textFieldDidInputEnd([self getText]);
            }
        }
        
    }else{
        [self goPrevTextField];
    }
    
    if (self.textFieldTextWillChange) {
        self.textFieldTextWillChange([self getText]);
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!_isComeFromNextAction) {
        [self goPrevTextField];
    }
    _isComeFromNextAction = NO;
}

-(void)textFieldDeleteBackward:(ZCDeleteTextField *)textField{
    [self goPrevTextField];
}

-(void)goNextTextField{
    for (UITextField *textField in self.subviews) {
        if (textField.text.length == 0) {
            _isComeFromNextAction = YES;
            [textField becomeFirstResponder];
            break;
        }
    }
}

-(void)textFieldTouch:(UITextField *)textField{
    [textField resignFirstResponder];
    [self goPrevTextField];
}

-(void)goPrevTextField{
    UITextField *responTextField = [self.subviews firstObject];
    for (UITextField *textField in self.subviews) {
        if (textField.text.length == 0) {
            break;
        }
        responTextField = textField;
    }
    [responTextField becomeFirstResponder];
}

-(NSString *)getText{
    NSString *text = @"";
    for (UITextField *textField  in self.subviews) {
        text = [text stringByAppendingString:textField.text];
    }
    return text;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)cleanNum{
    for (UITextField *textField  in self.subviews) {
        textField.text = @"";
    }
    [self becomeFirstRegister];
}

-(void)becomeFirstRegister{
    UITextField *textField = [self.subviews firstObject];
    [textField becomeFirstResponder];
}

-(void)setText:(NSString *)text{
    NSInteger count = MIN(text.length, self.subviews.count);
    
    for (int i=0 ;i < count ; i++) {
        UITextField *textField  = self.subviews[i];
        NSString *temp = [text substringWithRange:NSMakeRange(i, 1)];
        textField.text = temp;
    }
    
}


@end

@implementation ZCDeleteTextField

- (void)deleteBackward {
    [super deleteBackward];
    
    if ([self.delete_delegate respondsToSelector:@selector(textFieldDeleteBackward:)]) {
        [self.delete_delegate textFieldDeleteBackward:self];
    }
}




@end
