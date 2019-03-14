//
//  PersonCell.h
//  ShareBike
//
//  Created by zhujian on 17/7/2.
//  Copyright © 2017年 zhujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *picture;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *otherLabel;
@property (nonatomic ,strong)UILabel *lineLabel;
@property (nonatomic ,strong)UIImageView *rightImage;
- (void)setPicturePath:(NSString *)path AndTitleName:(NSString *)titleName;
@end
