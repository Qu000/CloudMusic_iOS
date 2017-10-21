//
//  MusicManager.m
//  Cloud_Music_iOS
//
//  Created by qujiahong on 2017/9/14.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "MusicManager.h"


static MusicManager *_musicManager = nil;

@implementation MusicManager

+ (instancetype)shareInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _musicManager = [[MusicManager alloc] init];
    });
    return _musicManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _player = [[AVPlayer alloc] init];
    }
    return self;
}

// 播放
- (void)playerPlay
{
    [_player play];
    _isPlay = YES;
}
- (void)playerPause
{
    [_player pause];
    _isPlay = NO;
}

- (void)playAndPause
{
    if (self.isPlay) {
        [self playerPause];
    }else{
        [self playerPlay];
    }
}

- (void)playPrevious
{
    if (self.index == 0) {
        self.index = self.musicArray.count - 1;
    }else{
        self.index--;
    }
}

- (void)playNext
{
    if (self.index == self.musicArray.count - 1) {
        self.index = 0;
    }else{
        self.index++;
    }
}


- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat
{
    self.player.volume = volumeFloat;
}

- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat
{
    [self.player seekToTime:CMTimeMakeWithSeconds(progressFloat, 1) completionHandler:^(BOOL finished) {
        [self playerPlay];
    }];
}

- (void)replaceItemWithUrlString:(NSString *)urlString
{
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self playerPlay];

}
- (void)replaceItemWithPathString:(NSString *)pathString
{

    NSURL *urlP = [NSURL fileURLWithPath:pathString];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:urlP];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self playerPlay];
}




@end
