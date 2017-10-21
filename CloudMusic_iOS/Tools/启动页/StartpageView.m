//
//  StartpageView.m
//  MalaysiaVideo 
//
//  Created by Macmini on 2016/12/20.
//  Copyright © 2016年 yuf. All rights reserved.
//

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width//宽
#define MainScreen_height [UIScreen mainScreen].bounds.size.height//高

#import "StartpageView.h"
#import "MyPageController.h"

@interface StartpageView ()<UIScrollViewDelegate>
{
    UIScrollView    *_bigScrollView;
    NSMutableArray  *_imageArray;
    UIPageControl   *_pageControl;
}
@property(nonatomic,strong)MyPageController * pageController;
@end

@implementation StartpageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageArray = [@[@"page1",@"page2",@"page3"]mutableCopy];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
        
        scrollView.contentSize = CGSizeMake((_imageArray.count + 1)*MainScreen_width, MainScreen_height);
        //设置反野效果，不允许反弹，不显示水平滑动条，设置代理为自己
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _bigScrollView = scrollView;
        
        for (int i = 0; i < _imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(i * MainScreen_width, 0, MainScreen_width, MainScreen_height);
            UIImage *image = [UIImage imageNamed:_imageArray[i]];
            imageView.image = image;
            
            [scrollView addSubview:imageView];
        }
        
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MainScreen_width/2, MainScreen_height - 60, 0, 40)];
        pageControl.numberOfPages = _imageArray.count;
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.currentPageIndicatorTintColor = kGetColor(208, 10, 13);
        pageControl.pageIndicatorTintColor = kGetColor(220, 220, 220);
//        [self addSubview:pageControl];
        
        _pageControl = pageControl;
        
        
        _pageController = [[MyPageController alloc]initWithFrame:flexibleFrame(CGRectMake(0, 510, 320, 20), NO) pointNum:3 defaultImage:[UIImage imageNamed:@"page4"] selectedImage:[UIImage imageNamed:@"page5"] insterval:9];
        [self addSubview:_pageController];
        
        //添加手势
        UITapGestureRecognizer *singleRecognizer;//轻拍手势
        singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        singleRecognizer.numberOfTapsRequired = 1;//设置轻拍次数
        [scrollView addGestureRecognizer:singleRecognizer];//添加到scroview上
        
    }
    
    return self;
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == 2) {
        [_pageController removeFromSuperview];

        self.hidden = YES;
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bigScrollView) {
        
        CGPoint offSet = scrollView.contentOffset;
        
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        _pageController.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码;
        if (offSet.x == 0) {
            _pageController.currentPage = 0;
        }
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
        
    }
    
    if (scrollView.contentOffset.x == (_imageArray.count) *MainScreen_width) {
        [_pageController removeFromSuperview];
        self.hidden = YES;
        
    }
    
}


@end
