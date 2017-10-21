//
//  MyPopWindow.h
//  DeepBreath
//
//  Created by rimi on 15/9/21.
//  Copyright (c) 2015年 LiuJianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPopWindow : UIView
@property(nonatomic,strong)UIWindow * backWindow;
- (void)show;
- (void)hide;
@end
