//
//  BestScrollView.h
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-13.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BestScrollViewDelegate;
@protocol BestScrollViewDatasource;

@interface BestScrollView :UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    __unsafe_unretained id<BestScrollViewDelegate>   _delegate;
    __unsafe_unretained id<BestScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
    
    NSMutableArray *imageArray;//存放图片
    NSTimer *myTimer;//定时器
    
    BOOL  animationTimer;
    
    
}
@property (nonatomic,assign) BOOL  animationTimer;

@property (nonatomic,strong) NSTimer *myTimer;//定时器

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *imageArray;//存放图片

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<BestScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<BestScrollViewDelegate> delegate;
 

- (void)reloadData;

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

-(void)showImageArray:(NSMutableArray  *)arr  withAnimation:(BOOL)animation;

-(IBAction)pageTurn:(int )indexNum;

-(id)initWithNormal:(CGRect )frame;

@end

@protocol BestScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(BestScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol BestScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;



@end
