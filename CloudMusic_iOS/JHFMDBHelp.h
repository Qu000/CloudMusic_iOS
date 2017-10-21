//
//  JHFMDBHelp.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"

#define KFMDBName @"myFMDB.sqlite"//数据库(也可以是.db)
#define KTBMusicTable @"MusicTable"//用户信息表
#define documents [NSHomeDirectory() stringByAppendingString:@"/Documents"]
@interface JHFMDBHelp : NSObject{
    FMDatabase *fmdb;
}
/**
 创建数据库
 */
- (void)fmdbCreate;
/**
 创建表
 */
- (void)fmdbTableCreate;
/**
 。。。。
 */
- (void)fmdbExecSql:(NSString *)sql;
/**
 插入数据(name，music，image)
 */
- (void)fmdbInsertData:(NSString *)name music:(NSString *)music image:(NSString *)image trackId:(NSString *)trackId;
/**
 修改数据
 */
//- (void)fmdbUpdateData;
/**
 删除数据(传入name)
 */
- (void)fmdbDeleteData:(NSString *)name;
/**
 查询数据
 */
- (NSMutableArray *)fmdbSelectData;

@end
