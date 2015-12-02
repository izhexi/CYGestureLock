//
//  ViewController.m
//  CHYLock
//
//  Created by chenyun on 15/11/17.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "ViewController.h"
#import "GLLockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    GLLockView *glView = [[GLLockView alloc]initWithFrame:self.view.frame];//CGRectMake(100, 200, 300, 300)];
//    glView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
//    glView.lockType = CHYLockViewTypeUnlock;
//    [self.view addSubview:glView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)modifyEvent:(id)sender {
    GLLockViewController *vc = [[GLLockViewController alloc]init];
    vc.lockType = CHYLockViewTypeModify;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)setEvent:(id)sender {
    GLLockViewController *vc = [[GLLockViewController alloc]init];
    vc.lockType = CHYLockViewTypeSetting;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)unlockEvent:(id)sender {
    GLLockViewController *vc = [[GLLockViewController alloc]init];
    vc.lockType = CHYLockViewTypeUnlock;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clearEvent:(id)sender {
    GLLockViewController *vc = [[GLLockViewController alloc]init];
    vc.lockType = CHYLockViewTypeClear;
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
