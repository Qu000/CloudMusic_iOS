//
//  ColorSpecial.m
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-9.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "ColorSpecial.h"

@implementation ColorSpecial


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [self colorWithFloatRed:r green:g blue:b];
}

+ (UIColor *)colorWithFloatRed:(float)r green:(float)g blue:(float)b
{
    return [UIColor colorWithRed:(r / 255.0f)
                           green:(g / 255.0f)
                            blue:(b / 255.0f)
                           alpha:1.0f];
}


// 230 230  230
+ (UIColor *)customColor{

    return [UIColor colorWithRed:(255 / 255.0f)
                           green:(255 / 255.0f)
                            blue:(255 / 255.0f)
                           alpha:1.0f];
}


+(UIColor *) randomColor

{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
}

@end
