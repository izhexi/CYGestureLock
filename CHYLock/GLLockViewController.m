//
//  GLLockViewController.m
//  CHYLock
//
//  Created by chenyun on 15/11/30.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "GLLockViewController.h"

@interface GLLockViewController ()
@property (nonatomic, strong) GLLockView *lockView;
@end

@implementation GLLockViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.lockView = [[GLLockView alloc]initWithFrame:self.view.frame];
    self.lockView.lockType = self.lockType;
    [self.view addSubview:self.lockView];
}

@end
