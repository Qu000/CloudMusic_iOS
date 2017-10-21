//
//  BaseViewController.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQRequestApi.h"
#import "CWHUDTips.h"
#import "AppDelegate.h"
#import "MyNavigationViewController.h"

@interface BaseViewController : UIViewController<LQRequestApiDelegate>{
     BOOL _allowSwipeGesture; 
}
@property (nonatomic ,strong) LQRequestApi       *shareApi;
@property (nonatomic, strong) AppDelegate        *delegate;
@property (strong, nonatomic) UISwipeGestureRecognizer * rightSwipeGesture;
@property (strong, nonatomic)MyNavigationViewController * navgationVC;

#pragma mark  显示加载进度
#pragma mark - Actions
- (void)showWaitDialogForWait:(NSString *)str;

- (void)showWaitDialogForNetWork;

- (void)showWaitDialog:(NSString*)title state:(NSString*)state;

- (void)dismissWaitDialog;

-(void)showWaitDialogForNetWorkDismissBySelf;

#pragma mark  调整自适应布局
- (void) adaptiveViewLayout:(UIView *)viewLayout;
- (void)ShowLoginPage;
- (void)initViewLayout;
- (void)whiteStatusBar;
- (void)blackStatusBar;
- (void)backHandel;
- (void)hideKeyBoard;
@end
