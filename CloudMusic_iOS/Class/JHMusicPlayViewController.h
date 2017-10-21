//
//  JHMusicPlayViewController.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "BaseViewController.h"
#import "JHMusicListModel.h"
@interface JHMusicPlayViewController : BaseViewController
@property (nonatomic, strong) JHMusicListModel *model;
/**
 trackId
 */
@property (nonatomic, strong) NSString * trackId;
/**
 name
 */
@property (nonatomic, strong) NSString * name;
/**
 image
 */
@property (nonatomic, strong) NSString * image;
/**
 path
 */
@property (nonatomic, strong) NSString * path;
/**
 判断是哪个界面的跳转，播放本地or网络
 */
@property (nonatomic, assign) NSUInteger playIndex;
@end
