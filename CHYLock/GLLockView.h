//
//  CMGestureLockView.h
//  CMGestureLock
//
//  Created by chenyun on 15/11/24.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLLockViewItem.h"

typedef NS_ENUM(NSUInteger, CMGestureLockViewType) {
    CMGestureLockViewTypeSetting = 1,
    CMGestureLockViewTypeUnlock,
    CMGestureLockViewTypeModify,
    CMGestureLockViewTypeClear,
};

typedef void(^CMGestureLockViewBlock)(void);

extern NSString *const CanResetNotice;

extern NSString *const SetSuccessNotice;

@protocol CMGestureLockViewProtocol <NSObject>

@optional
- (NSString *) encryptPassword:(NSString *)password;

- (NSString *) decryptPassword:(NSString *)password;

@end

@interface CMGestureLockView : UIView
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, copy) NSString *showSubTitle;
@property (nonatomic, copy) NSString *bottomTitle;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) UIColor *showTitleColor;
//@property (nonatomic, strong) UIColor *showSubTitleColor;
@property (nonatomic, strong) UIColor *bottomTitleColor;
@property (nonatomic, strong) UIView *bottomView;//默认为nil

@property (nonatomic, copy) CMGestureLockViewBlock unLockSuccessBlock;
@property (nonatomic, copy) CMGestureLockViewBlock maxWrongBlock;
@property (nonatomic, copy) CMGestureLockViewBlock forgotPasswordBlock;

@property (nonatomic, assign) CMGestureLockViewType lockType;
@property (nonatomic, weak) id<CMGestureLockViewProtocol>delegate;

+ (void) setShowSubTitle:(NSString *)showSubTitle;

+ (void) deletePassword;

- (void)showAvatarByCircularMask:(BOOL)isShow;

- (BOOL) existUserPasswordKey:(NSString *)key;

- (BOOL) existDefaultPasswordKey;

- (void) resetSetting;

@end
