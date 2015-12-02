//
//  GLLockView.m
//  CHYLock
//
//  Created by chenyun on 15/11/24.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockView.h"
#import "UIColor+HexColor.h"

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define IS_Iphone4          (SCREEN_HEIGHT == 480)
#define IS_Iphone5          (SCREEN_HEIGHT == 568)
#define IS_Iphone6          (SCREEN_HEIGHT == 667)
#define IS_Iphone6p         (SCREEN_HEIGHT == 736)
#define USERCENTER          [NSUserDefaults standardUserDefaults]
#define DEFAULTPAASWORDKEY  @"DefaultUserPassWordKey"
#define USERTRYCOUNTKEY     @"UserTryCountKey"


typedef NS_ENUM(NSUInteger, CHYLockSettingProsess) {
    CHYLockSettingProsessZero = 1,
    CHYLockSettingProsessFirst,
    CHYLockSettingProsessSecond,
};

typedef NS_ENUM(NSUInteger, CHYLockDrawWrongType) {
    CHYLockDrawWrongTypeLength = 1,
    CHYLockDrawWrongTypePassword,
};

typedef NS_ENUM(NSUInteger, CHYLockModifyProsess) {
    CHYLockModifyProsessUnlock = 1,
    CHYLockModifyProsessSetting,
};

typedef NS_ENUM(NSUInteger, CHYLockClearProcess) {
    CHYLockClearProcessUnlcok = 1,
    CHYLockClearProcessClear,
};

typedef NS_ENUM(NSUInteger, CHYLockUnLockProcess) {
    CHYLockUnLockProcessFirst = 1,
    CHYLockUnLockProcessSecond,
};
@interface GLLockView()
@property (nonatomic, strong) NSMutableArray *lockViews;
@property (nonatomic, strong) UIImageView *showLogoImageView;
@property (nonatomic, strong) UILabel *showTitleLabel;
@property (nonatomic, strong) UILabel *showSubTitleLabel;
@property (nonatomic, strong) UIButton *showBottomButton;
@property (nonatomic, strong) UIView *topContenterView;
@property (nonatomic, strong) UIView *bottomContenterView;
@property (nonatomic, strong) NSMutableArray *lockviewSubVies;
@property (nonatomic, assign) CHYLockSettingProsess settingProcess;
@property (nonatomic, assign) CHYLockModifyProsess modifyProcess;
@property (nonatomic, copy)   NSString *firstPassword;
@end

@implementation GLLockView{
    CGPoint _currentPoint;
    BOOL _isWrong;
    BOOL _isEndDraw;
    NSUInteger _mistakes;
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
    self.backgroundColor = [UIColor whiteColor];
    [self addTopContenterView];
    [self addBottomContentView];
    switch (self.lockType) {
        case CHYLockViewTypeSetting:
        {
            [self setPassword:CHYLockSettingProsessZero];
        }
            break;
            
        case CHYLockViewTypeUnlock:{
            if ([self existPasswordKey:@"hh"]) {
                [self unLockPassword:CHYLockUnLockProcessFirst];
            } else {
                self.lockType = CHYLockViewTypeSetting;
                [self setPassword:CHYLockSettingProsessZero];
            }
        }
            break;
            
        case CHYLockViewTypeModify:{
            [self modifyPassword:CHYLockModifyProsessUnlock];
        }
            break;
        case CHYLockViewTypeClear:{
            [self clearPassword:CHYLockClearProcessUnlcok];
        }
            break;
        default:
            break;
    }
}

- (void) addTopContenterView{
    self.topContenterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,120)];
    self.topContenterView.backgroundColor = [UIColor clearColor];
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
    self.bottomContenterView.backgroundColor = [UIColor clearColor];
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
    [self.topContenterView addSubview:self.showSubTitleLabel];
}

- (void) createCircle{
    for (NSUInteger i = 0; i < 9; i ++) {
        GLLockViewItem *circleView = [[GLLockViewItem alloc]init];
        circleView.number = @(i).stringValue;
        circleView.backgroundColor = [UIColor clearColor];
        [self addSubview:circleView];
        [self.lockviewSubVies addObject:circleView];
    }
}

