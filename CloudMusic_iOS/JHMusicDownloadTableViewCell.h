//
//  JHMusicDownloadTableViewCell.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/26.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JHMusicDownloadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLab;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property(nonatomic,copy)void(^deleteBlock)();

/**
 从模型中取出音乐信息
 */
@end
