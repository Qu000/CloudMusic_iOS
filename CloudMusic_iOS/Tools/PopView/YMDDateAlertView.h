//
//  LJFPickerAlterView.m
//  DeepBreath
//
//  Created by rimi on 15/9/21.
//  Copyright (c) 2015年 LiuJianFeng. All rights reserved.
//

#import "MyPopWindow.h"

@interface YMDDateAlertView : MyPopWindow
@property(nonatomic,strong)UIButton *sureButton;
- (instancetype)initWithTitle:(NSString *)title
              sureButtonTitle:(NSString *)sureButtonTitle
                    limitDate:(BOOL)limitDate //YES限制时间不得超过当前时间  NO不限制
                     dateType:(NSInteger)dateType //0  年月日格式    1 年月日时分秒格式
                     complect:(void(^)(NSString *str))complect;
@end
