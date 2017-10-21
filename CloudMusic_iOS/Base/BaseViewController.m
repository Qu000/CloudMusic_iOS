//
//  BaseViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "BaseViewController.h"
#import "MyNavigationViewController.h"
@interface BaseViewController ()

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _allowSwipeGesture = YES;
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self dismissWaitDialog];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    _navgationVC = (MyNavigationViewController *)self.navigationController;
    
    [self.view addGestureRecognizer:self.rightSwipeGesture];
    //键盘显示，隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

#pragma mark  调整自适应布局
- (void) adaptiveViewLayout:(UIView *)viewLayout{
    //视图自适应布局
    for (UIView *view in viewLayout.subviews) {
        view.frame = flexibleFrame(view.frame, NO);
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *viewField = (UITextField *)view;
            CGFloat fontSize = viewField.font.pointSize;
            viewField.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
        }else if ([view isKindOfClass:[UILabel class]]){
            UILabel *viewLabel = (UILabel *)view;
            CGFloat fontSize = viewLabel.font.pointSize;
            viewLabel.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
        }else if ([view isKindOfClass:[UIButton class]]){
            UIButton *viewButton = (UIButton *)view;
            CGFloat fontSize = viewButton.titleLabel.font.pointSize;
            viewButton.titleLabel.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
        }
    }
}

#pragma mark - Custom mehtod
- (void)hideKeyBoard{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark  ===== back
- (void)backHandel{
    [self.navgationVC popViewController];
}

#pragma mark 登陆界面======================================================
- (void)ShowLoginPage
{
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"Login"];
    [self.navgationVC presentToViewController:page ];
}

-(void)showWaitDialogForNetWork
{
    [self performSelector:@selector(showWaitDialogForWait:) withObject:nil afterDelay:0.001];
}
- (void)showWaitDialog:(NSString*)title state:(NSString*)state{
    
    [CWHUDTips showTips:title];
    
}
- (void)showWaitDialogForWait:(NSString *)str {
    
    [CWHUDTips showLoadingTips:@"加载中..."];
}

-(void)showWaitDialogForNetWorkDismissBySelf
{
    [self showWaitDialogForNetWork];
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissWaitDialog];
    });
    
}

-(void)action_swipeGesture:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)dismissWaitDialog
{
    [CWHUDTips hideTips];
}

- (UISwipeGestureRecognizer *)rightSwipeGesture
{
    if (!_rightSwipeGesture) {
        _rightSwipeGesture = ({
            UISwipeGestureRecognizer * rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_swipeGesture:)];
            rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
            
            rightSwipeGesture;
        });
    }
    return _rightSwipeGesture;
}
#pragma mark - 键盘事件=======================================
-(void)Actiondo:(id)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.view removeGestureRecognizer:self.tapGesture];
    self.tapGesture = nil;
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    //    NSLog(@"*-----HideKeyBoard");
    [self.view removeGestureRecognizer:self.tapGesture];
    self.tapGesture = nil;
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    //    NSLog(@"*-----ShowKeyBoard");
    if (self.tapGesture) {
        [self.view removeGestureRecognizer:self.tapGesture];
        self.tapGesture = nil;
    }
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Actiondo:)];
    [self.view addGestureRecognizer:self.tapGesture];
}


- (void)whiteStatusBar{
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)blackStatusBar{
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}
@end
