//
//  StarsView.m
//  ZZLogistics
//
//  Created by 辰领科技 on 15/12/25.
//  Copyright © 2015年 辰领科技. All rights reserved.
//

#import "StarsView.h"
@interface StarsView ()

@property(nonatomic,strong)void(^complect)(CGFloat index);
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)UILabel * scoreLabel;
@end

@implementation StarsView

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger )numberOfStars complect:(void(^)(CGFloat index))complect{
    self = [super initWithFrame:frame];
    _complect = complect;
    _count = numberOfStars;
    for (NSInteger i = 0; i<numberOfStars; i++) {
        UIButton * stars = [UIButton buttonWithType:UIButtonTypeCustom];
        stars.frame = flexibleFrame(CGRectMake(24*i, 0, 19, 19), NO);
        [stars setBackgroundImage:[UIImage imageNamed:@"indentComment11"] forState:UIControlStateNormal];
        [stars setBackgroundImage:[UIImage imageNamed:@"indentComment10"] forState:UIControlStateSelected];
        stars.selected = YES;
        stars.tag = 100+i;
        [stars addTarget:self action:@selector(changeStars:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:stars];
        
        
       
    }

    UILabel * label = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(24*numberOfStars, 0, 30, frame.size.height/VerticalRatio()), NO)];
    label.font = [UIFont systemFontOfSize:14*VerticalTexeRatio()];
    label.textColor = kGetColor(252, 189, 48);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = [NSString stringWithFormat:@"%.1f",(float)numberOfStars];
    [self addSubview:label];
    _scoreLabel = label;
    
    return self;
}

- (void)changeStars:(UIButton*)sender{
    [sender setBackgroundImage:[UIImage imageNamed:@"indentComment12"] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"indentComment10"] forState:UIControlStateSelected];
    sender.selected = !sender.selected;
    
    for (NSInteger i = 100; i<100+_count; i++) {
        
        UIButton * button = (UIButton *)[self viewWithTag:i];
        if (i<sender.tag) {
            [button setBackgroundImage:[UIImage imageNamed:@"indentComment11"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"indentComment10"] forState:UIControlStateSelected];
            button.selected = YES;
        }else if (i>sender.tag){
            [button setBackgroundImage:[UIImage imageNamed:@"indentComment11"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"indentComment10"] forState:UIControlStateSelected];
        button.selected = NO;
        }else{
        
        }
        
    }
    
    if (sender.selected) {
        _complect(sender.tag - 99);
        _scoreLabel.text = [NSString stringWithFormat:@"%.1f",(float)(sender.tag - 99)];
    }else{
        _complect(sender.tag - 99.5);
        _scoreLabel.text = [NSString stringWithFormat:@"%.1f",(float)(sender.tag - 99.5)];

    }
}
@end
