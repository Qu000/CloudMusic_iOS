//
//  AlertPopView.h
//  Insurance
//
//  Created by 刘建峰 on 2017/7/6.
//  Copyright © 2017年 chenling. All rights reserved.
//

#import "MyPopWindow.h"

@interface AlertPopView : MyPopWindow
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content complect:(void (^)(BOOL ifSure))complect;
@end
