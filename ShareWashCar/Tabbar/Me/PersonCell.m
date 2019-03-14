//
//  PersonCell.m
//  ShareBike
//
//  Created by zhujian on 17/7/2.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self setUpView];
        
    }
    return self;
}
- (void)setUpView {
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    bgView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,1);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    line.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(1);
    
    
    self.picture = [[UIImageView alloc]init];
    [bgView addSubview:self.picture];
    self.picture.sd_layout.centerYEqualToView(bgView).widthIs(25).heightIs(25).leftSpaceToView(bgView,10);
    
    
    self.titleLabel = [[UILabel alloc]init];
    [bgView addSubview:self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(self.picture,10).centerYEqualToView(bgView).widthIs(120).heightIs(35);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    self.otherLabel = [[UILabel alloc]init];
    [bgView addSubview:self.otherLabel];
    self.otherLabel.sd_layout.rightSpaceToView(bgView,5).widthIs(160).centerYEqualToView(bgView).heightIs(35);
    self.otherLabel.textAlignment = NSTextAlignmentRight;
    self.otherLabel.font = [UIFont systemFontOfSize:15];
    self.otherLabel.textColor = [UIColor lightGrayColor];
    
    self.rightImage = [[UIImageView alloc]init];
    [bgView addSubview:self.rightImage];
    self.rightImage.sd_layout.centerYEqualToView(bgView).widthIs(12).heightIs(12).rightSpaceToView(bgView,10);
    self.rightImage.image = [UIImage imageNamed:@"jiantou"];
    self.rightImage.hidden = NO;


}
- (void)setPicturePath:(NSString *)path AndTitleName:(NSString *)titleName {
    self.picture.image = [UIImage imageNamed:path];
    self.titleLabel.text = titleName;
}

@end
