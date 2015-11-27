//
//  GLOvercircleView.m
//  CHYLock
//
//  Created by chenyun on 15/11/18.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLOvercircleView.h"
#import "UIColor+HexColor.h"

const CGFloat externRadius = 20.0;

const CGFloat externSolidRadius = 10.0;

NSString *const externCircleColor = @"#FFBD18";
NSString *const externCircleColorWrong = @"#FF5A5A";
NSString *const solidCircleColor = @"#2A2A2A";

@implementation GLOvercircleView
{
    BOOL _isTouched;
    BOOL _isWrong;
    CGFloat _externRadius;
    CGFloat _externSolidRadius;
}

- (void)drawRect:(CGRect)rect {
    _externRadius = self.frame.size.height - 2;
    _externSolidRadius = _externRadius / 3;
    if ([self isTouched]) {
        [self drawLockViewWith:rect user:[UIColor colorWithHexString:externCircleColor alpha:1.0]];
    }else if ([self isWrongUnlock]) {
        [self drawLockViewWith:rect user:[UIColor colorWithHexString:externCircleColorWrong alpha:1.0]];
    }else{
        [self drawSolidCircle:rect color:[UIColor colorWithHexString:solidCircleColor alpha:1.0]];
    }
}

- (void) drawLockViewWith:(CGRect)rect user:(UIColor *)color{
    CGColorRef cgcolor = color.CGColor;
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(cx);
    CGContextSetStrokeColorWithColor(cx,cgcolor);
    CGContextSetLineWidth(cx, 1.0);
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    CGContextAddArc(cx,centerX, centerY, _externRadius / 2, 0, M_PI *2, 1);
    CGContextStrokePath(cx);
    CGContextSetFillColorWithColor(cx,cgcolor);
    CGRect solidRect = CGRectMake(centerX - _externSolidRadius / 2, centerY -  _externSolidRadius / 2, _externSolidRadius, _externSolidRadius);
    CGContextFillEllipseInRect(cx, solidRect);
    CGContextRestoreGState(cx);
}

- (void) drawSolidCircle:(CGRect)rect color:(UIColor *)color{
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

- (void) setTouched:(BOOL)isTouched{
    _isTouched = isTouched;
}

- (BOOL) isTouched{
    return _isTouched;
}

- (void) setWrongUnlock:(BOOL)isWrong{
    _isWrong = isWrong;
}

- (BOOL) isWrongUnlock{
    return _isTouched;
}
@end
