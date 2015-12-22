//
//  GLLockViewItem.h
//  CHYLock
//
//  Created by chenyun on 15/11/18.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    //正上
    LockItemViewDirecTop = 1,
    
    //右上
    LockItemViewDirecRightTop,
    
    //右
    LockItemViewDirecRight,
    
    //右下
    LockItemViewDiretRightBottom,
    
    //下
    LockItemViewDirecBottom,
    
    //左下
    LockItemViewDirecLeftBottom,
    
    //左
    LockItemViewDirecLeft,
    
    //左上
    LockItemViewDirecLeftTop,
    
}LockItemViewDirect;

@interface CYGestureLockViewItem : UIView

@property (nonatomic, copy) NSString *number;
@property (nonatomic, assign) LockItemViewDirect direct;

- (void)setTouched:(BOOL)isTouched;

- (void) setWrongUnlock:(BOOL)isWrong;

- (BOOL)isTouched;
@end
