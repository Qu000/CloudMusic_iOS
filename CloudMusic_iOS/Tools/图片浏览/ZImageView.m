//
//  ZImageView.m
//  Test
//
//  Created by huanxin xiong on 2016/11/30.
//  Copyright © 2016年 xiaolu zhao. All rights reserved.
//

#import "ZImageView.h"
#import "UIView+Extension.h"

@interface ZImageView()<UIGestureRecognizerDelegate>
{
    CGFloat _lastScale; // 最后一次图片放大倍数
}
// 用于显示完整图片
@property (nonatomic, strong) UIScrollView *scrollView;
// 完整图片
@property (nonatomic, strong) UIImageView *scrollImgV;
// 用于放大缩小图片的scrollView
@property (nonatomic, strong) UIScrollView *scaleScrollView;
// 用于显示放大缩小的图片
@property (nonatomic, strong)UIImageView *scaleImgV;
@property (nonatomic, assign) BOOL doubleAction;

@end

@implementation ZImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTapGesture];
    }
    return self;
}

- (void)setupTapGesture
{
    self.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *ges = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageViewAction:)];
    ges.delegate = self;
    _lastScale = 1.f;
    [self addGestureRecognizer:ges];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
}


#pragma mark - Getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)scrollImgV
{
    if (_scrollImgV == nil) {
        _scrollImgV = [[UIImageView alloc] init];
        _scrollImgV.image = self.image;
        [self.scrollView addSubview:_scrollImgV];
    }
    return _scrollImgV;
}

- (UIScrollView *)scaleScrollView
{
    if (_scaleScrollView == nil) {
        _scaleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scaleScrollView.bounces = NO;
        _scaleScrollView.backgroundColor = kGetColor(243, 243, 243);
        _scaleScrollView.contentSize = self.bounds.size;
        [self addSubview:_scaleScrollView];
    }
    return _scaleScrollView;
}

- (UIImageView *)scaleImgV
{
    if (_scaleImgV == nil) {
        _scaleImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scaleImgV.image = self.image;
        [self.scaleScrollView addSubview:_scaleImgV];
    }
    return _scaleImgV;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imageSize = self.image.size;
    // 图片高度大于屏幕高度
    if (self.width * (imageSize.height / imageSize.width) > self.height) {
        [self scrollView];
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.width * (imageSize.height / imageSize.width));
        self.scrollImgV.center = self.scrollView.center;
        self.scrollImgV.bounds = CGRectMake(0, 0, imageSize.width, self.width * (imageSize.height / imageSize.width));
    }else{
        if (_scrollView)[_scrollView removeFromSuperview];
    }
}

#pragma mark - Action
- (void)scaleImageViewAction:(UIPinchGestureRecognizer *)ges
{
    // 当前放大倍数
    CGFloat scale = ges.scale;
    // 我们需要知道的是当前手势收缩率对于刚才手势的相对收缩 scale - 1，然后在加上最后一次收缩率，为当前要展示的收缩率
    CGFloat shouldScale = _lastScale + (scale - 1);
    [self setScaleImageWithScale:shouldScale];
    // 图片大小改变后设置手势scale为1
    ges.scale = 1.0;
}

- (void)setScaleImageWithScale:(CGFloat)scale
{
    // 最大2倍，最小.5
    if (scale >= 2) {
        scale = 2;
    }else if (scale <= 0.5){
        scale = .5;
    }
    _lastScale = scale;
    self.scaleImgV.transform = CGAffineTransformMakeScale(scale, scale);
    if (scale > 1) {
        CGFloat imageWidth = self.scaleImgV.width;
        CGFloat imageHeight = MAX(self.scaleImgV.height, self.frame.size.height);
        [self bringSubviewToFront:self.scaleScrollView];
        self.scaleImgV.center = CGPointMake(imageWidth * 0.5, imageHeight * 0.5);
        self.scaleScrollView.contentSize = CGSizeMake(imageWidth, imageHeight);
        
        CGPoint offset = self.scaleScrollView.contentOffset;
        offset.x = (imageWidth - self.width)/2.0;
        offset.y = (imageHeight - self.height)/2.0;
        self.scaleScrollView.contentOffset = offset;
    }else{
        self.scaleImgV.center = self.scaleScrollView.center;
        self.scaleScrollView.contentSize = CGSizeZero;
    }
}

- (void)singleClick:(UITapGestureRecognizer *)singleTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(stImageViewSingleClick:)]) {
        [self.delegate stImageViewSingleClick:self];
    }
}

- (void)doubleClick:(UITapGestureRecognizer *)doubleTap
{
    if (_lastScale > 1) {
        _lastScale = 1;
    }else{
        _lastScale = 2;
    }
    [UIView animateWithDuration:.5 animations:^{
        [self setScaleImageWithScale:_lastScale];
    } completion:^(BOOL finished) {
        if (_lastScale == 1) {
            [self resetView];
        }
    }];
}

// 当图片回复原样，清楚放大的图片和scrollview
- (void)resetView
{
    if (!self.scaleScrollView) {
        return;
    }
    self.scaleScrollView.hidden = YES;
    [self.scaleScrollView removeFromSuperview];
    self.scaleScrollView = nil;
    self.scaleImgV = nil;
}

@end



























