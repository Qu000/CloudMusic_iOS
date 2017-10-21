//
//  ZBroswerView.m
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//
#define Screen_BOUNDS   [UIScreen mainScreen].bounds
#define Screen_W        [UIScreen mainScreen].bounds.size.width
#define Screen_H        [UIScreen mainScreen].bounds.size.height
#define SpaceWidth      10 // 图片距离左右间距

#import "ZBroswerView.h"
#import "ZImageView.h"

@interface ZBroswerView ()<ZImageViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *numberLabel;
@property(nonatomic,strong)UILabel * headTitle;
@end

@implementation ZBroswerView

- (instancetype)initWithImageArray:(NSArray *)imageArray currentIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.imageArray = imageArray;
        [self setupSubViews];
        _scrollView.contentOffset = CGPointMake(Screen_W * index, 0);
    }
    return self;
}

- (void)setupSubViews
{
    int index = 0;
    for (NSString *image in self.imageArray) {
        ZImageView *imageView = [[ZImageView alloc] init];
        imageView.delegate = self;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP_Address_ImageDown,image]]];
        imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
        imageView.tag = index;
        [self.scrollView addSubview:imageView];
        index ++;
    }
    
    UIView * view = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 0, 320, 64), YES)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = flexibleFrame(CGRectMake(-30, 0, 100, 75), YES);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel * label = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(0, 26, 320, 24), YES)];
    label.textColor = [UIColor colorWithWhite:0.224 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18*VerticalTexeRatio()];
    _headTitle = label;
    [view addSubview:label];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 63, 320, 1), YES)];
    image.backgroundColor = kGetColor(244, 244, 244);
    [view addSubview:image];

}

#pragma mark - Getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:flexibleFrame(CGRectMake(0, 64, 320, 504), NO)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake((Screen_W + 2*SpaceWidth) * self.imageArray.count, 0);
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        [self numberLabel];
    }
    return _scrollView;
}

- (UILabel *)numberLabel
{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 520*VerticalRatio(), Screen_W, 40*VerticalRatio())];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.index+1, self.imageArray.count];
        [self addSubview:_numberLabel];
    }
    return _numberLabel;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _headTitle.text = titleStr;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / Screen_W;
    self.index = index;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:@"ZImageView"]) {
            ZImageView *imageView = (ZImageView *)obj;
            [imageView resetView];
        }
    }];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.index+1, self.imageArray.count];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 主要为了设置每个图片的间距，并且使图片铺满整个屏幕，实际上就是scrollview每一页的宽度是屏幕宽度+2*Space居中，图片左边从每一页的Space开始，达到间距且居中效果
    _scrollView.bounds = CGRectMake(0, 0, Screen_W + 2 * SpaceWidth, 504*VerticalRatio());
    _scrollView.center = flexibleCenter(CGPointMake(160, 316));
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(SpaceWidth + (Screen_W+20) * idx, 0, Screen_W, Screen_H);
    }];
}

- (void)showInCell:(UIView *)view
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, Screen_W, Screen_H);
    self.center = view.center;
    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.center = window.center;
        [window addSubview:self];
    }];
}

#pragma mark - ZImageViewDelegate
- (void)stImageViewSingleClick:(ZImageView *)imageView
{
    [self dismiss];
}

- (void)dismiss
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end















