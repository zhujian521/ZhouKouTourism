//
//  HomeTableViewCell.h
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/4.
//  Copyright © 2019 朱健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagePicture;

@end

NS_ASSUME_NONNULL_END
