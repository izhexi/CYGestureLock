//
//  ViewController.m
//  CHYLock
//
//  Created by chenyun on 15/11/17.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "ViewController.h"
#import "CYGestureLockManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)modifyEvent:(id)sender {
    [CYGestureLockManager presentLockControllerFrom:self typed:CYGestureLockViewTypeModify animted:YES showBack:YES successBlock:^{
    
    }];
}
- (IBAction)setEvent:(id)sender {
    [CYGestureLockManager pushLockControllerForm:self typed:CYGestureLockViewTypeSetting animted:YES successBlock:^{
    }];
}
- (IBAction)unlockEvent:(id)sender {
    [CYGestureLockManager presentLockControllerFrom:self typed:CYGestureLockViewTypeUnlock animted:YES showBack:NO successBlock:^{
        
    }];
}
- (IBAction)clearEvent:(id)sender {
    [CYGestureLockManager presentLockControllerFrom:self typed:CYGestureLockViewTypeClear animted:YES showBack:YES successBlock:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
