//
//  MyPopWindow.m
//  DeepBreath
//
//  Created by rimi on 15/9/21.
//  Copyright (c) 2015年 LiuJianFeng. All rights reserved.
//

#import "MyPopWindow.h"

@interface MyPopWindow()

@end
@implementation MyPopWindow
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUserInterface];
    }
    return self;
}


- (instancetype)init
{
    self = [self initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    if (self) {
        [self initUserInterface];
    }
    return self;
}


- (void)initUserInterface{
    
    self.backgroundColor = [UIColor clearColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.frame;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    self.center = self.backWindow.center;
    [self.backWindow addSubview:button];
    [self.backWindow addSubview:self];

}

//展示弹出框
- (void)show{

    [self.backWindow makeKeyAndVisible];
}

//隐藏弹出框
- (void)hide{
   
    self.backWindow.alpha = 0;
    [self.backWindow resignKeyWindow];//注销keywindow
    
     [self removeFromSuperview];
}

#pragma mark -- getter
- (UIWindow *)backWindow{

    if (!_backWindow) {
        _backWindow = ({
            UIWindow * window = [[UIWindow alloc ]initWithFrame:[[UIScreen mainScreen]bounds]];
            window.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            window.windowLevel = UIWindowLevelAlert;
            window;
        });
    }
    return _backWindow;
}
@end
