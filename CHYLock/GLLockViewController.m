//
//  CMGestureLockViewController.m
//  CMGestureLock
//
//  Created by chenyun on 15/11/30.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface CMGestureLockViewController ()<CMGestureLockViewProtocol>
@property (nonatomic, strong) CMGestureLockView *lockView;
//@property (nonatomic, assign) BOOL isPresent;
@end

@implementation CMGestureLockViewController

+ (instancetype) LockViewControllerWithType:(CMGestureLockViewType)lockType
{
    CMGestureLockViewController *lockVC = [[CMGestureLockViewController alloc]init];
    lockVC.lockView = [[CMGestureLockView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    lockVC.lockView.lockType = lockType;
    return lockVC;
}

+ (BOOL) isExistGesturePassword:(NSString *)key
{
    return [[USERDEFAULT objectForKey:key] isEqualToString:@"YES"];
}

+ (BOOL) isExistGesturePassword
{
    return [[USERDEFAULT objectForKey:UDKey_DefaultGesturePasswordExistValue] isEqualToString:@"YES"];
}

+ (void) deletePassword
{
    [CMGestureLockView deletePassword];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addResettingButton) name:CanResetNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAction) name:SetSuccessNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fingerUnlock)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    if (self.navigationController) {
//        [self addBackButtonForNavigationBar];
        self.title = @"手势密码设置";
    }
}

//- (void) addBackButtonForNavigationBar
//{
//    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 28)];
//    UIImage *image = CM_Image(@"cm_icon_white_arrow_left");
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    [imageView setFrame:CGRectMake(6, 14-image.size.height/2, image.size.width, image.size.height)];
//    [settingButton addSubview:imageView];
//    
//    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(imageView.x+1+image.size.width, 0, 60, 28)];
//    label.font = [UIFont systemFontOfSize:17];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"返回";
//    [settingButton addSubview:label];
//    [settingButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
//    self.navigationItem.leftBarButtonItem = setting;
//    
//}

- (void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fingerUnlock];
}

//- (void)addBackButton
//{
//    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 28)];
//    [settingButton setImage:CM_Image(@"cm_nav_btn_back_black") forState:UIControlStateNormal];
//    [settingButton setTitle:@"返回" forState:UIControlStateNormal];
//    [settingButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:settingButton];
//    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(20));
//        make.top.equalTo(@(20));
//    }];
//}


- (void) addResettingButton
{
    UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [setButton setTitle:@"重设" forState:UIControlStateNormal];
    [setButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    setButton.backgroundColor = [UIColor clearColor];
    [setButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void) resetAction
{
    self.navigationItem.rightBarButtonItem = nil;
    [self.lockView resetSetting];
}

- (void) dismissAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setLockView:(CMGestureLockView *)lockView
{
    _lockView = lockView;
    _lockView.delegate = self;
    [self.view addSubview:_lockView];
}

- (void) setShowTitle:(NSString *)showTitle
{
    [self.lockView setShowTitle:showTitle];
}

+ (void) setShowSubtitle:(NSString *)showSubtitle
{
    [CMGestureLockView setShowSubTitle:showSubtitle];
}

- (void) setBottomTitle:(NSString *)bottomTitle
{
    [self.lockView setBottomTitle:bottomTitle];
}

- (void) setShowTitleColor:(UIColor *)showTitleColor
{
    [self.lockView setShowTitleColor:showTitleColor];
}

- (void) setBottomTitleColor:(UIColor *)bottomTitleColor
{
    [self.lockView setBottomTitleColor:bottomTitleColor];
}

- (void) setShowAvatar:(UIImage *)image
{
    [self.lockView setAvatar:image];
}

- (void) setBottomView:(UIView *)bottomView
{
    [self.lockView setBottomView:bottomView];
}

- (void) showAvatarByCircularMask:(BOOL)isShow
{
    [self.lockView showAvatarByCircularMask:isShow];
}

- (void) setUnLockSuccessBlock:(CMGestureLockViewBlock)unLockSuccessBlock
{
    self.lockView.unLockSuccessBlock = unLockSuccessBlock;
}

- (void) setMaxWrongBlock:(CMGestureLockViewBlock)maxWrongBlock
{
    self.lockView.maxWrongBlock = maxWrongBlock;
}

- (void) setForgotPasswordBlock:(CMGestureLockViewBlock)forgotPasswordBlock
{
    self.lockView.forgotPasswordBlock = forgotPasswordBlock;
}

- (void) setShowBack:(BOOL)showBack
{
    _showBack = showBack;
//    if (_showBack) {
//        [self addBackButton];
//    }
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark- 加解密回调
- (NSString *) encryptPassword:(NSString *)password
{
        return self.encryptBlock(password);
}

- (NSString *) decryptPassword:(NSString *)password
{
        return self.decryptBlock(password);
}

#pragma mark - FingerUnlock
+ (BOOL)fingerUnlockAppSetOn
{
    BOOL isTouchIDOn =
    [[USERDEFAULT objectForKey:UDKey_FingerPrintPasswordSwitch] integerValue] == 1;
    return isTouchIDOn;
}

+ (BOOL)fingerUnlockOSSupport
{
    if(IOS8_OR_LATER)
    {
        LAContext *context = [[LAContext alloc]init];
        NSError *error;
        [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if(error.code == LAErrorTouchIDNotAvailable){
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (BOOL)fingerUnlockOSSetOn
{
    if(IOS8_OR_LATER)
    {
        LAContext *context = [[LAContext alloc]init];
        NSError *error;
        [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if(error.code == LAErrorPasscodeNotSet || error.code == LAErrorTouchIDNotEnrolled){
            return NO;
        }
        return YES;
    }
    return NO;
}

- (void)fingerUnlock
{
    if (self.lockType == CMGestureLockViewTypeSetting) {
        return;
    }
    if([CMGestureLockViewController fingerUnlockOSSupport]
       && [CMGestureLockViewController fingerUnlockOSSetOn]
       && [CMGestureLockViewController fingerUnlockAppSetOn])
    {
        __block CMGestureLockViewController *weakSelf = self;
        LAContext *context = [[LAContext alloc]init];
        context.localizedFallbackTitle = @"";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"您可以使用指纹进行解锁" reply:^(BOOL success, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if(success){
                    //                    [weakSelf updateResidueDegree:UMaxResidueDegree];
                    weakSelf.lockView.unLockSuccessBlock();
                }
            }];
        }];
    }
}

+ (void)fingerUnlockAlert
{
    [[[UIAlertView alloc]initWithTitle:@"未开启系统Touch ID"
                                                   message:@"请先在系统设置Touch ID与密码中开启"
                                                  delegate:nil
                                         cancelButtonTitle:@"知道了"
                                         otherButtonTitles:nil] show];
}
@end
