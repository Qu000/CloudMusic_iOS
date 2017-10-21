//
//  StarsView.h
//  ZZLogistics
//
//  Created by 辰领科技 on 15/12/25.
//  Copyright © 2015年 辰领科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarsView : UIView

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger )numberOfStars complect:(void(^)(CGFloat index))complect;
@end
