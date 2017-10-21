//
//  MyTabBarController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyNavigationViewController.h"
@interface MyTabBarController ()

@end

@implementation MyTabBarController

-(void)viewWillAppear:(BOOL)animated{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
    self.tabBarController.tabBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self greatChildControllers];
    [self configurationNavigationAndTabbar];
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)greatChildControllers{
//    //b.创建子控制器
    UIStoryboard *oneStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *page = [oneStroyBoard instantiateViewControllerWithIdentifier:@"MusicHome"];
    MyNavigationViewController * nav1 = [[MyNavigationViewController alloc]initWithRootViewController:page];
    
    

//    
//    UIStoryboard *twoStroyBoard=[UIStoryboard storyboardWithName:@"MessageStoryboard" bundle:nil];
//    UIViewController *page2 = [twoStroyBoard instantiateViewControllerWithIdentifier:@"MessageCenter"];
//    MyNavigationViewController * nav2 = [[MyNavigationViewController alloc]initWithRootViewController:page2];
//    
//    UIStoryboard *threeStroyBoard=[UIStoryboard storyboardWithName:@"TransStoryboard" bundle:nil];
//    UIViewController *page3 = [threeStroyBoard instantiateViewControllerWithIdentifier:@"Trans"];
//    MyNavigationViewController * nav3 = [[MyNavigationViewController alloc]initWithRootViewController:page3];
//    
//    UIStoryboard *fourStroyBoard=[UIStoryboard storyboardWithName:@"HistoryStoryboard" bundle:nil];
//    UIViewController *page4 = [fourStroyBoard instantiateViewControllerWithIdentifier:@"History"];
//    MyNavigationViewController * nav4 = [[MyNavigationViewController alloc]initWithRootViewController:page4];
//    
//    UIStoryboard *fiveStroyBoard=[UIStoryboard storyboardWithName:@"MyStoryboard" bundle:nil];
//    UIViewController *page5 = [fiveStroyBoard instantiateViewControllerWithIdentifier:@"My"];
//    MyNavigationViewController * nav5 = [[MyNavigationViewController alloc]initWithRootViewController:page5];
//
    self.viewControllers=@[nav1];

}

//配置导航栏与状态栏
- (void)configurationNavigationAndTabbar{
//    //为工具栏设置标题与图片
    UITabBar *tabBar = self.tabBar;    
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
//    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
//
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 50)];
//    imageView.backgroundColor = [UIColor whiteColor];
//    imageView.image = [UIImage imageNamed:@"nav"];
//    [tabBar insertSubview:imageView atIndex:4];
//    
//    
//    [tabBarItem3 setImageInsets:UIEdgeInsetsMake(-15, 0, 15, 0)];
//    
    //声明这张图片用原图(别渲染)
//    UIColor *selectColor = kGetColor(253, 172, 49);
//    UIColor *normalColor = kGetColor(146, 146, 146);
//    UIImage *selectedImage = [UIImage imageNamed:@"nav1_on.png"];
//    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tabBarItem1.title = @"首页";
//    [tabBarItem1 setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:[UIImage imageNamed:@"n1.png"]];
//    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObject:selectColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
//    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObject:normalColor forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
//
//    UIImage *selectedImage2 = [UIImage imageNamed:@"nav2.png"];
//    selectedImage2 = [selectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tabBarItem2.title = @"消息";
//    [tabBarItem2 setFinishedSelectedImage:[[UIImage imageNamed:@"nav2_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:selectedImage2];
//    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObject:selectColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
//    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObject:normalColor forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
//    
//    
//    UIImage *selectedImage3 = [UIImage imageNamed:@"nav3.png"];
//    selectedImage3 = [selectedImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tabBarItem3.title = @"";
//    [tabBarItem3 setFinishedSelectedImage:[[UIImage imageNamed:@"nav3_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:selectedImage3];
//    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObject:selectColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
//    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObject:normalColor forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
//    
//
//    UIImage *selectedImage4 = [UIImage imageNamed:@"nav4.png"];
//    selectedImage4 = [selectedImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tabBarItem4.title = @"历史";
//    [tabBarItem4 setFinishedSelectedImage:[[UIImage imageNamed:@"nav4_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:selectedImage4];
//    [tabBarItem4 setTitleTextAttributes:[NSDictionary dictionaryWithObject:selectColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
//    [tabBarItem4 setTitleTextAttributes:[NSDictionary dictionaryWithObject:normalColor forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
//    
//    
//    UIImage *selectedImage5 = [UIImage imageNamed:@"nav5.png"];
//    selectedImage5 = [selectedImage5 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    tabBarItem5.title = @"我的";
//    [tabBarItem5 setFinishedSelectedImage:[[UIImage imageNamed:@"nav5_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:selectedImage5];
//    [tabBarItem5 setTitleTextAttributes:[NSDictionary dictionaryWithObject:selectColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
//    [tabBarItem5 setTitleTextAttributes:[NSDictionary dictionaryWithObject:normalColor forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];

}




-(void) viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
