//
//  UIColor+HexColor.m
//  CHYLock
//
//  Created by chenyun on 15/11/18.
//  Copyright © 2015年 chenyun. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if(hexString.length != 6)
    {
        return [UIColor clearColor];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9a-fA-F]{6}"];
    if (![predicate evaluateWithObject:hexString]) {
        return [UIColor clearColor];
    }
    
    NSString *red = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *green = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *blue = [hexString substringWithRange:NSMakeRange(4, 2)];
    uint r,g,b;
    [[NSScanner scannerWithString:red] scanHexInt:&r];
    [[NSScanner scannerWithString:green] scanHexInt:&g];
    [[NSScanner scannerWithString:blue] scanHexInt:&b];
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];

}
@end
