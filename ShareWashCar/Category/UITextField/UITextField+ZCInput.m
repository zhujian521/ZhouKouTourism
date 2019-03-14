//
//  UITextField+ZCInput.m
//  ZCLib_IOS
//
//  Created by ZhiCheng on 2016/10/17.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import "UITextField+ZCInput.h"
#import <objc/runtime.h>
@interface UITextField()

@property(nonatomic, strong) InputTextFieldCallback leftCallback;

@property(nonatomic, strong) InputTextFieldCallback rightCallback;

@property(nonatomic, strong) TextChangeCallback textChange;

@end

static void * LeftCallbackPorpertyKey = (void *)@"LeftCallbackPorpertyKey";
static void * RightCallbackPorpertyKey = (void *)@"RightCallbackPorpertyKey";
static void * TextChangePorpertyKey = (void *)@"TextChangePorpertyKey";
static void * LeftButtonPorpertyKey = (void *)@"LeftButtonPorpertyKey";
static void * RightButtonPorpertyKey = (void *)@"RightButtonPorpertyKey";



@implementation UITextField (ZCInput)

-(void)addLeftViewWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName frameWidth:(CGFloat )frameWidth clickCallback:(InputTextFieldCallback)clickCallback{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frameWidth, self.frame.size.height)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [btn.imageView setContentMode:UIViewContentModeCenter];
    [btn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    self.leftView = btn;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    self.leftCallback = clickCallback;
    self.leftButton = btn;
}

-(void)addRightViewWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName frameWidth:(CGFloat )frameWidth clickCallback:(InputTextFieldCallback)clickCallback{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frameWidth, self.frame.size.height)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn.imageView setContentMode:UIViewContentModeCenter];
    
    self.rightView = btn;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    self.rightCallback = clickCallback;
    self.rightButton = btn;
}

-(void)addRightViewSize:(CGSize)size button:(ButtonStyle)button clickCallback:(InputTextFieldCallback)clickCallback textChange:(TextChangeCallback)textChange{
    CGFloat margin = 5;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, margin, size.width - margin, size.height - margin * 2)];
    [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    if (button) {
        button(btn);
    }
    
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    self.rightCallback = clickCallback;
    self.rightButton = btn;
    self.textChange = textChange;
    [self addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];
}

-(void)setup{
    [self addTarget:self action:@selector(beginEditAction) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditAction) forControlEvents:UIControlEventEditingDidEnd];
}


#pragma mark事件监听
-(void)beginEditAction{
    self.layer.borderColor = [UIColor colorWithRed:39.0 / 255.0 green:142.0 / 255.0 blue:246.0 / 255.0 alpha:1].CGColor;
    self.layer.borderWidth = 1.0f;
}

-(void)endEditAction{
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

-(void)leftAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.leftCallback) {
        self.leftCallback(button);
    }
}

-(void)rightAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.rightCallback) {
        self.rightCallback(button);
    }
}

- (void)textFieldChange{
    if (self.textChange) {
        self.textChange(self);
    }
}

-(void)setLeftCallback:(InputTextFieldCallback)leftCallback{
    objc_setAssociatedObject(self, LeftCallbackPorpertyKey, leftCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(InputTextFieldCallback)leftCallback{
    return objc_getAssociatedObject(self, LeftCallbackPorpertyKey);
}

-(void)setRightCallback:(InputTextFieldCallback)rightCallback{
    objc_setAssociatedObject(self, RightCallbackPorpertyKey, rightCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(InputTextFieldCallback)rightCallback{
    return objc_getAssociatedObject(self, RightCallbackPorpertyKey);
}

-(void)setTextChange:(void (^)(NSString *))textChange{
    objc_setAssociatedObject(self, TextChangePorpertyKey, textChange, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(NSString *))textChange{
    return objc_getAssociatedObject(self, TextChangePorpertyKey);
}

-(void)setLeftButton:(UIButton *)leftButton{
    objc_setAssociatedObject(self, LeftButtonPorpertyKey, leftButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)leftButton{
    return objc_getAssociatedObject(self, LeftButtonPorpertyKey);
}

-(void)setRightButton:(UIButton *)rightButton{
    objc_setAssociatedObject(self, RightButtonPorpertyKey, rightButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)rightButton{
    return objc_getAssociatedObject(self, RightButtonPorpertyKey);
}

@end


