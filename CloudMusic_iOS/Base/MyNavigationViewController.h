//
//  MyNavigationViewController.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationViewController : UINavigationController
@property (nonatomic , assign) UIInterfaceOrientation interfaceOrientation;
@property (nonatomic , assign) UIInterfaceOrientationMask interfaceOrientationMask;


- (void)popViewController;
- (void)popViewControllerWithBackIndex:(NSInteger)backIndex;//往后返回 backIndex 层

- (void)popTabbarControllerWithselectedIndex:(NSInteger)selectedIndex;//返回rootViewController  并且设置tabbarController.selectedIndex
- (void)pushToViewController:(UIViewController *)viewController;

- (void)presentToViewController:(UIViewController *)viewController;//仿present 跳转方式

- (void)dissMissViewController;//仿dissMiss 跳转方式
@end
