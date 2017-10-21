//
//  JHMusicListViewController.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "BaseViewController.h"

@interface JHMusicListViewController : BaseViewController

/**
 专辑id(214786)用于拼接url,为了拼接请求接口
 */
@property (nonatomic, strong)NSString * ablumld;

/**
 uid用于拼接url,为了拼接下载接口
 */
@property (nonatomic, strong)NSString * uid;
/**
 trackId用于拼接url,为了拼接下载接口
 */
@property (nonatomic, strong)NSString * trackId;

@end
