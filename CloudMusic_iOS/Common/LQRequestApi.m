//
//  LQRequestApi.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "LQRequestApi.h"
#import "Interface.h"
@implementation LQRequestApi
@synthesize  delegate;


// this is good
+ (LQRequestApi *)sharedInstance
{
    static LQRequestApi *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LQRequestApi alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}



//-(void)requestOperationWithDic:(NSMutableDictionary  *)dic  withPath:(NSString *)interface_Path  withHttpType:(NSString *)type  withTag:(NSInteger )tag{
//    
//    NSString * urlStr = [NSString stringWithFormat:@"%@%@",IP_Address,interface_Path];
//    if (![urlStr containsString:@"http://"]&&![urlStr containsString:@"https://"]) {
//        urlStr = [NSString stringWithFormat:@"http://%@%@",IP_Address,interface_Path];
//    }
//    
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 20; //默认网络请求时间
//    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //申明返回的结果是json类型
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
//    if ([type isEqualToString:@"GET"]) {
//        [manager GET:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            if ([delegate  respondsToSelector:@selector(fetchDatabaseFinished:withTag:)]) {
//                [delegate fetchDatabaseFinished:responseObject withTag:tag];
//            }
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            if ([delegate  respondsToSelector:@selector(fetchDatabaseFailed:message:)]) {
//                
//                [delegate  fetchDatabaseFailed:error message:@""];
//            }
//        }];
//    }
//    
//    if ([type isEqualToString:@"POST"]) {
//        [manager POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            if ([delegate  respondsToSelector:@selector(fetchDatabaseFinished:withTag:)]) {
//                [delegate fetchDatabaseFinished:responseObject withTag:tag];
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            if ([delegate  respondsToSelector:@selector(fetchDatabaseFailed:message:)]) {
//                [delegate  fetchDatabaseFailed:error message:@""];
//            }
//        }];
//    }
//    
//}
@end
