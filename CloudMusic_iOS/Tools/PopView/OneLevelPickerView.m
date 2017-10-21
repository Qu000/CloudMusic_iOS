//
//  OneLevelPickerView.m
//  PeopleStreet
//
//  Created by 辰领科技 on 16/3/9.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "OneLevelPickerView.h"

@interface OneLevelPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIPickerView * pickerView;
@property(nonatomic,strong)NSArray * titlesArray;
@property(nonatomic,strong)void(^complect)(NSString * str);
@property(nonatomic,assign)NSInteger selectedRow;

@end

@implementation OneLevelPickerView

- (instancetype)initWithTitles:(NSArray *)titles selectedAtRow:(NSInteger)row complect:(void (^)(NSString* str))complect{
    self = [super init];
    if (self) {
        _titlesArray = titles;
        _complect = complect;
        _selectedRow = row;
        
        self.frame = flexibleFrame(CGRectMake(0, 368, 320, 200), YES);
        self.backgroundColor = [UIColor whiteColor];
        _pickerView = [[UIPickerView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 0, 320, 155), YES)];
        _pickerView.backgroundColor = [UIColor clearColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView selectRow:row inComponent:0 animated:NO];
        [self addSubview:_pickerView];
        
        UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 155, 320, 1), YES)];
        line.backgroundColor = [UIColor colorWithWhite:0.925 alpha:1.000];
        [self addSubview:line];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = flexibleFrame(CGRectMake(0, 156, 160, 44), YES);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.063 alpha:1.000] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17*VerticalTexeRatio()];
        [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = flexibleFrame(CGRectMake(160, 155, 160, 45), YES);
        Button.backgroundColor = [UIColor colorWithRed:1.000 green:0.647 blue:0.035 alpha:1.000];
        [Button setTitle:@"确定" forState:UIControlStateNormal];
        [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        Button.titleLabel.font = [UIFont systemFontOfSize:17*VerticalTexeRatio()];
        [Button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self addSubview:Button];
        
    }
    return self;
}

- (void)cancle{
    [self hide];
}

- (void)sure{
    _complect(_titlesArray[_selectedRow]);
    [self hide];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _titlesArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 48*VerticalRatio();
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 320*VerticalRatio();
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(0, 0, 320, 48), YES)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithWhite:0.706 alpha:1.000];
    if (row == _selectedRow) {
        title.textColor = [UIColor colorWithRed:1.000 green:0.647 blue:0.035 alpha:1.000];
    }
    title.font = [UIFont systemFontOfSize:19*VerticalTexeRatio()];
    title.text =  _titlesArray[row];
    return title;
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedRow= row;
    [_pickerView reloadAllComponents];
}

@end
