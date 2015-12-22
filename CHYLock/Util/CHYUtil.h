//
//  CHYUtil.h
//  CHYLock
//
//  Created by chenyun on 15/12/17.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#ifndef CHYUtil_h
#define CHYUtil_h
//version
#define IOS8_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
//Device
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define USERDEFAULT [NSUserDefaults standardUserDefaults]
#define IS_iPad             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_Iphone4          (SCREEN_HEIGHT == 480)
#define IS_Iphone5          (SCREEN_HEIGHT == 568)
#define IS_Iphone6          (SCREEN_HEIGHT == 667)
#define IS_Iphone6p         (SCREEN_HEIGHT == 736)
//USER KEY
#define UDKey_DefaultGesturePasswordExistValue @"UDKey_DefaultGesturePasswordExistValue"
#define UDKey_FingerPrintPasswordSwitch @"UDKey_FingerPrintPasswordSwitch"
#define UDKey_GesturePassword @"UDKey_GesturePassword"
#define UDKey_USERTRYCOUNTKEY     @"UserTryCountKey"
#endif /* CHYUtil_h */
