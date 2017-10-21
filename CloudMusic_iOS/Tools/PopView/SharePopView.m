//
//  SharePopView.m
//  Edumap
//
//  Created by 刘建峰 on 16/8/23.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "SharePopView.h"

@interface SharePopView ()
@property(nonatomic,strong)NSArray * titlesArray;
@property(nonatomic,strong)void (^complect)(NSInteger index);
@end

@implementation SharePopView

- (instancetype)initWithTitles:(NSArray *)titles complect:(void (^)(NSInteger))complect{
    if (self =[super init]) {
        _titlesArray = titles;
        _complect = complect;
        self.frame = flexibleFrame(CGRectMake(0, 413, 320, 155), NO);
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(0, 16, 320, 17), NO)];
        title.font = [UIFont systemFontOfSize:14*VerticalTexeRatio()];
        title.textColor = [UIColor colorWithWhite:0.557 alpha:1.000];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"分享到";
        [self addSubview:title];
        
        
        UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = flexibleFrame(CGRectMake(275, 0, 45, 45), NO);
        [closeButton setImage:[UIImage imageNamed:@"share5"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 44, 320, 1), NO)];
        line.backgroundColor = [UIColor colorWithWhite:0.898 alpha:1.000];
        [self addSubview:line];
        
        for (int i = 0; i<titles.count; i++) {
            UIView * buttonView = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(80*i, 155, 80, 110), NO)];
            buttonView.tag = 100+i*2;
           
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = flexibleFrame(CGRectMake(9, 8, 63, 63), NO);
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"share%d",i+1]] forState:UIControlStateNormal];
            button.tag = 100+i*2+1;
            [button addTarget:self action:@selector(chilkHandel:) forControlEvents:UIControlEventTouchUpInside];
            [buttonView addSubview:button];
            
            
            UILabel * label = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(0, 75, 80, 17), NO)];
            label.font = [UIFont systemFontOfSize:14*VerticalTexeRatio()];
            label.textColor = [UIColor colorWithWhite:0.255 alpha:1.000];
            label.text = titles[i];
            label.textAlignment = NSTextAlignmentCenter;
            [buttonView addSubview:label];
            
            [self addSubview:buttonView];
            
            
        }
        [self showAnimation];
    }
    return self;
}


- (void)cancle{
    [self hide];
}

- (void)chilkHandel:(UIButton *)sender{
    _complect((sender.tag-100)/2);
}

- (void)showAnimation{
    for (int i = 0; i<_titlesArray.count; i++) {
        UIView * buttonView = [self viewWithTag:100+2*i];
        [UIView animateWithDuration:0.4 delay:0.05*i usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
                        buttonView.frame = flexibleFrame(CGRectMake(80*i, 45, 80, 110), NO);
        } completion:^(BOOL finished) {
            
        }];
    }
}
@end
