//
//  ViewController.m
//  CHYLock
//
//  Created by chenyun on 15/11/17.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "ViewController.h"
#import "GLLockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLLockView *glView = [[GLLockView alloc]initWithFrame:CGRectMake(100, 200, 300, 300)];
    glView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    glView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:glView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
