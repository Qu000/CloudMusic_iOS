//
//  ColorSpecial.h
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-9.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorSpecial : NSObject

+(UIColor *) randomColor;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;


+ (UIColor *)colorWithFloatRed:(float)r green:(float)g blue:(float)b;

// 230 230  230
+ (UIColor *)customColor;

@end
