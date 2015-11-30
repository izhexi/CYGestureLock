//
//  GLLockView.m
//  CHYLock
//
//  Created by chenyun on 15/11/24.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockView.h"
#import "UIColor+HexColor.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IS_Iphone4          (SCREEN_HEIGHT == 480)
#define IS_Iphone5          (SCREEN_HEIGHT == 568)
#define IS_Iphone6          (SCREEN_HEIGHT == 667)
#define IS_Iphone6p         (SCREEN_HEIGHT == 736)

@interface GLLockView()
@property (nonatomic, strong) NSMutableArray *lockViews;
@property (nonatomic, strong) UIImageView *showLogoImageView;
@property (nonatomic, strong) UILabel *showTitleLabel;
@property (nonatomic, strong) UILabel *showSubTitleLabel;
@property (nonatomic, strong) UIButton *showBottomButton;
@property (nonatomic, strong) UIView *topContenterView;
@property (nonatomic, strong) UIView *bottomContenterView;
@property (nonatomic, strong) NSMutableArray *lockviewSubVies;
@end

@implementation GLLockView{
    CGPoint _currentPoint;
    BOOL _isWrong;
}

- (NSMutableArray *) lockViews{
    if (!_lockViews) {
        _lockViews = [[NSMutableArray alloc]init];
    }
    return _lockViews;
}

- (NSMutableArray *)lockviewSubVies{
    if (!_lockviewSubVies) {
        _lockviewSubVies = [NSMutableArray array];
    }
    return _lockviewSubVies;
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCircle];
        [self buildUI];
    }
    return self;
}

#pragma mark - UI创建
- (void)buildUI{
    [self addTopContenterView];
    [self addBottomContentView];
}

- (void) addTopContenterView{
    self.topContenterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,120)];
    self.topContenterView.backgroundColor = [UIColor greenColor];
    CGPoint center =CGPointMake(SCREEN_WIDTH / 2, self.topContenterView.frame.size.height);
    self.topContenterView.center = center;
    [self addSubview:self.topContenterView];
    [self addLogoView];
    [self addTitleLable];
    [self addSubTitleLabel];
}

- (void) addBottomContentView{
    self.bottomContenterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    CGPoint center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 40);
    self.bottomContenterView.backgroundColor = [UIColor purpleColor];
    self.bottomContenterView.center = center;
    [self addSubview:self.bottomContenterView];
    [self addBottomButton];
}

- (void) addBottomButton{
    self.showBottomButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    self.showBottomButton.backgroundColor = [UIColor clearColor];
    [self.showBottomButton setTitle:@"管理手势密码" forState:UIControlStateNormal];
    [self.showBottomButton setTitleColor:[UIColor colorWithHexString:@"2a2a2a" alpha:1.0] forState:UIControlStateNormal];
    [self.showBottomButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    CGPoint center = CGPointMake(SCREEN_WIDTH / 2, self.bottomContenterView.frame.size.height / 2);
    self.showBottomButton.center = center;
    [self.showBottomButton addTarget:self action:@selector(bottomButoonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContenterView addSubview:self.showBottomButton];
}

- (void) addLogoView{
    self.showLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.showLogoImageView.backgroundColor = [UIColor clearColor];
    CGPoint center = CGPointMake(self.topContenterView.bounds.size.width / 2, self.showLogoImageView.frame.size.height / 2);
    self.showLogoImageView.center = center;
    self.showLogoImageView.backgroundColor = [UIColor redColor];
    [self.topContenterView addSubview:self.showLogoImageView];
}

- (void) addTitleLable{
    self.showTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 21)];
    self.showTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.showTitleLabel.textColor = [UIColor colorWithHexString:@"2a2a2a" alpha:1.0];
    self.showTitleLabel.font = [UIFont systemFontOfSize:12.0];
    CGPoint center = CGPointMake(self.topContenterView.bounds.size.width / 2, self.showLogoImageView.bounds.size.height + 10);
    self.showTitleLabel.center = center;
    self.showTitleLabel.text = @"188****8888";
    [self.topContenterView addSubview:self.showTitleLabel];
}

- (void) addSubTitleLabel{
    self.showSubTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 30)];
    self.showSubTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.showSubTitleLabel.textColor = [UIColor colorWithHexString:@"2a2a2a" alpha:1.0];
    self.showSubTitleLabel.font = [UIFont systemFontOfSize:17.0];
    CGPoint center = CGPointMake(self.topContenterView.bounds.size.width / 2, self.showTitleLabel.frame.origin.y  + self.showTitleLabel.frame.size.height + 10);
    self.showSubTitleLabel.center = center;
    self.showSubTitleLabel.text = @"密码错误，还可以再输入4次";
    [self.topContenterView addSubview:self.showSubTitleLabel];
}

