//
//  GLLockViewController.m
//  CHYLock
//
//  Created by chenyun on 15/11/30.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockViewController.h"

@interface GLLockViewController ()
@property (nonatomic, strong) GLLockView *lockView;
@end

@implementation GLLockViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.lockView = [[GLLockView alloc]initWithFrame:self.view.frame];
    self.lockView.lockType = self.lockType;
    [self.view addSubview:self.lockView];
}

- (void) setShowTitle:(NSString *)showTitle{
    [self.lockView setShowTitle:showTitle];
}

- (void) setShowSubTitle:(NSString *)showSubTitle{
    [self.lockView setShowSubTitle:showSubTitle];
}

- (void) setBottomTitle:(NSString *)bottomTitle{
    [self.lockView setBottomTitle:bottomTitle];
}

- (void) setShowTitleColor:(UIColor *)showTitleColor{
    [self setShowTitleColor:showTitleColor];
}

- (void) setShowSubTitleColor:(UIColor *)showSubTitleColor{
    [self setShowSubTitleColor:showSubTitleColor];
}

- (void) setBottomTitleColor:(UIColor *)bottomTitleColor{
    [self setBottomTitleColor:bottomTitleColor];
}

- (void) setBottomView:(UIView *)bottomView{
    [self.lockView setBottomView:bottomView];
}

- (void) setLockType:(CHYLockViewType)lockType{
    [self.lockView setLockType:lockType];
}

- (void) showLogoByCircularMask:(BOOL)isShow{
    [self.lockView showLogoByCircularMask:isShow];
}

- (void) setUnLockSuccessBlock:(GLLockViewBlock)unLockSuccessBlock{
    self.lockView.unLockSuccessBlock = unLockSuccessBlock;
}

- (void) setMaxWrongBlock:(GLLockViewBlock)maxWrongBlock{
    self.lockView.maxWrongBlock = maxWrongBlock;
}

- (void) setForgotPasswordBlock:(GLLockViewBlock)forgotPasswordBlock{
    self.lockView.forgotPasswordBlock = forgotPasswordBlock;
}

@end
