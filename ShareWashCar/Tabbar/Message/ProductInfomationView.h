//
//  ProductInfomationView.h
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/6.
//  Copyright © 2019 朱健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductInfomationView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageHight;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productDescribe;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end

NS_ASSUME_NONNULL_END
