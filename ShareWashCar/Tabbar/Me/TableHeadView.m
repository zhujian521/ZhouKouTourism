//
//  TableHeadView.m
//  ShareBike
//
//  Created by zhujian on 17/7/2.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import "TableHeadView.h"

@implementation TableHeadView

- (instancetype)initWithFrame:(CGRect)frame {
   self =  [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(110,144,213);
        [self setUpView];
    }
    return self;
}
- (void)setUpView {
    UIImageView *bgImage = [[UIImageView alloc]init];
    [self addSubview:bgImage];
    bgImage.sd_layout.topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    bgImage.image = [UIImage imageNamed:@"WechatIMG1797"];
    
    UIView *whiteView = [[UIView alloc]init];
//    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    whiteView.sd_layout.centerXEqualToView(self).topSpaceToView(self,40).widthIs(86).heightIs(86);
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.cornerRadius = 43;

    UIImageView *imagePicture = [[UIImageView alloc]init];
    [whiteView addSubview:imagePicture];
    imagePicture.sd_layout.centerXEqualToView(whiteView).centerYEqualToView(whiteView).widthIs(80).heightIs(80);
    imagePicture.layer.masksToBounds = YES;
    imagePicture.layer.cornerRadius = 40;
    imagePicture.userInteractionEnabled = YES;
    imagePicture.image = [UIImage imageNamed:@"WechatIMG1792"];
    imagePicture.contentMode = UIViewContentModeScaleAspectFill;
    self.pictureImage = imagePicture;
    
    UILabel *PhoneLabel = [[UILabel alloc]init];
    [self addSubview:PhoneLabel];
    PhoneLabel.sd_layout.centerXEqualToView(self).topSpaceToView(whiteView,20).widthIs(200).heightIs(25);
    [PhoneLabel setText:@"17625328752" andFont:[UIFont systemFontOfSize:18] textColor:[UIColor blackColor
                                                                                       ] textAlignment:NSTextAlignmentCenter];
    self.phoneLabel = PhoneLabel;
    
    
}
@end
