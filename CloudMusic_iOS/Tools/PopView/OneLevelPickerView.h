//
//  OneLevelPickerView.h
//  PeopleStreet
//
//  Created by 辰领科技 on 16/3/9.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "MyPopWindow.h"

@interface OneLevelPickerView : MyPopWindow
- (instancetype)initWithTitles:(NSArray *)titles selectedAtRow:(NSInteger)row complect:(void (^)(NSString * str))complect;

@end
