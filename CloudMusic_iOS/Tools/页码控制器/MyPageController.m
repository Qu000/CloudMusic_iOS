//
//  MyPageController.m
//  jufuyuan
//
//  Created by 刘建峰 on 2017/3/21.
//  Copyright © 2017年 chenling. All rights reserved.
//

#import "MyPageController.h"

@interface MyPageController()
@property(nonatomic,strong)UIImage * defaultImage;
@property(nonatomic,strong)UIImage * selectedImage;
@property(nonatomic,assign)CGFloat   insterval;
@property(nonatomic,assign)CGFloat   startX;
@property(nonatomic,assign)CGFloat   startY;

@end

@implementation MyPageController

- (instancetype)initWithFrame:(CGRect)frame pointNum:(NSInteger)pointNum defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage insterval:(NSInteger)insterval{
    if (self = [super initWithFrame:frame]) {
        _pointNum = pointNum;
        _insterval = insterval;
        _defaultImage = defaultImage;
        _selectedImage = selectedImage;
        self.backgroundColor = [UIColor clearColor];
        _currentPage = 0;
        [self reInitView];
    }
    return self;
}


- (void)setCurrentPage:(NSInteger)currentPage{
  
    _currentPage = currentPage;
    [self reInitView];
    
}

- (void)setPointNum:(NSInteger)pointNum{
    _pointNum = pointNum;
    [self reInitView];
}


- (void)reInitView{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    _startX = (CGRectGetWidth(self.frame)-((_pointNum-1)*(_insterval + _defaultImage.size.width)+_selectedImage.size.width)*VerticalRatio())/2;
    _startY = (CGRectGetHeight(self.frame)-_defaultImage.size.height*VerticalRatio())/2;
    
    for (int i = 0; i<_pointNum; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i<_currentPage) {
            button.frame = CGRectMake(_startX+(_defaultImage.size.width+_insterval)*VerticalRatio()*i, _startY, _defaultImage.size.width*VerticalRatio(), _defaultImage.size.height*VerticalRatio());
        }else if(i==_currentPage){
            button.frame = CGRectMake(_startX+(_defaultImage.size.width+_insterval)*VerticalRatio()*i, _startY, _selectedImage.size.width*VerticalRatio(), _selectedImage.size.height*VerticalRatio());
        }else{
            button.frame = CGRectMake(_startX+(_defaultImage.size.width+_insterval)*VerticalRatio()*(i-1)+(_selectedImage.size.width+_insterval)*VerticalRatio(),_startY, _defaultImage.size.width*VerticalRatio(), _defaultImage.size.height*VerticalRatio());
        }
        button.tag = 100+i;
        [button setBackgroundImage:_defaultImage forState:UIControlStateNormal];
        [button setBackgroundImage:_selectedImage forState:UIControlStateSelected];
        [self addSubview:button];
        
        if (i==_currentPage) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
        
    }

}

@end
