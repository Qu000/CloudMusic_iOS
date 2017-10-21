//
//  JHMusicAlbumsTableViewCell.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMusicAlbumsModel.h"
@interface JHMusicAlbumsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *showsLab;
/**
 title
 */
@property (nonatomic, strong)NSString * titleStr;
/**
 专辑ID
 */
@property (nonatomic, strong)NSString * albumId;
/**
 从模型中取出音乐信息
 */
-(void)setValueFromModel:(JHMusicAlbumsModel *)model;
@end
