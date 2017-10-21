//
//  JHMusicAlbumsTableViewCell.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicAlbumsTableViewCell.h"

@implementation JHMusicAlbumsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adaptiveViewLayout:self];
}
-(void)setValueFromModel:(JHMusicAlbumsModel *)model{
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"noImage"]];
    _titleStr = model.nickname;
    _titleLab.text = model.title;
    _showsLab.text = [NSString stringWithFormat:@"节目数 %@",model.tracks];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
