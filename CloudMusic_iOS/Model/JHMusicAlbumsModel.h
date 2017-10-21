//
//  JHMusicDetailModel.h
//  Cloud_Music_iOS
//
//  Created by qujiahong on 2017/9/14.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMusicAlbumsModel : NSObject
/**
 ret
 */
@property (nonatomic, strong) NSString *ret;

/**
 msg
 */
@property (nonatomic, strong) NSString *msg;

/**
 smallLogo小图
 */
@property (nonatomic, strong) NSString *smallLogo;
/**
 largeLogo大图
 */
@property (nonatomic, strong) NSString *largeLogo;
/**
 title
 */
@property (nonatomic, strong) NSString *nickname;

//--------------------
/**
 albumId
 */
@property (nonatomic, strong) NSString *albumId;
/**
 title
 */
@property (nonatomic, strong) NSString *title;
/**
 头像url
 */
@property (nonatomic, strong) NSString *coverSmall;

/**
 tracks节目数
 */
@property (nonatomic, strong) NSString *tracks;
/**
 updatedAt
 */
@property (nonatomic, strong) NSString *updatedAt;

/**
 finished--null
 */
@property (nonatomic, strong) NSString *finished;

//---------------------
/**
 maxPageId
 */
@property (nonatomic, strong) NSString *maxPageId;
/**
 totalCount
 */
@property (nonatomic, strong) NSString *totalCount;

/**
 简介
 */
@property (nonatomic, strong) NSString *personalSignature;
/**
 pageSize一个页面最多20条数据，多了则需要刷新
 */
@property (nonatomic, strong) NSString *pageSize;
/**
 pageId
 */
@property (nonatomic, strong) NSString *pageId;

@end
