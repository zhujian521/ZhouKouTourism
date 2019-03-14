//
//  CommentViewController.m
//  ShareWashCar
//
//  Created by 朱健 on 2019/3/4.
//  Copyright © 2019 朱健. All rights reserved.
//

#import "CommentViewController.h"
#import "PlaceholderTextView.h"


@interface CommentViewController ()<UITextViewDelegate>
@property (nonatomic, strong)UIView * aView;
@property (nonatomic, strong)PlaceholderTextView * textView;
@property (nonatomic, strong)UILabel *wordCountLabel;
@property (nonatomic, strong)UITextField *textField;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.editable = YES;
    _textView.layer.cornerRadius = 4.0f;
    _textView.layer.borderColor = kTextBorderColor.CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
    _textView.placeholder = @"请输入评论";
    
    self.wordCountLabel = [[UILabel alloc]init];
    [self.aView addSubview:self.wordCountLabel];
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.text = @"0/200";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.sd_layout.topSpaceToView(_textView,5).bottomSpaceToView(self.aView,5).rightSpaceToView(self.aView,0).leftSpaceToView(self.aView,0);

}

- (void)sendFeedBack {
    [self.view endEditing:YES];
    if (self.textView.text.length == 0) {
        [HUDManager showTextHud:@"请输入评论"];
        return;
    }
    NSString *currentUsername = [AVUser currentUser].username;
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:self.commentClassName];
    [todoFolder setObject:self.textView.text forKey:@"content"];
    [todoFolder setObject:currentUsername forKey:@"name"];
    AVUser *currentUser = [AVUser currentUser];
    AVFile * avatarFile = [currentUser objectForKey:@"avatar"];
    if (avatarFile) {
        [todoFolder setObject:avatarFile forKey:@"avatar"];
    }
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [HUDManager showTextHud:@"评论成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [HUDManager showTextHud:@"评论失败"];
        }
    }];// 保存到云端
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark textField的字数限制
- (void)textViewDidChange:(UITextView *)textView {
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/200",(long)wordCount];
    [self wordLimit:textView];
}

#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 200) {
        self.textView.editable = YES;
        
    } else {
        self.textView.editable = NO;
        
    }
    return nil;
}

@end
