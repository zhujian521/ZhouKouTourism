//
//  HomeTableViewCell.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/4.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imagePicture.contentMode = UIViewContentModeScaleAspectFill;
    self.imagePicture.clipsToBounds = YES;
    // Configure the view for the selected state
}

@end
