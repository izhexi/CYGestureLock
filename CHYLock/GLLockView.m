//
//  GLLockView.m
//  CHYLock
//
//  Created by chenyun on 15/11/24.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockView.h"
#import "UIColor+HexColor.h"

@interface GLLockView()
@property (nonatomic, strong) NSMutableArray *lockViews;
@end

@implementation GLLockView{
    CGPoint _currentPoint;
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCircle];
    }
    return self;
}

- (NSMutableArray *)lockViews{
    if (!_lockViews) {
        _lockViews = [[NSMutableArray alloc]init];
    }
    return _lockViews;
}

- (void) createCircle{
    for (NSUInteger i = 0; i < 9; i ++) {
        GLOvercircleView *circleView = [[GLOvercircleView alloc]init];
        circleView.number = @(i).stringValue;
        circleView.backgroundColor = [UIColor clearColor];
        [self addSubview:circleView];
    }
}

- (void) layoutSubviews{
    [super layoutSubviews];
    for (NSUInteger i = 0; i < self.subviews.count; i ++) {
        CGFloat row = i / 3; //行
        CGFloat col = i % 3; //列
        GLOvercircleView *lockView = self.subviews[i];
        CGFloat height = (self.bounds.size.width - 100) / 3.0;
        CGFloat width = height;
        CGFloat padding = (self.bounds.size.width - 3 * width) /4;
        
        CGFloat x = padding + (width + padding) * col;
        CGFloat y = padding + (width + padding) * row;
        lockView.frame = CGRectMake(x,y, width, height);
    }
}

- (void)drawRect:(CGRect)rect{
    CGContextRef cx = UIGraphicsGetCurrentContext();
    for (NSUInteger i = 0; i < self.lockViews.count; i ++) {
        GLOvercircleView *view = self.lockViews[i];
        if (i == 0) {
            CGContextMoveToPoint(cx, view.center.x, view.center.y);
        }
        else {
            CGContextAddLineToPoint(cx, view.center.x, view.center.y);
        }
    }
    CGContextAddLineToPoint(cx, _currentPoint.x, _currentPoint.y);
    CGContextSetLineWidth(cx, 2.0);
    CGContextSetStrokeColorWithColor(cx, [UIColor colorWithHexString:@"ffbd18" alpha:1.0].CGColor);
    CGContextStrokePath(cx);
 
}

#pragma mark - 触摸事件
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancleTouch];
    GLOvercircleView *touchView = [self getTouchView:touches];
    if (touchView && ![touchView isTouched]) {
        [touchView setTouched:YES];
        [touchView setNeedsDisplay];
        [self addPassString:touchView];
    }
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GLOvercircleView *touchView = [self getTouchView:touches];
    _currentPoint = [touches.anyObject locationInView:self];
    [touchView setNeedsDisplay];
    if (![touchView isTouched] && touchView) {
        [touchView setTouched:YES];
        [self addPassString:touchView];
    }
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self cancleTouch];
    [self.lockViews removeAllObjects];
//    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GLOvercircleView *touchView = [self getTouchView:touches];
    [touchView setTouched:NO];
//    [touchView setNeedsDisplay];
}

#pragma mark - 功能方法
- (GLOvercircleView *)getTouchView:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (GLOvercircleView *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, touchPoint)) {
            return  view;
        }
    }
    return nil;
}

- (BOOL)containsPints:(UIView *)view point:(CGPoint)point{
    return CGRectContainsPoint(view.frame, point);
}

- (void) cancleTouch{
    for (GLOvercircleView *view in self.subviews) {
        [view setTouched:NO];
        [view setNeedsDisplay];
    }
}

- (void) addPassString:(UIView *)view{
    [self.lockViews addObject:view];
    NSString *string = @"";
    for (GLOvercircleView *aview in self.lockViews) {
        string = [string stringByAppendingString:aview.number];
    }
    NSLog(@"%@ ",string);
}

@end
