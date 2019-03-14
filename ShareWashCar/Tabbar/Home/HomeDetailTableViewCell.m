//
//  HomeDetailTableViewCell.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/5.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "HomeDetailTableViewCell.h"

@implementation HomeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userImage.contentMode = UIViewContentModeScaleAspectFill;
    self.userImage.clipsToBounds = YES;
    // Configure the view for the selected state
}



@end
