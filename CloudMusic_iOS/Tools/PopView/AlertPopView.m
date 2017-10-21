//
//  AlertPopView.m
//  Insurance
//
//  Created by 刘建峰 on 2017/7/6.
//  Copyright © 2017年 chenling. All rights reserved.
//

#import "AlertPopView.h"

@interface AlertPopView ()
@property(nonatomic,strong)void(^complect)(BOOL ifSure);
@end

@implementation AlertPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content complect:(void (^)(BOOL ifSure))complect{
    if (self= [super init]) {
        _complect = complect;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3*VerticalRatio();
        self.frame =  flexibleFrame(CGRectMake(21, 182, 278, 146), NO);
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(24, 18, 250, 20), NO)];
        titleLabel.font = [UIFont systemFontOfSize:18*VerticalTexeRatio()];
        titleLabel.textColor = kGetColor(58, 58, 58);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        
        UILabel * contentLabel = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(24, 58, 250, 20), NO)];
        contentLabel.font = [UIFont systemFontOfSize:15*VerticalTexeRatio()];
        contentLabel.textColor = kGetColor(58, 58, 58);
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.text = content;
        [self addSubview:contentLabel];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = flexibleFrame(CGRectMake(24, 108, 100, 25), NO);
        button.backgroundColor = [UIColor clearColor];
        button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:kGetColor(117, 117, 117) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13*VerticalTexeRatio()];
        [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = flexibleFrame(CGRectMake(139, 108, 113, 25), NO);
        Button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;

        [Button setTitle:@"确定" forState:UIControlStateNormal];
        [Button setTitleColor:kGetColor(100, 144, 241) forState:UIControlStateNormal];
        Button.titleLabel.font = [UIFont systemFontOfSize:13*VerticalTexeRatio()];
        [Button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self addSubview:Button];
    }
    return self;
}


- (void)cancle{
    _complect(NO);
    [self hide];
}

- (void)sure{
    _complect(YES);
    [self hide];

}

@end
