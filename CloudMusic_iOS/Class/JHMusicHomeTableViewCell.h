//
//  JHMusicHomeTableViewCell.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMusicHomeModel.h"
@interface JHMusicHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *albumsLab;
/**
 从模型中取出音乐信息
 */
-(void)setValueFromModel:(JHMusicHomeModel *)model;
@end
