//
//  JHMusicPlayViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicPlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface JHMusicPlayViewController ()
@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *cdImage;
@property (weak, nonatomic) IBOutlet UIImageView *coverLargeImage;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *playAndPause;
@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, assign) NSUInteger index;

@end

@implementation JHMusicPlayViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}
//进入后台播放时，暂停定时器
- (void)viewWillDisappear:(BOOL)animated{
    [_timer invalidate];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
#pragma mark----保存上一次的index值
- (void)saveIndex{
    NSString *indexStr = [NSString stringWithFormat:@"%lu",(unsigned long)_index];

    [[NSUserDefaults standardUserDefaults]setObject:indexStr forKey:JHMusicIndex];
    [[NSUserDefaults standardUserDefaults] synchronize];//写入磁盘

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewLayout];
    [self setMySlider:_progressSlider];
    
    NSInteger index = [MusicManager shareInfo].index;
    NSString *myIndexStr=[[NSUserDefaults standardUserDefaults] objectForKey:JHMusicIndex];
    NSUInteger myIndex = [myIndexStr intValue];
    if (index==myIndex) {
        if (index==0) {//特殊：第一次播放时，index=0，需要开始播放
            //bug：重复点击播放第一首歌，会一直重新播放，怎么破

            [self reloadDataWithIndex:index];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            [self configNowPlayingInfoCenter:index];
            _index = index;
            [self saveIndex];
        }
        else{
            MyLog(@"这是同一首歌--myIndex=%lu",(unsigned long)myIndex);
            
            // 图片 标题
            JHMusicListModel *model = [MusicManager shareInfo].musicArray[index];
            self.nameLab.text = model.title;
            [self.coverLargeImage sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:@"noImage"]];
            //按钮调整为正在播放
            [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            //记录进度条的值，下一次再进来时，就直接将进度条拉到之前播放的位置
            [MusicManager shareInfo].isPlay = YES;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

            //维护index=0
        }
        
        
        return;
        
    }else{
        [self reloadDataWithIndex:index];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self configNowPlayingInfoCenter:index];
        _index = index;
        [self saveIndex];
    }
    
    

  
//        [self reloadDataWithIndex:index];
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//        [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
//        [self configNowPlayingInfoCenter:index];
    

}
-(void)initViewLayout{
    [self adaptiveViewLayout:self.view];
    [self adaptiveViewLayout:self.NavView];
    [self adaptiveViewLayout:self.centerView];
    [self adaptiveViewLayout:self.bottomView];
    self.coverLargeImage.layer.masksToBounds = YES;
    self.coverLargeImage.layer.cornerRadius = self.coverLargeImage.frame.size.width/2;
}

- (IBAction)clickBack:(id)sender {
    [self backHandel];
}



/**
 更新music信息
 */
- (void)reloadDataWithIndex:(NSInteger)index
{
   
    // 寻找model
    JHMusicListModel *model = [MusicManager shareInfo].musicArray[index];
    //本地=1
    if (_playIndex == 1) {
        // 改变图片 标题 音频
        self.nameLab.text = _name;
        UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:_image];
        [_coverLargeImage setImage:imgFromUrl];
        [[MusicManager shareInfo] replaceItemWithPathString:_path];
       
        
    }
    //网络=0
    else{
        // 改变图片 标题 音频
        self.nameLab.text = model.title;
        [self.coverLargeImage sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:@"noImage"]];
        // 修改播放歌曲
        [[MusicManager shareInfo] replaceItemWithUrlString:model.playUrl32];
    }
    

}
/**
 定时器相关
 */
