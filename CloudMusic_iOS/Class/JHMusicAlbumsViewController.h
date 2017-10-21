//
//  JHMusicAlbumsViewController.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "BaseViewController.h"

@interface JHMusicAlbumsViewController : BaseViewController
/**
 uid(3741727)用于拼接url
 */
@property (nonatomic, strong)NSString * uid;
/**
 pageId(1)用于拼接url
 */
@property (nonatomic, strong)NSString * pageId;
/**
 专辑id(214786)用于拼接url,为了拼接请求接口
 */
@property (nonatomic, strong)NSString * ablumld;
@end
