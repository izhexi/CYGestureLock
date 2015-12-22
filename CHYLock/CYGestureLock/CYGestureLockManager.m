//
//  CYGestureLockManager.m
//  CHYLock
//
//  Created by chenyun on 15/12/22.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "CYGestureLockManager.h"
#import <objc/runtime.h>

static void *ShowWrongKey = "ShowGestureWrongKey";
@implementation CYGestureLockManager
+ (BOOL)IsExistGesturePassword {
    return [CYGestureLockViewController isExistGesturePassword];
}

+ (void) managerShowLockControllerFrom:(UIViewController *)controller
                                 typed:(CYGestureLockViewType)lockType
                                    by:(CYGestureShowType)showType
                               animted:(BOOL)animated
                              showBack:(BOOL)showBack
                          successBlock:(CYGestureLockViewBlock)successBlock
{
    if (lockType == CYGestureLockViewTypeClear || lockType == CYGestureLockViewTypeModify) {
        if (![self IsExistGesturePassword]) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先设置手势密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            return;
        }
    }
    CYGestureLockViewController *lockController = [CYGestureLockViewController LockViewControllerWithType:lockType];
    if (showBack) {
        lockController.showBack = showBack;
    }
    UIImageView *avatar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Avatar"]];
    [lockController setShowAvatar:avatar.image];
    [lockController setShowTitle:@"Yenge"];
    [lockController showAvatarByCircularMask:YES];
    [lockController setUnLockSuccessBlock:^{
        successBlock();
        switch (showType) {
            case CYGestureShowTypePush:{
                [controller.navigationController popViewControllerAnimated:YES];
            }
                break;
            case CYGestureShowTypePresent:{
                [controller dismissViewControllerAnimated:YES completion:nil];
            }
                break;
            default:
                break;
        }}];
    CYGestureLockManager *manager = [[CYGestureLockManager alloc]init];
    [lockController setMaxWrongBlock:[manager maxWrongBlock]];
    switch (showType) {
        case CYGestureShowTypePresent:
        {
            [controller presentViewController:lockController animated:animated completion:nil];
        }
            break;
        case CYGestureShowTypePush:{
            [controller.navigationController pushViewController:lockController animated:animated];
        }
            break;
        default:
            break;
    }
}

+ (void) forgotPassword
{
    //清除手势密码
    [CYGestureLockView deletePassword];
    //清除密码
    //退出登录
}

+ (void) pushLockControllerForm:(UIViewController *)controller typed:(CYGestureLockViewType)lockType animted:(BOOL)animated successBlock:(CYGestureLockViewBlock)unLockSuccessBlock{
    [self managerShowLockControllerFrom:controller typed:lockType  by:CYGestureShowTypePush animted:animated showBack:NO successBlock:unLockSuccessBlock];
}

+ (void) presentLockControllerFrom:(UIViewController *)controller typed:(CYGestureLockViewType)lockType animted:(BOOL)animated showBack:(BOOL)showBack successBlock:(CYGestureLockViewBlock)unLockSuccessBlock{
    [self managerShowLockControllerFrom:controller typed:lockType  by:CYGestureShowTypePresent animted:animated showBack:showBack successBlock:unLockSuccessBlock];
}

- (CYGestureLockViewBlock) maxWrongBlock
{
    CYGestureLockViewBlock wrongBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"手势密码绘制错误次数过多,请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            void(^showRelogin)(NSInteger) = ^(NSInteger buttonIndex){
                if (buttonIndex == 0) {
                    [CYGestureLockManager forgotPassword];
                }
            };
            objc_setAssociatedObject(alert, ShowWrongKey, showRelogin, OBJC_ASSOCIATION_COPY);
        });
    };
    return wrongBlock;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^WrongBlock)(NSInteger buttonIndex) = objc_getAssociatedObject(alertView, ShowWrongKey);
    WrongBlock(buttonIndex);
}

@end
