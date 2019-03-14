//
//  CustomButton.h
//  BikeManager
//
//  Created by zhujian on 17/12/1.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    CustomButtonAdd,
    CustomButtonCancle,
    CustomButtonHistory,
    CustomButtonArea,
    CustomButtonSigOut,
    CustomButtonPower,
} CustomButtonStatus;
@interface CustomButton : UIButton
@property (nonatomic ,assign)CustomButtonStatus status;
@end
