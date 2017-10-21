//
//  Common.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Common : NSObject
//拨打电话
+ (void)callPhone:(NSString*)iphoneNum view:(UIView*)view;
//电话验证
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//数据非空验证
//-------------判断登陆
+(BOOL)getLoginStatus;
//-------------等到登陆用户个人信息
+(NSDictionary *)getLoginInfo;
//删除plist文件
+ (BOOL)DeleteSingleFile;
//加密
+ (NSString *) shaEncrypt:(NSString *)input;
//计算几小时前
+ (NSString *)updateTimeForData:(NSString * )data;

+ (NSString *)stringFromData:(id)data;
//解析URL参数
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr ;
//保留1~4位小数 去掉数字末尾的0   leftNum=1~4
+ (NSString *)deletLastZero:(CGFloat)num leftNum:(NSInteger)leftNum;
//快速获得UIViewcontroller
+ (UIViewController *)getViewControllerWithStoryboardName:(NSString *)storyboardName Identifier:(NSString *)identifier;
@end
