//
//  JHMusicModel.h
//  Cloud_Music_iOS
//
//  Created by qujiahong on 2017/9/14.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMusicHomeModel : NSObject

/**
 uid（需要转为字符串，否则就用NSUInteger）
 */
@property (nonatomic, strong) NSString *uid;
/**
 主标题
 */
@property (nonatomic, strong) NSString *nickname;
/**
 图片logo
 */
@property (nonatomic, strong) NSString *mediumLogo;
/**
 描述信息
 */
@property (nonatomic, strong) NSString *personDescribe;
/**
 专辑数（需要转为字符串，否则就用NSUInteger）
 */
@property (nonatomic, strong) NSString *albums;


@end
