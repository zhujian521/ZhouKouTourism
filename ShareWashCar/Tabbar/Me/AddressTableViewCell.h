//
//  AddressTableViewCell.h
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/7.
//  Copyright © 2019 朱健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

NS_ASSUME_NONNULL_END