- (void) createCircle{
    for (NSUInteger i = 0; i < 9; i ++) {
        GLOvercircleView *circleView = [[GLOvercircleView alloc]init];
        circleView.number = @(i).stringValue;
        circleView.backgroundColor = [UIColor clearColor];
        [self addSubview:circleView];
        [self.lockviewSubVies addObject:circleView];
    }
}

- (void) layoutSubviews{
    [super layoutSubviews];
    for (NSUInteger i = 0; i < self.lockviewSubVies.count; i ++) {
        CGFloat row = i / 3; //行
        CGFloat col = i % 3; //列
        GLOvercircleView *lockView = self.lockviewSubVies[i];
        CGFloat marginX = 0;
        if (IS_Iphone4) {
            marginX = 20;
        }
        CGFloat height = (self.bounds.size.width - 150) / 3.0;
        CGFloat width = height;
        CGFloat padding = (self.bounds.size.width - 3 * width) /4 - marginX;
        
        CGFloat x = padding + (width + padding) * col + 2*marginX;
        CGFloat y = padding + (width + padding) * row + self.topContenterView.frame.size.height + 50;
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
    UIColor *color;
    if (_isWrong) {
        color =  [UIColor colorWithHexString:@"FF5A5A" alpha:1.0];
    } else {
        color =  [UIColor colorWithHexString:@"ffbd18" alpha:1.0];
    }
    CGContextSetStrokeColorWithColor(cx, color.CGColor);
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
    [self judgementPasswordLength];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GLOvercircleView *touchView = [self getTouchView:touches];
    [touchView setTouched:NO];
}

#pragma mark - 功能方法
- (void) judgementPasswordLength{
    if (self.lockViews.count <4 && self.lockViews.count > 1) {
        [self wrongDrawed];
    } else {
        [self passDrawed];
    }
    __weak GLLockView *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancleTouch];
        [weakSelf setNeedsDisplay];
    });
}

- (void) wrongDrawed{
    _isWrong = YES;
    for (GLOvercircleView *circleView in self.lockViews) {
        [circleView setWrongUnlock:YES];
        [circleView setNeedsDisplay];
    }
    [self setNeedsDisplay];
}

- (void) passDrawed{
    _isWrong = NO;
    [self setNeedsDisplay];
}

- (GLOvercircleView *) getTouchView:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (GLOvercircleView *view in self.lockviewSubVies) {
        if (CGRectContainsPoint(view.frame, touchPoint)) {
            return  view;
        }
    }
    return nil;
}

- (void) cancleTouch{
    [self.lockViews removeAllObjects];
    _isWrong = NO;
    for (GLOvercircleView *view in self.lockviewSubVies) {
        [view setTouched:NO];
        [view setWrongUnlock:NO];
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

#pragma mark - setter
- (void) setShowTitle:(NSString *)showTitle{
    _showTitle = showTitle;
    self.showTitleLabel.text = _showTitle;
}

- (void) setShowSubTitle:(NSString *)showSubTitle{
    _showSubTitle = showSubTitle;
    self.showSubTitleLabel.text = showSubTitle;
}

- (void) setBottomTitle:(NSString *)bottomTitle{
    _bottomTitle = bottomTitle;
    [self.showBottomButton setTitle:_bottomTitle forState:UIControlStateNormal];
}

- (void) setShowTitleColor:(UIColor *)showTitleColor{
    _showTitleColor = showTitleColor;
    [self.showTitleLabel setTextColor:_showTitleColor];
}

- (void) setShowSubTitleColor:(UIColor *)showSubTitleColor{
    _showSubTitleColor = showSubTitleColor;
    [self.showSubTitleLabel setTextColor:_showSubTitleColor];
}

- (void) setBottomTitleColor:(UIColor *)bottomTitleColor{
    _bottomTitleColor = bottomTitleColor;
    [self.showBottomButton setTitleColor:_bottomTitleColor forState:UIControlStateNormal];
}

- (void) setBottomView:(UIView *)bottomView{
    _bottomView = bottomView;
    if (_bottomView) {
        [self.bottomContenterView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bottomContenterView addSubview:_bottomView];
    }
}

- (void) showLogoByCircularMask:(BOOL)isShow{
    if (isShow) {
        [self.showLogoImageView.layer setCornerRadius:self.showLogoImageView.frame.size.width];
    }else{
        [self.showLogoImageView.layer setCornerRadius:0];
    }
}

#pragma  mark - Actions
- (void) bottomButoonEvent:(id)sender{
    NSLog(@"First blood!");
}

- (void) doSuccessBlock{
    if (self.unLockSuccessBlock) {
        self.unLockSuccessBlock();
    }
}

- (void) doFailedBlock{
    if (self.unLockFailedBlock) {
        self.unLockFailedBlock();
    }
}

- (void) doMaxWrongBlock{
    if (self.maxWrongBlock) {
        self.maxWrongBlock();
    }
}

@end
