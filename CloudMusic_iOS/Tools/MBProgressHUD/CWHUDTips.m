//
//  CWHUDTips.m
//  Tips
//
//  Created by ly on 13-12-20.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "CWHUDTips.h"
#import "MBProgressHUD.h"

#define DefaultDismissTime      1.5

@interface CWHUDTips ()

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

@implementation CWHUDTips

+ (instancetype)sharedInstance
{
    static CWHUDTips *_hudTips = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _hudTips = [[CWHUDTips alloc] init];
    });
    return _hudTips;
}


#pragma mark - Actions

+ (void)showTips:(NSString *)tips
{
    [[CWHUDTips sharedInstance] showTips:tips];
}

+ (void)showLoadingTips:(NSString *)tips
{
    [[CWHUDTips sharedInstance] showLoadingTips:tips];
}

+ (void)hideTips
{
    [[CWHUDTips sharedInstance] hideTips];
}

- (void)showTips:(NSString *)tips
{
    [self showTips:tips withStatus:TipsStatusTextOnly dismissAfter:DefaultDismissTime];
}

- (void)showLoadingTips:(NSString *)tips
{
    [self showTips:tips withStatus:TipsStatusLoading dismissAfter:-1];
}

- (void)showTips:(NSString *)tips withStatus:(TipsStatusType)status dismissAfter:(NSTimeInterval)delay
{
    [self initializeProgressHud];
    
    // Configure mode
    [self configureProgressHudForStatus:status];
    
    // Set the tips
    self.progressHUD.labelText = tips;
    
    // Show
    [self.progressHUD show:YES];
    
    // Hide after `delay`
    if (delay > 0.0) {
        [self performSelector:@selector(hideTips) withObject:nil afterDelay:delay];
    }
}

- (void)hideTips
{
    [self hideTipsAnimated:YES];
}

- (void)hideTipsAnimated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:containerWindow() animated:animated];
//    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
}

#pragma mark - 

- (void)initializeProgressHud
{
    if ( _progressHUD && _progressHUD.superview) {
        [self hideTips];
        [CWHUDTips cancelPreviousPerformRequestsWithTarget:self];
    }
    [containerWindow() addSubview:self.progressHUD];
}

- (void)configureProgressHudForStatus:(TipsStatusType)status
{
    if ( TipsStatusTextOnly == status ) {
        self.progressHUD.mode = MBProgressHUDModeText;
    }
    else if (TipsStatusLoading == status ) {
        self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    }
    else {
        self.progressHUD.mode = MBProgressHUDModeText;
    }
}


#pragma mark - Property
- (MBProgressHUD *)progressHUD
{
    if ( _progressHUD == nil ) {
        _progressHUD = [[MBProgressHUD alloc] initWithWindow:containerWindow()];
        _progressHUD.removeFromSuperViewOnHide = YES;
        _progressHUD.userInteractionEnabled = NO;
    }
    return _progressHUD;
}


#pragma mark - Helper
static inline
UIWindow *containerWindow()
{
    UIWindow *window;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    if ([windows count] > 1) {
        window = [windows objectAtIndex:1];
    } else {
        window = [windows firstObject];
    }
    return window;
}


#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [MBProgressHUD  hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


@end
