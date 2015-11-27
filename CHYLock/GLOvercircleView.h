//
//  GLOvercircleView.h
//  CHYLock
//
//  Created by chenyun on 15/11/18.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  外部圆半径
 */
extern const CGFloat externRadius;

/**
 *  内部实心圆半径
 */
extern const CGFloat externSolidRadius;

/**
 *  外部圆圈颜色
 */
extern NSString *const externCircleColor;

/**
 *  实心圆十六进制值
 */
extern NSString *const externSolidColor;

@interface GLOvercircleView : UIView

@property (nonatomic, copy) NSString *number;

- (void)setTouched:(BOOL)isTouched;

- (void) setWrongUnlock:(BOOL)isWrong;

- (BOOL)isTouched;
@end
