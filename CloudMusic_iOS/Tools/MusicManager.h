//
//  MusicManager.h
//  Cloud_Music_iOS
//
//  Created by qujiahong on 2017/9/14.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicManager : NSObject

/**
 音乐数据源
 */
@property (nonatomic, strong) NSMutableArray *musicArray;

/**
 下标
 */
@property (nonatomic, assign) NSInteger index;
/**
 播放状态
 */
@property (nonatomic, assign) BOOL isPlay;
/**
 音乐播放器(网络)
 */
@property (nonatomic, strong) AVPlayer *player;



/**
 音乐播放单例
 */
+ (instancetype)shareInfo;

/**
 播放或暂停
 */
- (void)playAndPause;
/**
 播放上一曲
 */
- (void)playPrevious;
/**
 播放下一曲
 */
- (void)playNext;
/**
 更换网络播放歌曲
 */
- (void)replaceItemWithUrlString:(NSString *)urlString;
/**
 更换本地播放歌曲
 */
- (void)replaceItemWithPathString:(NSString *)pathString;
/**
 播放音量
 */
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;
/**
 播放进度条
 */
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat;

@end
