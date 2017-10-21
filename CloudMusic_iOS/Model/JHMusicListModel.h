//
//  JHPlayListModel.h
//  Cloud_Music_iOS
//
//  Created by qujiahong on 2017/9/15.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMusicListModel : NSObject

/**
 ret
 */
@property (nonatomic, strong) NSString *ret;
/**
 msg
 */
@property (nonatomic, strong) NSString *msg;

/**
 album字典
 */
@property (nonatomic, strong) NSMutableDictionary *album;
/**
 intro简介
 */
@property (nonatomic, strong) NSMutableDictionary *intro;


/**
 title
 */
@property (nonatomic, strong) NSString *title;

/**
 trackId
 */
@property (nonatomic, strong) NSString *trackId;

/**
 coverSmall
 */
@property (nonatomic, strong) NSString *coverSmall;
/**
 coverLarge
 */
@property (nonatomic, strong) NSString *coverLarge;
/**
 播放次数
 */
@property (nonatomic, strong) NSString *playtimes;

/**
 playUrl32
 */
@property (nonatomic, strong) NSString *playUrl32;

/**
 playUrl64
 */
@property (nonatomic, strong) NSString *playUrl64;
/**
 albumId
 */
@property (nonatomic, strong) NSString *albumId;

/**
 albumUid
 */
@property (nonatomic, strong) NSString *albumUid;


/**
 duration歌曲时长
 */
@property (nonatomic, strong) NSString *duration;
/**
 createdAt(时间戳)
 */
@property (nonatomic, strong) NSString *createdAt;

/**
 updatedAt(时间戳)
 */
@property (nonatomic, strong) NSString *updatedAt;
@end