- (void)timerAction{
    if ([MusicManager shareInfo].player.currentTime.timescale == 0 || [MusicManager shareInfo].player.currentItem.duration.timescale == 0) {
        return;
    }
    // 获得音乐总时长
    long long int totalTime = [MusicManager shareInfo].player.currentItem.duration.value / [MusicManager shareInfo].player.currentItem.duration.timescale;
    // 获得当前时间
    long long int currentTime = [MusicManager shareInfo].player.currentTime.value / [MusicManager shareInfo].player.currentTime.timescale;
    //    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02lld:%02lld", currentTime / 60, currentTime % 60];
    //    self.totalLabel.text = [NSString stringWithFormat:@"%02lld:%02lld", totalTime / 60, totalTime % 60];
    self.progressSlider.maximumValue = totalTime;
    self.progressSlider.minimumValue = 0;
    self.progressSlider.value = currentTime;
    
    if (self.progressSlider.value == totalTime) {
        [[MusicManager shareInfo] playNext];
        [self reloadDataWithIndex:[MusicManager shareInfo].index];
    }
    if ([MusicManager shareInfo].isPlay) {
        [UIView beginAnimations:@"rzoration" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.cdImage.transform = CGAffineTransformRotate(self.cdImage.transform, 0.02);
        [UIView commitAnimations];
        [UIView beginAnimations:@"rzoration" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.coverLargeImage.transform = CGAffineTransformRotate(self.coverLargeImage.transform, 0.02);
        [UIView commitAnimations];
    }
}

/**
 播放进度
 */
- (IBAction)progressAction:(id)sender {
    [[MusicManager shareInfo] playerProgressWithProgressFloat:((UISlider*)sender).value];
    [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
    
}
/**
 上一曲
 */
- (IBAction)previousAction:(id)sender {
    [_playAndPause setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [[MusicManager shareInfo] playPrevious];
    [self reloadDataWithIndex:[MusicManager shareInfo].index];
}
/**
 下一曲
 */
- (IBAction)nextAction:(id)sender {
    [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [[MusicManager shareInfo] playNext];
    [self reloadDataWithIndex:[MusicManager shareInfo].index];
}
- (IBAction)playAction:(id)sender {
    if ([MusicManager shareInfo].isPlay == YES) {
        [_playAndPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }else{
        
        [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    [[MusicManager shareInfo] playAndPause];
    
    
}



#pragma mark---slider属性设置
-(void)setMySlider:(UISlider *)slider{
    slider.minimumTrackTintColor = JHColor(152, 232, 90, 1);//左中轴颜色
    slider.maximumTrackTintColor = JHColor(200, 202, 199, 1);//右中轴颜色
    [slider setThumbImage:[UIImage imageNamed:@"CD-2"] forState:UIControlStateNormal];//
    slider.value = 0;
}




#pragma mark 远程控制事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if(event.type==UIEventTypeRemoteControl){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [MusicManager shareInfo].isPlay = YES;
                [[MusicManager shareInfo] playAndPause];
                [_playAndPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];//远程控制后，改变app播放按钮状态
                MyLog(@"切换播放按钮");
                break;

            case UIEventSubtypeRemoteControlPause:
                [MusicManager shareInfo].isPlay = NO;
                [[MusicManager shareInfo] playAndPause];
                [_playAndPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
                MyLog(@"切换暂停按钮");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [[MusicManager shareInfo] playNext];
                [self reloadDataWithIndex:[MusicManager shareInfo].index];
                [self configNowPlayingInfoCenter:[MusicManager shareInfo].index];
                MyLog(@"播放下一曲");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [[MusicManager shareInfo] playPrevious];
                [self reloadDataWithIndex:[MusicManager shareInfo].index];
                [self configNowPlayingInfoCenter:[MusicManager shareInfo].index];
                MyLog(@"播放上一曲");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                MyLog(@"Begin seek forward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                MyLog(@"End seek forward...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                MyLog(@"Begin seek backward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                MyLog(@"End seek backward...");
                break;
            default:
                break;
        }

    }
}
#pragma mark 锁屏下的歌曲信息(图片待完成)
-(void)configNowPlayingInfoCenter:(NSInteger)index{
    JHMusicListModel *model = [MusicManager shareInfo].musicArray[index];
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:model.title forKey:MPMediaItemPropertyTitle];//歌名
        [dict setObject:@"singer" forKey:MPMediaItemPropertyArtist];//歌手
        [dict setObject:@"album" forKey:MPMediaItemPropertyAlbumTitle];//专辑名
        
        UIImage *image = [UIImage imageNamed:@"noImage"];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];//专辑封面
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
