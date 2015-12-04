//
//  UIColor+HexColor.h
//  CHYLock
//
//  Created by chenyun on 15/11/18.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