- (void) layoutSubviews{
    [super layoutSubviews];
    for (NSUInteger i = 0; i < self.lockviewSubVies.count; i ++) {
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        GLLockViewItem *lockView = self.lockviewSubVies[i];
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
        GLLockViewItem *view = self.lockViews[i];
        if (i == 0) {
            CGContextMoveToPoint(cx, view.center.x, view.center.y);
        }
        else {
            CGContextAddLineToPoint(cx, view.center.x, view.center.y);
        }
    }
    if (!_isEndDraw) {
        CGContextAddLineToPoint(cx, _currentPoint.x, _currentPoint.y);
    }
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
    GLLockViewItem *touchView = [self getTouchView:touches];
    if (touchView && ![touchView isTouched]) {
        [touchView setTouched:YES];
        [touchView setNeedsDisplay];
        [self addPasswordString:touchView];
    }
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GLLockViewItem *touchView = [self getTouchView:touches];
    _currentPoint = [touches.anyObject locationInView:self];
    [touchView setNeedsDisplay];
    if (![touchView isTouched] && touchView) {
        [touchView setTouched:YES];
        [self addPasswordString:touchView];
    }
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GLLockViewItem *touchView = [self getTouchView:touches];
    if (!touchView) {
        return;
    }
    [self judgementPasswordLength];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GLLockViewItem *touchView = [self getTouchView:touches];
    [touchView setTouched:NO];
}

#pragma mark - 逻辑方法
- (void) judgementPasswordLength{
    _isEndDraw = YES;
    if (self.lockViews.count == 1) {
        [self wrongDrawed:CHYLockDrawWrongTypeLength];
    } else if (self.lockViews.count <4 && self.lockViews.count > 1) {
        [self wrongDrawed:CHYLockDrawWrongTypeLength];
    } else {
        [self passDrawed];
    }
    __weak GLLockView *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancleTouch];
        [weakSelf setNeedsDisplay];
    });
}

- (void) wrongDrawed:(CHYLockDrawWrongType)wrongType{
    _isWrong = YES;
    [self setShowSubTitleColor:[UIColor redColor]];
    switch (wrongType) {
        case CHYLockDrawWrongTypeLength:
        {
            [self setShowSubTitle:@"绘制错误,至少绘制4个密码"];
        }
            break;
        case CHYLockDrawWrongTypePassword:{
            [self doFailedBlock];
        }
            break;
        default:
            break;
    }
    for (GLLockViewItem *circleView in self.lockViews) {
        [circleView setWrongUnlock:YES];
        [circleView setNeedsDisplay];
    }
    [self setNeedsDisplay];
}

- (void) passDrawed{
    _isWrong = NO;
    [self setNeedsDisplay];
    switch (self.lockType) {
        case CHYLockViewTypeSetting:
        {
            self.settingProcess += 1;
            [self setPassword:self.settingProcess];
            if (self.settingProcess == CHYLockSettingProsessSecond) {
                self.settingProcess = CHYLockSettingProsessZero;
            }
        }
            break;
            
        case CHYLockViewTypeUnlock:{
            [self unLockPassword:CHYLockUnLockProcessSecond];
        }
            break;
        case CHYLockViewTypeModify:{
            if ([self isPassWordCorrect]) {
                NSLog(@"解锁成功");
                [self modifyPassword:CHYLockModifyProsessSetting];
            } else {
                NSLog(@"解锁失败");
                [self doFailedBlock];
            }
        }
            break;
        case CHYLockViewTypeClear:{
            if ([self isPassWordCorrect]) {
                [self clearPassword:CHYLockClearProcessClear];
            } else {
                [self doFailedBlock];
            }
        }
            break;
        default:
            break;
    }
}

- (GLLockViewItem *) getTouchView:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (GLLockViewItem *view in self.lockviewSubVies) {
        if (CGRectContainsPoint(view.frame, touchPoint)) {
            return  view;
        }
    }
    return nil;
}

- (void) cancleTouch{
    [self.lockViews removeAllObjects];
    _isWrong = NO;
    _isEndDraw = NO;
    for (GLLockViewItem *view in self.lockviewSubVies) {
        [view setTouched:NO];
        [view setWrongUnlock:NO];
        [view setNeedsDisplay];
    }
}

- (void) addPasswordString:(UIView *)view{
    [self.lockViews addObject:view];
    NSString *string = @"";
    for (GLLockViewItem *aview in self.lockViews) {
        string = [string stringByAppendingString:aview.number];
    }
    NSLog(@"%@ ",string);
}

