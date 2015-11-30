//
//  GLLockView.h
//  CHYLock
//
//  Created by chenyun on 15/11/24.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLOvercircleView.h"

typedef void(^GLLockViewBlock)(void);
@interface GLLockView : UIView
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, copy) NSString *showSubTitle;
@property (nonatomic, copy) NSString *bottomTitle;
@property (nonatomic, strong) UIImage *showLogo;
@property (nonatomic, strong) UIColor *showTitleColor;
@property (nonatomic, strong) UIColor *showSubTitleColor;
@property (nonatomic, strong) UIColor *bottomTitleColor;
@property (nonatomic, strong) UIView *bottomView;//默认为nil

@property (nonatomic, copy) GLLockViewBlock unLockSuccessBlock;
@property (nonatomic, copy) GLLockViewBlock unLockFailedBlock;
@property (nonatomic, copy) GLLockViewBlock maxWrongBlock;

+ (void)ShowLock;

- (void)showLogoByCircularMask:(BOOL)isShow;


@end
