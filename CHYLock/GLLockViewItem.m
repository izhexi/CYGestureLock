//
//  GLLockViewItem.m
//  CHYLock
//
//  Created by chenyun on 15/11/18.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockViewItem.h"
#import "UIColor+HexColor.h"

NSString *const externCircleColor = @"#FFBD18";
NSString *const externCircleColorWrong = @"#FF5A5A";
NSString *const solidCircleColor = @"#2A2A2A";



@implementation CMGestureLockViewItem
{
    BOOL _isTouched;
    BOOL _isWrong;
    CGFloat _externRadius;
    CGFloat _externSolidRadius;
    CGFloat _angle;
}

- (void)drawRect:(CGRect)rect
{
    _externRadius = self.frame.size.height - 2;
    _externSolidRadius = _externRadius / 3;
    [self drawSolidCircle:rect color:[UIColor colorWithHexString:solidCircleColor alpha:1.0]];
    if ([self isTouched]) {
        [self drawLockViewWith:rect user:[UIColor colorWithHexString:externCircleColor alpha:1.0]];
    }
    if ([self isWrongUnlock]) {
        [self drawLockViewWith:rect user:[UIColor colorWithHexString:externCircleColorWrong alpha:1.0]];
    }
}

- (void) drawLockViewWith:(CGRect)rect user:(UIColor *)color
{
    CGColorRef cgcolor = color.CGColor;
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(cx);
    
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGContextTranslateCTM(cx, midX, midY);
    CGContextRotateCTM(cx, _angle);
    CGContextTranslateCTM(cx, -midX, -midY);
    
    CGContextSetStrokeColorWithColor(cx,cgcolor);
    CGContextSetLineWidth(cx, 1.0);
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    CGContextAddArc(cx,centerX, centerY, _externRadius / 2, 0, M_PI *2, 1);
    CGContextStrokePath(cx);
    
    CGContextSetFillColorWithColor(cx,cgcolor);
    CGRect solidRect = CGRectMake(centerX - _externSolidRadius / 2, centerY -  _externSolidRadius / 2, _externSolidRadius, _externSolidRadius);
    CGContextFillEllipseInRect(cx, solidRect);
    [self drawTriangleRect:rect color:[UIColor greenColor]];
    CGContextRestoreGState(cx);
}

- (void) drawTriangleRect:(CGRect )rect color:(UIColor *)color
{
    if (self.direct == 0) {
        return;
    }
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(cx, color.CGColor);
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    CGPoint topPoint = CGPointMake(centerX, centerY - _externSolidRadius);
    CGPoint leftPoint = CGPointMake(centerX - _externSolidRadius / 2 +5, centerY - 10);
    CGPoint rightPoint = CGPointMake(centerX + _externSolidRadius / 2 -5, centerY - 10);
    CGContextMoveToPoint(cx, topPoint.x, topPoint.y);
    CGContextAddLineToPoint(cx, leftPoint.x, leftPoint.y);
    CGContextAddLineToPoint(cx, rightPoint.x, rightPoint.y);
    CGContextClosePath(cx);
    CGContextFillPath(cx);
    
}

- (void) drawSolidCircle:(CGRect)rect color:(UIColor *)color
{
    CGColorRef cgcolor = color.CGColor;
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(cx);
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    CGContextSetFillColorWithColor(cx,cgcolor);
    CGRect solidRect = CGRectMake(centerX - _externSolidRadius / 2, centerY -  _externSolidRadius / 2, _externSolidRadius, _externSolidRadius);
    CGContextFillEllipseInRect(cx, solidRect);
    CGContextRestoreGState(cx);
    
}

- (void) setDirect:(LockItemViewDirect)direct
{
    _direct = direct;
    _angle = M_PI_4 *(direct - 1);
    [self setNeedsDisplay];
}

- (void) setTouched:(BOOL)isTouched
{
    _isTouched = isTouched;
}

- (BOOL) isTouched{
    return _isTouched;
}

- (void) setWrongUnlock:(BOOL)isWrong
{
    _isWrong = isWrong;
}

- (BOOL) isWrongUnlock
{
    return _isWrong;
}
@end
