//
//  OrderTableViewCell.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/9.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the view for the selected state
}

@end
