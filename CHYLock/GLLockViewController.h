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

+ (instancetype) LockViewControllerWithType:(CHYLockViewType)lockType;

+ (instancetype) LockViewControllerWithType:(CHYLockViewType)lockType forKey:(NSString *)key;

- (void) addBackButton;

- (void) setShowTitle:(NSString *)showTitle;

- (void) setBottomTitle:(NSString *)bottomTitle;

- (void) setShowTitleColor:(UIColor *)showTitleColor;

- (void) setBottomTitleColor:(UIColor *)bottomTitleColor;

- (void) setBottomView:(UIView *)bottomView;

- (void) showLogoByCircularMask:(BOOL)isShow;

@end
