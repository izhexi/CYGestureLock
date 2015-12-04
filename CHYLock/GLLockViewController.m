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

+ (instancetype) LockViewControllerWithType:(CHYLockViewType)lockType{
    GLLockViewController *lockVC = [[GLLockViewController alloc]init];
    lockVC.lockView.lockType = lockType;
    return lockVC;
}

+ (instancetype) LockViewControllerWithType:(CHYLockViewType)lockType forKey:(NSString *)key{
    GLLockViewController *lockVC = [[GLLockViewController alloc]init];
    lockVC.lockType = lockType;
    lockVC.lockView.lockKey = key;
    return lockVC;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addResettingButton) name:CanResetNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAction) name:SetSuccessNotice object:nil];
    self.lockView = [[GLLockView alloc]initWithFrame:self.view.frame];
    self.lockView.lockType = self.lockType;
    [self.view addSubview:self.lockView];
    [self addBackButton];
}

- (void) addBackButton{
    if (self.navigationController.viewControllers.count > 0) {
        return;
    }
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 24, 60, 28)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor purpleColor];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void) addResettingButton{
    UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [setButton setTitle:@"重设" forState:UIControlStateNormal];
    [setButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    setButton.backgroundColor = [UIColor clearColor];
    [setButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void) resetAction{
    self.navigationItem.rightBarButtonItem = nil;
    [self.lockView resetSetting];
}

- (void) backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setShowTitle:(NSString *)showTitle{
    [self.lockView setShowTitle:showTitle];
}

- (void) setBottomTitle:(NSString *)bottomTitle{
    [self.lockView setBottomTitle:bottomTitle];
}

- (void) setShowTitleColor:(UIColor *)showTitleColor{
    [self setShowTitleColor:showTitleColor];
}

- (void) setBottomTitleColor:(UIColor *)bottomTitleColor{
    [self setBottomTitleColor:bottomTitleColor];
}

- (void) setBottomView:(UIView *)bottomView{
    [self.lockView setBottomView:bottomView];
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

- (void) dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
