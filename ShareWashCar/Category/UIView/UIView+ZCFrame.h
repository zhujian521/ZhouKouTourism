//
//  UIView+ZCFrame.h
//  ZCLib_IOS
//
//  Created by ZhiCheng on 16/9/19.
//  Copyright © 2016年 zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZCFrame)

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic, assign) CGFloat frameCenterX;
@property (nonatomic, assign) CGFloat frameCenterY;

@end
