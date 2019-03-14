//
//  OrderTableViewCell.h
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/9.
//  Copyright © 2019 朱健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productDescribe;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@end

NS_ASSUME_NONNULL_END
