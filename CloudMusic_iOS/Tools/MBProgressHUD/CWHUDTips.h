//
//  CWHUDTips.h
//  Tips
//
//  Created by ly on 13-12-20.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    TipsStatusTextOnly,       // 提示文字
    TipsStatusLoading         // 提示加载动画
};

typedef int TipsStatusType;

@interface CWHUDTips : NSObject

+ (instancetype)sharedInstance;

+ (void)showTips:(NSString *)tips;

+ (void)showLoadingTips:(NSString *)tips;

+ (void)hideTips;

- (void)showTips:(NSString *)tips;

- (void)showLoadingTips:(NSString *)tips;

- (void)showTips:(NSString *)tips withStatus:(int)status dismissAfter:(NSTimeInterval)delay;

- (void)hideTips;

- (void)hideTipsAnimated:(BOOL)animated;





@end
