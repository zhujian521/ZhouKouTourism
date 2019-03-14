//
//  UIAlertController+Blocks.m
//  UIAlertControllerBlocks
//
//  Created by Ryan Maxwell on 11/09/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Ryan Maxwell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of
//  this software and associated documentation files (the "Software"), to deal
//  in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of
//  the Software, and to permit persons to whom the Software is furnished to do
//  so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIAlertController+Blocks.h"

static NSInteger const UIAlertControllerBlocksCancelButtonIndex = 0;
static NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;

@implementation UIAlertController (Blocks)
+ (nonnull instancetype)showTipView:(nonnull UIViewController *)viewController
                          withTitle:(nullable NSString *)title
                            message:(nullable NSString *)message
                     preferredStyle:(UIAlertControllerStyle)preferredStyle
                              paras:(nullable id)paras
                           tapBlock:(nullable UIAlertControllerCompletionBlock)
                                        tapBlock {
  return [self showInViewController:viewController
                               withTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert
                       cancelButtonTitle:nil
                  destructiveButtonTitle:nil
                       otherButtonTitles:@[ @"确定" ]
                               textViews:nil
                                   paras:paras
      popoverPresentationControllerBlock:nil
                                tapBlock:tapBlock];
}
+ (instancetype)showInViewController:(UIViewController *)viewController
                           withTitle:(NSString *)title
                             message:(NSString *)message
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                           textViews:(nullable NSArray *)textViews
                               paras:(id)paras
  popoverPresentationControllerBlock:
      (void (^)(UIPopoverPresentationController *popover))
          popoverPresentationControllerBlock
                            tapBlock:
                                (UIAlertControllerCompletionBlock)tapBlock {
  UIAlertController *strongController =
      [self alertControllerWithTitle:title
                             message:message
                      preferredStyle:preferredStyle];

  __weak UIAlertController *controller = strongController;

  if (cancelButtonTitle) {
    UIAlertAction *cancelAction = [UIAlertAction
        actionWithTitle:cancelButtonTitle
                  style:UIAlertActionStyleCancel
                handler:^(UIAlertAction *action) {
                  if (tapBlock) {
                    tapBlock(controller, action,
                             UIAlertControllerBlocksCancelButtonIndex, paras);
                  }
                }];
    [controller addAction:cancelAction];
  }

  for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
    NSString *otherButtonTitle = otherButtonTitles[i];

    UIAlertAction *otherAction = [UIAlertAction
        actionWithTitle:otherButtonTitle
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                  if (tapBlock) {
                    tapBlock(controller, action,
                             UIAlertControllerBlocksFirstOtherButtonIndex + i,
                             paras);
                  }
                }];
    [controller addAction:otherAction];
  }

  if (destructiveButtonTitle) {
    UIAlertAction *destructiveAction = [UIAlertAction
        actionWithTitle:destructiveButtonTitle
                  style:UIAlertActionStyleDestructive
                handler:^(UIAlertAction *action) {
                  if (tapBlock) {
                    tapBlock(controller, action,
                             UIAlertControllerBlocksDestructiveButtonIndex,
                             paras);
                  }
                }];

    [controller addAction:destructiveAction];
  }

  if (popoverPresentationControllerBlock) {
    popoverPresentationControllerBlock(
        controller.popoverPresentationController);
  }
  if (textViews) {
    for (NSString *tv in textViews) {
      [controller addTextFieldWithConfigurationHandler:^(
                      UITextField *_Nonnull textField) {
        [textField setPlaceholder:tv];
      }];
    }
  }
  [viewController presentViewController:controller animated:YES completion:nil];

  return controller;
}

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                    paras:(id)paras
                                 tapBlock:(UIAlertControllerCompletionBlock)
                                              tapBlock {
  return [self showInViewController:viewController
                               withTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert
                       cancelButtonTitle:cancelButtonTitle
                  destructiveButtonTitle:destructiveButtonTitle
                       otherButtonTitles:otherButtonTitles
                               textViews:nil
                                   paras:paras
      popoverPresentationControllerBlock:nil
                                tapBlock:tapBlock];
}

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                textViews:(NSArray *)textViews
                                    paras:(id)paras
                                 tapBlock:(UIAlertControllerCompletionBlock)
                                              tapBlock {
  return [self showInViewController:viewController
                               withTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert
                       cancelButtonTitle:cancelButtonTitle
                  destructiveButtonTitle:destructiveButtonTitle
                       otherButtonTitles:otherButtonTitles
                               textViews:textViews
                                   paras:paras
      popoverPresentationControllerBlock:nil
                                tapBlock:tapBlock];
}

+ (instancetype)
showActionSheetInViewController:(UIViewController *)viewController
                      withTitle:(NSString *)title
                        message:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
         destructiveButtonTitle:(NSString *)destructiveButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles
                          paras:(id)paras
                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock {
  return [self showActionSheetInViewController:viewController
                                     withTitle:title
                                       message:message
                             cancelButtonTitle:cancelButtonTitle
                        destructiveButtonTitle:destructiveButtonTitle
                             otherButtonTitles:otherButtonTitles
                                         paras:paras
            popoverPresentationControllerBlock:nil
                                      tapBlock:tapBlock];
}

+ (instancetype)
   showActionSheetInViewController:(UIViewController *)viewController
                         withTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 otherButtonTitles:(NSArray *)otherButtonTitles
                             paras:(id)paras
popoverPresentationControllerBlock:
    (void (^)(UIPopoverPresentationController *popover))
        popoverPresentationControllerBlock
                          tapBlock:(UIAlertControllerCompletionBlock)tapBlock {
  return [self showInViewController:viewController
                               withTitle:title
                                 message:message
                          preferredStyle:UIAlertControllerStyleActionSheet
                       cancelButtonTitle:cancelButtonTitle
                  destructiveButtonTitle:destructiveButtonTitle
                       otherButtonTitles:otherButtonTitles
                               textViews:nil
                                   paras:paras
      popoverPresentationControllerBlock:popoverPresentationControllerBlock
                                tapBlock:tapBlock];
}

#pragma mark -

- (BOOL)visible {
  return self.view.superview != nil;
}

- (NSInteger)cancelButtonIndex {
  return UIAlertControllerBlocksCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex {
  return UIAlertControllerBlocksFirstOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex {
  return UIAlertControllerBlocksDestructiveButtonIndex;
}

@end
