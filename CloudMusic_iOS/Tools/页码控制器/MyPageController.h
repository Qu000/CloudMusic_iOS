//
//  MyPageController.h
//  jufuyuan
//
//  Created by 刘建峰 on 2017/3/21.
//  Copyright © 2017年 chenling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageController : UIView

- (instancetype)initWithFrame:(CGRect)frame pointNum:(NSInteger)pointNum defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage insterval:(NSInteger)insterval;

@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger pointNum;

@end
