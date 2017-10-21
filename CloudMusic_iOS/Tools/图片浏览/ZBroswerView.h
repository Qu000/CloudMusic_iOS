//
//  ZBroswerView.h
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBroswerView : UIView
/**
 * @brief 初始化方法  图片以数组的形式传入, 需要显示的当前图片的索引
 *
 * @param  imageArray 需要显示的图片以数组的形式传入
 * @param  index 需要显示的当前图片的索引
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index;
- (void)showInCell:(UIView *)view;
@property(nonatomic,strong)NSString * titleStr;
@end
