//
//  LQRequestApi.h
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
typedef enum
{
    
    L_DJMusicHomeUrl,            //音乐盒主页
    L_DJMusicAlbumsUrl,          //音乐盒专辑
    L_DJMusicPlayListUrl,        //音乐列表
    
} LQRequestType;

#pragma  mark =============================================
@protocol LQRequestApiDelegate ;

@protocol LQRequestApiDelegate <NSObject>

@optional

- (void)fetchDatabaseFinished:(NSMutableDictionary*)database withTag:(NSInteger )tag;

- (void)fetchDatabaseFailed:(NSError *)error message:(NSString *)message;

@end

@interface LQRequestApi : NSObject

@property (weak, nonatomic) id<LQRequestApiDelegate> delegate;


+(LQRequestApi *)sharedInstance;


/*   所有接口 调用此方法
 *   dic 传递参数
 *   interface_Path 接口地址
 *   type  POST  GET
 tag 标记
 */
-(void)requestOperationWithDic:(NSMutableDictionary  *)dic  withPath:(NSString *)interface_Path  withHttpType:(NSString *)type  withTag:(NSInteger )tag;
@end
