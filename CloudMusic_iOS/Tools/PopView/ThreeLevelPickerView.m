//
//  ThreeLevelPickerView.m
//  PeopleStreet
//
//  Created by 辰领科技 on 16/3/9.
//  Copyright © 2016年 yuf. All rights reserved.
//

#import "ThreeLevelPickerView.h"

@interface ThreeLevelPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIPickerView * pickerView;
@property(nonatomic,strong)NSMutableArray * titlesArray;
@property(nonatomic,strong)void(^complect)(NSString * str);
@property(nonatomic,strong)NSArray * selectedRows;

@end

@implementation ThreeLevelPickerView
- (instancetype)initWithSelectedAtRows:(NSArray *)rows complect:(void (^)(NSString* str))complect{
    self = [super init];
    if (self) {
        _titlesArray = [NSMutableArray array];
        NSMutableArray * years = [NSMutableArray array];
        for (int i = 1; i<=10000; i++) {
            NSString * year = [NSString stringWithFormat:@"%d年",i];
            [years addObject:year];
        }
        [_titlesArray addObject:years];
        
        NSArray * mouths = @[@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月"];
        [_titlesArray addObject:mouths];
        
        
        NSInteger year = [rows[0] integerValue]+1;
        NSInteger month = [rows[1] integerValue]+1;
        NSInteger day = 0;
        if (month == 2) {
            if((year%4 == 0 && year%100 !=0) ||year%400 ==0) {
                day = 29;
            }else{
                day = 28;
            }
        }else if(month == 1||month==3 ||month==5||month==7||month ==8||month==10||month==12){
            day =31;
        }else{
            day =30;
        }
       
        
        NSMutableArray * days = [NSMutableArray array];
        for (int i = 1; i<=day; i++) {
            NSString * day = [NSString stringWithFormat:@"%d日",i];
            [days addObject:day];
        }
        [_titlesArray addObject:days];
        
        
        _complect = complect;
        _selectedRows = rows;
        
        self.frame = flexibleFrame(CGRectMake(0, 368, 320, 200), NO);
        self.backgroundColor = [UIColor whiteColor];
        _pickerView = [[UIPickerView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 0, 320, 155), NO)];
        _pickerView.backgroundColor = [UIColor clearColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView selectRow:[rows[0] integerValue] inComponent:0 animated:NO];
        [_pickerView selectRow:[rows[1] integerValue] inComponent:1 animated:NO];
        [_pickerView selectRow:[rows[2] integerValue] inComponent:2 animated:NO];
        
        [self addSubview:_pickerView];
        
        
        
        for (int i = 0; i<2; i++) {
            UIView * line  = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 155/3+i*(155/3), 320, 2), NO)];
            line.backgroundColor = [UIColor whiteColor];
            [self addSubview:line];
            for (int j = 0; j<3; j++) {
                UIView * oLine = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(21+105*j, 0, 71, 2), NO)];
                oLine.backgroundColor = kGetColor(208, 10, 13);
                [line addSubview:oLine];
            }
        }
        
        
        
        
        UIView * line = [[UIView alloc]initWithFrame:flexibleFrame(CGRectMake(0, 155, 320, 1), NO)];
        line.backgroundColor = kGetColor(208, 10, 13);
        [self addSubview:line];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = flexibleFrame(CGRectMake(0, 155, 160, 45), NO);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.063 alpha:1.000] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17*VerticalTexeRatio()];
        [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = flexibleFrame(CGRectMake(160, 155, 160, 45), NO);
        Button.backgroundColor = kGetColor(208, 10, 13);
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
    NSString * year = [NSString stringWithFormat:@"%@",_titlesArray[0][[_selectedRows[0]integerValue]]];
    year = [year substringToIndex:year.length-1];
    NSString * mouth = [NSString stringWithFormat:@"%@",_titlesArray[1][[_selectedRows[1]integerValue]]];
    mouth = [mouth substringToIndex:mouth.length-1];
    NSString * day = [NSString stringWithFormat:@"%@",_titlesArray[2][[_selectedRows[2]integerValue]]];
     day = [day substringToIndex:day.length-1];
    NSString * date = [NSString stringWithFormat:@"%@-%@-%@",year,mouth,day];
    
    _complect(date);
    [self hide];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * array = _titlesArray[component];
    return array.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 48*VerticalRatio();
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 320/3*VerticalRatio();
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * title = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(0, 0, 320, 48), NO)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithWhite:0.706 alpha:1.000];
    if (row == [_selectedRows[component]integerValue]) {
        title.textColor = [UIColor blackColor];
    }
    title.font = [UIFont systemFontOfSize:19*VerticalTexeRatio()];
    title.text =  _titlesArray[component][row];
    return title;
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSMutableArray * array = [_selectedRows mutableCopy];
     [array replaceObjectAtIndex:component withObject:@(row)];
    _selectedRows= [array copy];
    
    NSInteger year = [_selectedRows[0] integerValue]+1;
    NSInteger month = [_selectedRows[1] integerValue]+1;
    NSInteger day = 0;
    if (month == 2) {
        if((year%4 == 0 && year%100 !=0) ||year%400 ==0) {
            day = 29;
        }else{
            day = 28;
        }
    }else if(month == 1||month==3 ||month==5||month==7||month ==8||month==10||month==12){
        day =31;
    }else{
        day =30;
    }
    //防止下标越界
    if ([array[2]integerValue]+1 >day) {
        [array replaceObjectAtIndex:2 withObject:@(day-1)];
        _selectedRows= [array copy];
    }
    
   //限制时间
    NSDate * date  = [[NSDate alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];//格式化
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    NSString * string =[formatter stringFromDate:date];
    NSInteger nowYear = [[string substringToIndex:4]integerValue];
    NSInteger nowMonth = [[string substringWithRange:NSMakeRange(5, 2)]integerValue];
    NSInteger  nowDay = [[string substringFromIndex:8]integerValue];
    if (component == 0 && (nowYear - row - 1)>120) {
        [_pickerView selectRow:nowYear-120-1 inComponent:0 animated:YES];
        [array replaceObjectAtIndex:0 withObject:@(nowYear-120-1)];
        _selectedRows= [array copy];
    }else if ([_selectedRows[0]integerValue]+1 >=nowYear){
        [_pickerView selectRow:nowYear-1 inComponent:0 animated:YES];
        [array replaceObjectAtIndex:0 withObject:@(nowYear-1)];
        _selectedRows= [array copy];
        
        if ([_selectedRows[1]integerValue]+1 <=nowMonth && [_selectedRows[2]integerValue]+1 >nowDay) {
            [_pickerView selectRow:nowDay-1 inComponent:2 animated:YES];
            [array replaceObjectAtIndex:2 withObject:@(nowDay-1)];
            _selectedRows= [array copy];
        }else if ([_selectedRows[1]integerValue]+1 >nowMonth && [_selectedRows[2]integerValue]+1 <=nowDay){
            [_pickerView selectRow:nowMonth-1 inComponent:1 animated:YES];
            [array replaceObjectAtIndex:1 withObject:@(nowMonth-1)];
            _selectedRows= [array copy];
        }else if ([_selectedRows[1]integerValue]+1 >nowMonth && [_selectedRows[2]integerValue]+1 >nowDay){
            [_pickerView selectRow:nowDay-1 inComponent:2 animated:YES];
            [array replaceObjectAtIndex:2 withObject:@(nowDay-1)];
            [_pickerView selectRow:nowMonth-1 inComponent:1 animated:YES];
            [array replaceObjectAtIndex:1 withObject:@(nowMonth-1)];
            _selectedRows= [array copy];
        }
        
    }
    NSMutableArray * days = [NSMutableArray array];
    for (int i = 1; i<=day; i++) {
        NSString * day = [NSString stringWithFormat:@"%d日",i];
        [days addObject:day];
    }
    [_titlesArray replaceObjectAtIndex:2 withObject:days];
    
    
    [_pickerView reloadAllComponents];
}




@end
