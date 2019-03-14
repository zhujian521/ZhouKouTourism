//
//  UserFeedBackViewController.m
//  Angela
//
//  Created by zhujian on 18/3/2.
//  Copyright © 2018年 zhujian. All rights reserved.
//

#import "UserFeedBackViewController.h"
#import "PlaceholderTextView.h"
@interface UserFeedBackViewController ()
@property (nonatomic, strong)PlaceholderTextView * textView;
@property (nonatomic, strong)UIView * aView;
@end

@implementation UserFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(246, 246, 246);
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(sendFeedBack)];
    self.navigationItem.rightBarButtonItem = rightBar;

    self.aView = [[UIView alloc]init];
    [self.view addSubview:self.aView];
    self.aView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,20).heightIs(180);
    self.aView.backgroundColor = [UIColor whiteColor];
    
    _textView = [[PlaceholderTextView alloc]init];
    [self.aView addSubview:_textView];
    _textView.sd_layout.leftSpaceToView(self.aView,0).rightSpaceToView(self.aView,0).topSpaceToView(self.aView,0).heightIs(140);
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.editable = YES;
    _textView.layer.cornerRadius = 4.0f;
    _textView.layer.borderColor = kTextBorderColor.CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
    _textView.placeholder = @"请将您的意见和建议告诉我们";
    

}
- (void)sendFeedBack {
    if (_textView.text.length == 0) {
        [HUDManager showTextHud:@"请输入意见"];
        return;
    }
    [HUDManager showTextHud:@"提交成功"];
    [self.navigationController popViewControllerAnimated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
