//
//  CYGestureLockView.h
//  CYGestureLock
//
//  Created by chenyun on 15/11/24.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLLockViewItem.h"

typedef NS_ENUM(NSUInteger, CYGestureLockViewType) {
    CYGestureLockViewTypeSetting = 1,
    CYGestureLockViewTypeUnlock,
    CYGestureLockViewTypeModify,
    CYGestureLockViewTypeClear,
};

typedef void(^CYGestureLockViewBlock)(void);

extern NSString *const CanResetNotice;

extern NSString *const SetSuccessNotice;

@protocol CYGestureLockViewProtocol <NSObject>

@optional
- (NSString *) encryptPassword:(NSString *)password;

- (NSString *) decryptPassword:(NSString *)password;

@end

@interface CYGestureLockView : UIView
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, copy) NSString *showSubTitle;
@property (nonatomic, copy) NSString *bottomTitle;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) UIColor *showTitleColor;
//@property (nonatomic, strong) UIColor *showSubTitleColor;
@property (nonatomic, strong) UIColor *bottomTitleColor;
@property (nonatomic, strong) UIView *bottomView;//默认为nil

@property (nonatomic, copy) CYGestureLockViewBlock unLockSuccessBlock;
@property (nonatomic, copy) CYGestureLockViewBlock maxWrongBlock;
@property (nonatomic, copy) CYGestureLockViewBlock forgotPasswordBlock;

@property (nonatomic, assign) CYGestureLockViewType lockType;
@property (nonatomic, weak) id<CYGestureLockViewProtocol>delegate;

+ (void) setShowSubTitle:(NSString *)showSubTitle;

+ (void) deletePassword;

- (void)showAvatarByCircularMask:(BOOL)isShow;

- (BOOL) existUserPasswordKey:(NSString *)key;

- (BOOL) existDefaultPasswordKey;

- (void) resetSetting;

@end
