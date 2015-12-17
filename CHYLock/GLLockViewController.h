//
//  CMGestureLockViewController.h
//  CMGestureLock
//
//  Created by chenyun on 15/11/30.
//  Copyright © 2015年 chenyun. All rights reserved.
//

/**
 *  管理手势密码，提供调用手势密码视图的公开接口
 *
 */
#import <UIKit/UIKit.h>
#import "GLLockView.h"

typedef NSString *(^CMGestureLockViewEncryptBlock)(NSString *);
@interface CMGestureLockViewController : UIViewController

/**
 *  解锁的功能类型
 */
@property (nonatomic, assign) CMGestureLockViewType lockType;

/**
 *  成功回调
 */
@property (nonatomic, copy) CMGestureLockViewBlock unLockSuccessBlock;

/**
 *  超过最大错误次数回调
 */
@property (nonatomic, copy) CMGestureLockViewBlock maxWrongBlock;

/**
 *  忘记密码回调
 */
@property (nonatomic, copy) CMGestureLockViewBlock forgotPasswordBlock;

/**
 *  加密方式，为空默认不加密存储
 */
@property (nonatomic, copy) CMGestureLockViewEncryptBlock encryptBlock;

/**
 *  解密回调，为空默认不解密
 */
@property (nonatomic, copy) CMGestureLockViewEncryptBlock decryptBlock;

/**
 *  在 present 呈现方式下，是否显示返回按钮
 */
@property (nonatomic, assign) BOOL showBack;

/**
 *  初始化方法
 *
 *  @param lockType 功能类型
 *
 *  @return
 */
+ (instancetype) LockViewControllerWithType:(CMGestureLockViewType)lockType;

/**
 *  是否存在自定义key的手势密码(卡包)
 *
 *  @param key 密码的查询key
 *
 *  @return
 */
+ (BOOL) isExistGesturePassword:(NSString *)key;

/**
 *  是否存在默认的手势密码
 *
 *  @return
 */
+ (BOOL) isExistGesturePassword;

/**
 *  是否支持指纹解锁
 *
 *  @return
 */
+ (BOOL) fingerUnlockOSSupport;

/**
 *  是否设置了指纹解锁
 *
 *  @return
 */
+ (BOOL) fingerUnlockOSSetOn;

/**
 *  弹处指纹解锁相关
 */
+ (void) fingerUnlockAlert;

/**
 *  删除密码
 */
+ (void) deletePassword;

/**
 *  头像下的显示文本设置
 *
 *  @param showTitle
 */
- (void) setShowTitle:(NSString *)showTitle;

/**
 *  文本颜色
 *
 *  @param showTitleColor <#showTitleColor description#>
 */
- (void) setShowTitleColor:(UIColor *)showTitleColor;

/**
 *  提示文本设置
 *
 *  @param showSubtitle
 */
+ (void) setShowSubtitle:(NSString *)showSubtitle;

/**
 *  底部button的显示文本，在设置bottomview后失效
 *
 *  @param bottomTitle
 */
- (void) setBottomTitle:(NSString *)bottomTitle;

/**
 *  底部文本颜色
 *
 *  @param bottomTitleColor
 */
- (void) setBottomTitleColor:(UIColor *)bottomTitleColor;

/**
 *  底部view的配置。添加自主配置的view。最高 80 像素
 *
 *  @param bottomView
 */
- (void) setBottomView:(UIView *)bottomView;

/**
 *  头像设置
 *
 *  @param avatar
 */
- (void) setShowAvatar:(UIImage *)avatar;

/**
 *  头像是否显示为圆形
 *
 *  @param isShow
 */
- (void) showAvatarByCircularMask:(BOOL)isShow;


@end
