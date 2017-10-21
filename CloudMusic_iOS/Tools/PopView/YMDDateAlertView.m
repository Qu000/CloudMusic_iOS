//
//  LJFPickerAlterView.m
//  DeepBreath
//
//  Created by rimi on 15/9/21.
//  Copyright (c) 2015年 LiuJianFeng. All rights reserved.
//

#import "YMDDateAlertView.h"

@interface YMDDateAlertView ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)NSString * sureButtonTitle;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,copy)NSString *alertTitle;
@property(nonatomic,strong)UIDatePicker *datePick;
@property(nonatomic,assign)BOOL limitDate;
@property(nonatomic,assign)NSInteger dateType;
@property(nonatomic,strong)void(^complect)(NSString * str);

@end

@implementation YMDDateAlertView
- (instancetype)initWithTitle:(NSString *)title
              sureButtonTitle:(NSString *)sureButtonTitle
                    limitDate:(BOOL)limitDate
                     dateType:(NSInteger)dateType
                     complect:(void(^)(NSString *str))complect
{
    self = [super init];
    if (self){
        self.frame = flexibleFrame(CGRectMake(15, 180, 290, 210), NO);
        self.layer.cornerRadius = 4*VerticalRatio();
        _limitDate = limitDate;
        _alertTitle = title;
        _dateType = dateType;
        _sureButtonTitle = sureButtonTitle;
        _complect = complect;
        [self initNewUserInterface];
    }
    return self;
}

-(void)initNewUserInterface{
    [self addSubview:self.datePick];
    [self addSubview:self.titleLabel];
    [self addSubview:self.sureButton];
    [self addSubview:self.closeButton];
}

#pragma mark----private methods
-(void)handle_SureButton{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];//格式化
    if (_dateType == 1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
    }else if(_dateType == 0){
        [formatter setDateFormat:@"yyyy-MM-dd"];

    }else if(_dateType == 2){
        [formatter setDateFormat:@"yyyy-MM-dd HH:MM"];
        
    }

    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    NSString * string =[formatter stringFromDate:self.datePick.date];
    _complect(string);
    [self handle_closeButton];
}

-(void)handle_closeButton{
    [self hide];
}

#pragma mark ---- getter方法
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:flexibleFrame(CGRectMake(0, 10, 290, 15), NO)];
        _titleLabel.font = [UIFont systemFontOfSize:15*VerticalTexeRatio()];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = self.alertTitle;
    }
    return _titleLabel;
}

-(UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame     = flexibleFrame(CGRectMake(210, 175, 60, 25), NO);
            button.backgroundColor = [UIColor colorWithRed:0.863 green:0.537 blue:0.075 alpha:1.000];
            button.titleLabel.font = [UIFont systemFontOfSize:12*VerticalTexeRatio()];
            button.layer.cornerRadius = 3*VerticalRatio();
            [button setTitle:_sureButtonTitle forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handle_SureButton) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _sureButton;
}

-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame     = flexibleFrame(CGRectMake(20, 175, 60, 25), NO);
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor colorWithRed:0.631 green:0.627 blue:0.631 alpha:1.000].CGColor;
            button.titleLabel.font = [UIFont systemFontOfSize:12*VerticalTexeRatio()];
            button.layer.cornerRadius = 3*VerticalRatio();
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.631 green:0.627 blue:0.631 alpha:1.000] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handle_closeButton) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _closeButton;
}

-(UIDatePicker *)datePick{
    if (!_datePick) {
        _datePick = ({
        
            UIDatePicker *datePick  = [[UIDatePicker alloc]init];
            datePick.frame = flexibleFrame(CGRectMake(5, 20, 280, 160), NO);
            if (_limitDate) {
                NSDate * locaDate = [NSDate date];
                datePick.minimumDate = locaDate;
            }
            if (_dateType == 1) {
                 datePick.datePickerMode = UIDatePickerModeDateAndTime;
            }else if(_dateType == 0){
                datePick.datePickerMode = UIDatePickerModeDate;
            }
           
            datePick;
        });
        
    }
    return _datePick;
}





@end
