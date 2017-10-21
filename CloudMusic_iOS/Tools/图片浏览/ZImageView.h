//
//  ZImageView.h
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZImageViewDelegate;

@interface ZImageView : UIImageView

@property (nonatomic, assign)id<ZImageViewDelegate>delegate;

- (void)resetView;

@end

@protocol ZImageViewDelegate <NSObject>

- (void)stImageViewSingleClick:(ZImageView *)imageView;

@end
