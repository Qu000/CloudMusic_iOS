//
//  JHMusicDownloadTableViewCell.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/26.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicDownloadTableViewCell.h"

@implementation JHMusicDownloadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adaptiveViewLayout:self];
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


- (IBAction)clickDeleteBtn:(id)sender {
    _deleteBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
