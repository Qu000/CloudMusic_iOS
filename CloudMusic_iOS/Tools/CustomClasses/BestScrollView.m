//
//  BestScrollView.m
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-13.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "BestScrollView.h"
#import "MyPageController.h"
#define   BestScrollViewHeight   180

@interface BestScrollView ()
@property(nonatomic,strong)MyPageController * pageController;

@end

@implementation BestScrollView

@synthesize  animationTimer,imageArray,myTimer;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //是否自动播放
        animationTimer =YES;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kDeviceWidth * 3,0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
//        CGRect  rect =CGRectMake((kDeviceWidth-20)/2-10,(kDeviceWidth-20)/2+20-30, 50, 37);
//        CGRect  rect =flexibleFrame(CGRectMake(135, 110, 50, 37), NO);
        CGRect  rect =CGRectMake(135*VerticalRatio(), _scrollView.frame.size.height-28, 50, 37);
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        
//        [self addSubview:_pageControl];
        
        _curPage = 0;
        _pageControl.currentPage=_curPage;
        _pageController.currentPage = _curPage;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.969 alpha:1.000];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
//        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.969 alpha:1.000];
        //
        
        
        _pageController = [[MyPageController alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_scrollView.frame)-28, CGRectGetWidth(self.frame), 28) pointNum:3 defaultImage:[UIImage imageNamed:@"CPXQ_07"] selectedImage:[UIImage imageNamed:@"CPXQ_06"] insterval:5];
        [self addSubview:_pageController];
    }
    return self;
}


-(id)initWithNormal:(CGRect )frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, BestScrollViewHeight)];
        _scrollView = [[UIScrollView alloc] initWithFrame:flexibleFrame(CGRectMake(0, 130, 320, 140), NO)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kDeviceWidth * 3,0);
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        CGRect  rect =CGRectMake(135, 110, 50, 37);
//        CGRect  rect =flexibleFrame(CGRectMake(135, 110, 50, 37), NO);
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidden=YES;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
//        [self addSubview:_pageControl];
        
        _curPage = 0;
        _pageControl.currentPage=_curPage;
        _pageController.currentPage = _curPage;
    }
    
    return  self;
    
}


-(void)showImageArray:(NSMutableArray  *)arr  withAnimation:(BOOL)animation{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        animationTimer=YES;
        //定时器
        myTimer=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
//    });

    
}



-(IBAction)pageTurn:(int )indexNum
{
    self.pageControl.currentPage=indexNum-1;
    _pageController.currentPage = indexNum-1;
    NSInteger  pageNum=self.pageControl.currentPage;
    
    CGSize viewSize=self.scrollView.frame.size;
    
    [self.scrollView setContentOffset:CGPointMake((pageNum+1)*viewSize.width, 0)];
    
//    NSLog(@"myscrollView.contentOffSet.x==%f",self.scrollView.contentOffset.x);
//    NSLog(@"pageControl currentPage==%d",self.pageControl.currentPage);
    
    myTimer=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}


-(void)scrollToNextPage:(id)sender{
    
    if (animationTimer) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+kDeviceWidth , 0)];
        [self scrollViewDidScroll:self.scrollView];
    }
}


- (void)setDataource:(id<BestScrollViewDatasource>)datasource
{
    _datasource = datasource;
    
    if (!animationTimer) {
        
        return;
    }
    
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    _pageController.pointNum = _totalPages;
    [self loadData];
}

- (void)loadData
{
    if (!animationTimer) {
        
        return;
    }
    _pageControl.currentPage = _curPage;
    _pageController.currentPage = _curPage;
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    if(!_datasource){
        
        return;
    }
    if(!_delegate){
        
        return;
    }
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        __autoreleasing UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page {
    
    if (!animationTimer) {
        
        return;
    }
    
    if (self) {
        NSInteger pre = [self validPageValue:_curPage-1];
        NSInteger last = [self validPageValue:_curPage+1];
        
        if (!_curViews) {
            _curViews = [[NSMutableArray alloc] init];
        }
        
        [_curViews removeAllObjects];
        
        
        if (_datasource) {
            
            [_curViews addObject:[_datasource pageAtIndex:pre]];
            [_curViews addObject:[_datasource pageAtIndex:page]];
            [_curViews addObject:[_datasource pageAtIndex:last]];
        }
        
        
    }
    
    
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            __autoreleasing UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
            
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    if (!animationTimer) {
        
        return;
    }
    
    int x = aScrollView.contentOffset.x;
    
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
@end
