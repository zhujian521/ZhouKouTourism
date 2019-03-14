//
//  AddressViewController.h
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/7.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressViewController : BaseViewController
@property (nonatomic ,assign)BOOL showDeleteButton;
@property (nonatomic ,copy)void (^selectAddressBlock)(AVObject *item);
@end

NS_ASSUME_NONNULL_END
