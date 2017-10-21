//
//  JHFMDBHelp.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHFMDBHelp.h"

@implementation JHFMDBHelp

#pragma amrk - fmdb创建数据库
- (void)fmdbCreate{
    NSString *database_path = [documents stringByAppendingPathComponent:KFMDBName];
    //数据库创建
    fmdb = [FMDatabase databaseWithPath:database_path];
//    [[NSUserDefaults standardUserDefaults]setObject:fmdb forKey:JHMusicFMDB];
//    [[NSUserDefaults standardUserDefaults] synchronize];//写入磁盘
    MyLog(@"%@",database_path);
}
#pragma amrk - fmdb创建表
- (void)fmdbTableCreate{
//    [fmdb open];
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, music TEXT, image TEXT, trackId TEXT);",KTBMusicTable];
    [self fmdbExecSql:sql];
//    [fmdb close];
}
#pragma mark - fmdbUpdate
- (void)fmdbExecSql:(NSString *)sql{
    if ([fmdb open]) {
        
        /*
         * 只要sql不是SELECT命令的都视为更新操作(使用executeUpdate方法)。就包括 CREAT,UPDATE,INSERT,ALTER,BEGIN,COMMIT,DETACH,DELETE,DROP,END,EXPLAIN,VACUUM,REPLACE等等。SELECT命令的话，使用executeQuery方法。
         * 执行更新返回一个BOOL值。YES表示 执行成功，否则表示有错误。你可以调用 -lastErrorMessage 和 -lastErrorCode方法来得到更多信息。
         */
        if ([fmdb executeUpdate:sql]) {
            NSLog(@"%@%@%@",@"fmdb操作表",KTBMusicTable,@"成功！");
        }else{
            NSLog(@"%@%@%@ lastErrorMessage：%@，lastErrorCode：%d",@"fmdb创建",KTBMusicTable,@"失败！",fmdb.lastErrorMessage,fmdb.lastErrorCode);
        }
    }else{
        NSLog(@"%@",@"fmdb数据库打开失败！");
    }
}
#pragma mark - fmdb插入数据
- (void)fmdbInsertData:(NSString *)name music:(NSString *)music image:(NSString *)image trackId:(NSString *)trackId{
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO '%@' ('name', 'music', 'image', 'trackId') VALUES ('%@', '%@', '%@', '%@');",KTBMusicTable, name, music, image, trackId];
    [self fmdbExecSql:sql];
}
#pragma mark - fmdb修改数据(貌似不需要修改哒)
//- (void)fmdbUpdateData:(NSString *)name music:(NSString *)music image:(NSString *)image
//{
//    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ set age='%@' WHERE name='张三';",KTBMusicTable,@"2333"];
//    [self fmdbExecSql:sql];
//}
#pragma mark - fmdb删除数据
- (void)fmdbDeleteData:(NSString *)name{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE name='%@';",KTBMusicTable,name];
    [self fmdbExecSql:sql];
}


#pragma mark - fmdbSelectData
- (NSMutableArray *)fmdbSelectData{
    NSMutableArray *fmdbArray = [[NSMutableArray alloc] init];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@",KTBMusicTable];
    //根据条件查询
    FMResultSet *resultSet = [fmdb executeQuery:sqlQuery];
    //遍历结果集合
    while ([resultSet  next]){
         NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        /*每次执行while循环的时候，都是一个新的记录被取出，所以我们需要一个新的字典来盛放新的记录，
         所以每次进while循环的时候都需要构建一个新的字典对象。*/
        NSString *name = [resultSet
                          objectForColumnName:@"name"];
        NSString *music = [resultSet objectForColumnName:@"music"];
        NSString *image = [resultSet objectForColumnName:@"image"];
        
        
        [dic setValue:name forKey:@"name"];
        [dic setValue:music forKey:@"music"];
        [dic setValue:image forKey:@"image"];
        [fmdbArray addObject:dic];
        
//        NSLog(@"%@: name:%@ music:%@ image:%@ ",KTBMusicTable,name,music,image);
    }
    /*
     * fmdb封装过后的读取数据是要比原生的sqlite3方便了很多哈
     */
    return fmdbArray;
}
@end
