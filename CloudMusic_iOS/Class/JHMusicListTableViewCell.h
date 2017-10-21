//
//  JHMusicListTableViewCell.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMusicListModel.h"
@interface JHMusicListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *musicTimeLab;

@property (nonatomic, strong) NSString * albumId;
@property (nonatomic, strong) NSString * trackId;

@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property(nonatomic,copy)void(^downloadBlock)();
/**
 从模型中取出音乐信息
 */
-(void)setValueFromModel:(JHMusicListModel *)model;
@end
