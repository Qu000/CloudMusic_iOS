//
//  ThreeLevelPickerView.h
//  PeopleStreet
//
//  Created by 辰领科技 on 16/3/9.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "MyPopWindow.h"

@interface ThreeLevelPickerView : MyPopWindow
- (instancetype)initWithSelectedAtRows:(NSArray *)rows complect:(void (^)(NSString * str))complect;
@end
