//
//  PhotoPopView.m
//  Edumap
//
//  Created by 刘建峰 on 16/8/23.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "PhotoPopView.h"

@interface PhotoPopView ()
@property(nonatomic,strong)void (^complect)(NSInteger index);

@end
@implementation PhotoPopView

- (instancetype)initWithcomplect:(void (^)(NSInteger))complect{
    if (self = [super init]) {
        self.frame = flexibleFrame(CGRectMake(0, 418, 320, 150), NO);
        self.backgroundColor = [UIColor whiteColor];
        _complect = complect;
        
        for (int i = 0; i<3; i++) {
            UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = flexibleFrame(CGRectMake(320, 50*i, 320, 50), NO);
            backButton.tag = 100+i;
            [backButton addTarget:self action:@selector(chilkHandel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:backButton];
            
            UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 49, 320, 1), NO)];
            line.backgroundColor = kGetColor(240, 240, 240);
            [backButton addSubview:line];
            
            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"popPhoto%d",i+1]]];
            imageView.frame = flexibleFrame(CGRectMake(98, 14, 24, 22), NO);
            [backButton addSubview:imageView];
            
            
            UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(135, 0, 100, 50), NO)];
            title.font = [UIFont systemFontOfSize:15*VerticalTexeRatio()];
            title.textColor = [UIColor colorWithWhite:0.275 alpha:1.000];
            title.textAlignment = NSTextAlignmentCenter;
            NSArray * names = @[@"拍摄照片或视频",@"从相册中选择",@"取消"];
            title.text = names[i];
            [backButton addSubview:title];
            
        }
        [self showAnimation];
    }
    return self;
}


- (instancetype)initWithPhotocomplect:(void(^)(NSInteger index))complect{
    if (self = [super init]) {
        self.frame = flexibleFrame(CGRectMake(0, 468, 320, 100), NO);
        self.backgroundColor = [UIColor whiteColor];
        _complect = complect;
        
        for (int i = 0; i<2; i++) {
            UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = flexibleFrame(CGRectMake(320, 50*i, 320, 50), NO);
            backButton.tag = 100+i;
            [backButton addTarget:self action:@selector(chilkHandel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:backButton];
            
            UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 49, 320, 1), NO)];
            line.backgroundColor = kGetColor(240, 240, 240);
            [backButton addSubview:line];
            
            NSArray * imagenames = @[@"popPhoto1",@"popPhoto3"];
            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagenames[i]]];
            imageView.frame = flexibleFrame(CGRectMake(98, 14, 24, 22), NO);
            [backButton addSubview:imageView];
            
            
            UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(135, 0, 95, 50), NO)];
            title.font = [UIFont systemFontOfSize:15*VerticalTexeRatio()];
            title.textColor = [UIColor colorWithWhite:0.275 alpha:1.000];
            title.textAlignment = NSTextAlignmentCenter;
            NSArray * names = @[@"拍照上传",@"取消"];
            title.text = names[i];
            [backButton addSubview:title];
            
        }
        [self showPhotoAnimation];
    }
    return self;
}

- (void)chilkHandel:(UIButton *)sender{
    _complect(sender.tag-100);
    [self hide];
}

- (void)showAnimation{
    for (int i = 0; i<3; i++) {
        UIButton * buttonView = [self viewWithTag:100+i];
        [UIView animateWithDuration:0.4 delay:0.05*i usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
            buttonView.frame = flexibleFrame(CGRectMake(0, 50*i, 320, 50), NO);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)showPhotoAnimation{
    for (int i = 0; i<2; i++) {
        UIButton * buttonView = [self viewWithTag:100+i];
        [UIView animateWithDuration:0.4 delay:0.05*i usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
            buttonView.frame = flexibleFrame(CGRectMake(0, 50*i, 320, 50), NO);
        } completion:^(BOOL finished) {
            
        }];
    }
}
@end
