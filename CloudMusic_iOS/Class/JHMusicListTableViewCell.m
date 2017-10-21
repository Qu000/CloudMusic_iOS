//
//  JHMusicListTableViewCell.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicListTableViewCell.h"

@implementation JHMusicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adaptiveViewLayout:self];
}

-(void)setValueFromModel:(JHMusicListModel *)model{
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"noImage"]];
    _titleLab.text = model.title;
    _playTimeLab.text = model.playtimes;
    _createTimeLab.text = [[self timeChangeValue:model.createdAt]substringToIndex:10];
    _musicTimeLab.text =
    [self timeChangeSToM: model.duration];
    _albumId = model.albumId;
  
}

#pragma mark - 调整自适应布局
- (void)adaptiveViewLayout:(UIView *)viewLayout {
    for (UIView *view in viewLayout.subviews) {
        view.frame = flexibleFrame(view.frame, NO);
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *viewField = (UITextField *)view;
            CGFloat fontSize = viewField.font.pointSize;
            viewField.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
        }else if ([view isKindOfClass:[UILabel class]]){
            UILabel *viewLabel = (UILabel *)view;
            CGFloat fontSize = viewLabel.font.pointSize;
            viewLabel.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
        }else if ([view isKindOfClass:[UIButton class]]){
            UIButton *viewButton = (UIButton *)view;
            CGFloat fontSize = viewButton.titleLabel.font.pointSize;
            viewButton.titleLabel.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
        }
        UIView *vv =view;
        for (UIView *view in vv.subviews) {
            view.frame = flexibleFrame(view.frame, NO);
            if ([view isKindOfClass:[UITextField class]]) {
                UITextField *viewField = (UITextField *)view;
                CGFloat fontSize = viewField.font.pointSize;
                viewField.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
            }else if ([view isKindOfClass:[UILabel class]]){
                UILabel *viewLabel = (UILabel *)view;
                CGFloat fontSize = viewLabel.font.pointSize;
                viewLabel.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
            }else if ([view isKindOfClass:[UIButton class]]){
                UIButton *viewButton = (UIButton *)view;
                CGFloat fontSize = viewButton.titleLabel.font.pointSize;
                viewButton.titleLabel.font = [UIFont systemFontOfSize:fontSize*VerticalTexeRatio()];
            }
        }
    }
}


- (IBAction)clickDownloadBtn:(id)sender {
    _downloadBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark--时间戳（还有问题！需要改动！！！！）
-(NSString *)timeChangeValue:(NSString *)string{
    NSString *timeStr = [self stringFromData:string];
    NSTimeInterval second = timeStr.longLongValue / 1000.0; // 时间戳 ->
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:SS";
    NSString * theTime = [formatter stringFromDate:date];
    return theTime;
}
-(NSString *)stringFromData:(id)data{
    if ([data isEqual:[NSNull null]]||!data) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",data];
    }
}

-(NSString *)timeChangeSToM:(NSString *)string{
    NSString *timeStr = [self stringFromData:string];
    float floatTime = [timeStr floatValue] / 60.0;
    NSString *time = [NSString stringWithFormat:@"%.2f",floatTime];
    NSArray *array = [time componentsSeparatedByString:@"."]; //从字符中分隔成2个元素的数组
    
    NSInteger intMTime = [array[0] integerValue];
    NSInteger intSTime = [array[1] integerValue];
    if (intSTime>=60) {
        intSTime = intSTime-60;
        intMTime++;
    }
    
    NSString *mTimeStr = [NSString stringWithFormat:@"%ld",(long)intMTime];
    NSString *sTimeStr = [NSString stringWithFormat:@"%ld",(long)intSTime];
    if (intSTime<10) {
        sTimeStr = [NSString stringWithFormat:@"0%ld",(long)intSTime];
    }
    
    NSString *theTime = [NSString stringWithFormat:@"%@:%@",mTimeStr,sTimeStr];
    return theTime;
}



@end
