//
//  CommentViewController.h
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/4.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : BaseViewController
@property (nonatomic ,strong)AVObject *item;
@property (nonatomic ,strong)NSString *commentClassName;
@end

NS_ASSUME_NONNULL_END