- (NSString *) getCurrentPasswordString {
    NSString *string = @"";
    for (GLLockViewItem *aview in self.lockViews) {
        string = [string stringByAppendingString:aview.number];
    }
    NSLog(@"%@ ",string);
    return string;
}

- (BOOL) existPasswordKey:(NSString *)key{
    return [[USERCENTER objectForKey:DEFAULTPAASWORDKEY] boolValue];
}

- (void) setPassword:(CHYLockSettingProsess)process{
    self.settingProcess = process;
    switch (process) {
        case CHYLockSettingProsessZero:
        {
            [self setShowSubTitle:@"请绘制手势"];
        }
            break;
        case CHYLockSettingProsessFirst:
        {
            [self setShowSubTitle:@"在绘制一遍，确认密码"];
            self.firstPassword = [self getCurrentPasswordString];
            
        }
            break;
            
        case CHYLockSettingProsessSecond:{
            NSString *secondString = [self getCurrentPasswordString];
            if ([self.firstPassword isEqualToString:secondString]) {
                [self setShowSubTitle:@"设置成功"];
                [USERCENTER setObject:secondString forKey:DEFAULTPAASWORDKEY];
                [self doSuccessBlock];
            } else {
                [self setShowSubTitle:@"两次绘制不一致，请重新绘制"];
                self.firstPassword = @"";
                self.settingProcess = CHYLockSettingProsessZero;
            }
        }
            break;
        default:
            break;
    }
}

- (void) unLockPassword:(CHYLockUnLockProcess) process {
    switch (process) {
        case CHYLockUnLockProcessFirst:
        {
            NSLog(@"开始解锁");
        }
            break;
        case CHYLockUnLockProcessSecond:{
            if ([self isPassWordCorrect]) {
                [USERCENTER setObject:@(-1) forKey:USERTRYCOUNTKEY];
                [self setShowSubTitle:@"解锁成功"];
                NSLog(@"解锁成功");
                [self doSuccessBlock];
            } else {
                NSLog(@"解锁失败");
                [self doFailedBlock];
            }
        }
            break;
        default:
            break;
    }
    
}

- (void) modifyPassword:(CHYLockModifyProsess)process {
    switch (process) {
        case CHYLockModifyProsessUnlock:{
            [self setShowSubTitle:@"请绘制旧手势"];
        }
            break;
        case CHYLockModifyProsessSetting:
        {
            [self setPassword:CHYLockSettingProsessZero];
        }
            break;
        default:
            break;
    }
    
}

- (void) clearPassword:(CHYLockClearProcess)process{
    switch (process) {
        case CHYLockClearProcessUnlcok:
        {
            [self setShowSubTitle:@"请绘制旧手势"];
        }
            break;
        case CHYLockClearProcessClear:{
            [USERCENTER removeObjectForKey:DEFAULTPAASWORDKEY];
            [self doSuccessBlock];
        }
            break;
        default:
            break;
    }
}

- (NSString *) getPassword {
    return [USERCENTER objectForKey:DEFAULTPAASWORDKEY];
}

- (NSUInteger) getMistakeNumber{
    NSUInteger mistakesTime = [[USERCENTER objectForKey:USERTRYCOUNTKEY] integerValue];
    if (mistakesTime == 0) {
        mistakesTime = 1;
    }
    return mistakesTime;
}
- (void) saveMistakeNumber{
    [USERCENTER setObject:@(_mistakes + 1) forKey:USERTRYCOUNTKEY];
}

- (BOOL) isPassWordCorrect{
    if ([[self getCurrentPasswordString] isEqualToString:[self getPassword]]) {
        return YES;
    }
    return NO;
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

- (void) setLockType:(CHYLockViewType)lockType{
    _lockType = lockType;
    [self buildUI];
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
    _mistakes = [self getMistakeNumber];
    [self setShowSubTitleColor:[UIColor redColor]];
    [self setShowSubTitle:[NSString stringWithFormat:@"输入错误，剩余%ld次",5 - _mistakes]];
    [self saveMistakeNumber];
    if (_mistakes == 5) {
        [self doMaxWrongBlock];
        _mistakes = -1;
        return;
    }
}

- (void) doMaxWrongBlock{
    if (self.maxWrongBlock) {
        self.maxWrongBlock();
    }
}

- (void) doForgotBlock{
    if (self.forgotPasswordBlock) {
        self.forgotPasswordBlock();
    }
}

@end
