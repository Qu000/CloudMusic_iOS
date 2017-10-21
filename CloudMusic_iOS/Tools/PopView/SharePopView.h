//
//  SharePopView.h
//  Edumap
//
//  Created by 刘建峰 on 16/8/23.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "MyPopWindow.h"

@interface SharePopView : MyPopWindow
- (instancetype)initWithTitles:(NSArray *)titles complect:(void(^)(NSInteger index))complect;
@end
