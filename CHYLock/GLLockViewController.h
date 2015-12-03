//
//  GLLockViewController.h
//  CHYLock
//
//  Created by chenyun on 15/11/30.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLLockView.h"

@interface GLLockViewController : UIViewController
@property (nonatomic, assign) CHYLockViewType lockType;
@property (nonatomic, copy) GLLockViewBlock unLockSuccessBlock;
@property (nonatomic, copy) GLLockViewBlock maxWrongBlock;
@property (nonatomic, copy) GLLockViewBlock forgotPasswordBlock;

- (void) setShowTitle:(NSString *)showTitle;

- (void) setShowSubTitle:(NSString *)showSubTitle;

- (void) setBottomTitle:(NSString *)bottomTitle;

- (void) setShowTitleColor:(UIColor *)showTitleColor;

- (void) setShowSubTitleColor:(UIColor *)showSubTitleColor;

- (void) setBottomTitleColor:(UIColor *)bottomTitleColor;

- (void) setBottomView:(UIView *)bottomView;

- (void) setLockType:(CHYLockViewType)lockType;

- (void) showLogoByCircularMask:(BOOL)isShow;

@end
