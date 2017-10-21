//
//  MyNavigationViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "MyNavigationViewController.h"

@interface MyNavigationViewController ()

@end

@implementation MyNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setToolbarHidden:YES];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setNavigationBarHidden:YES];
    }
    return self;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //1. 取出分栏
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    // 将frame左移分栏的宽度
//    CGRect frame = tabBar.frame;
//    frame.origin.x -= tabBar.frame.size.width;
    
    // 动画影藏tabBar
//    [UIView animateWithDuration:0.28 animations:^{
//        tabBar.frame = frame;
//    }];
    tabBar.hidden = YES;
    [super pushViewController:viewController animated:animated];
}

- (void)pushToViewController:(UIViewController *)viewController
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self pushViewController:viewController animated:YES];
}



- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    //1. 取出分栏
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    // 将frame左移分栏的宽度
//    CGRect frame = tabBar.frame;
//    frame.origin.x += tabBar.frame.size.width;
    
    // 动画影藏tabBar
//    [UIView animateWithDuration:0.28 animations:^{
//        tabBar.frame = frame;
//    }];
    if (self.childViewControllers.count==2) {
        tabBar.hidden = NO;
    }
    return [super popViewControllerAnimated:animated];
}


- (void)popViewController
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self popViewControllerAnimated:YES];
    
}


- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //1. 取出分栏
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    // 将frame左移分栏的宽度
    //    CGRect frame = tabBar.frame;
    //    frame.origin.x += tabBar.frame.size.width;
    
    // 动画影藏tabBar
    //    [UIView animateWithDuration:0.28 animations:^{
    //        tabBar.frame = frame;
    //    }];
    if (self.childViewControllers[0] == viewController) {
        tabBar.hidden = NO;
    }
    return [super popToViewController:viewController animated:YES];
}

- (void)popViewControllerWithBackIndex:(NSInteger)backIndex{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:kCATransition];
    UIViewController * vc = [self.childViewControllers objectAtIndex:self.childViewControllers.count - 1 - backIndex];
    [self popToViewController:vc animated:NO];
}



- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    UITabBar *tabBar = self.tabBarController.tabBar;
    tabBar.hidden = NO;
    return [super popToRootViewControllerAnimated:animated];
}

- (void)popTabbarControllerWithselectedIndex:(NSInteger)selectedIndex{
    [self popToRootViewControllerAnimated:NO];
    self.tabBarController.selectedIndex = selectedIndex;
}




- (void)presentToViewController:(UIViewController *)viewController
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self pushViewController:viewController animated:NO];
}

- (void)dissMissViewController{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
