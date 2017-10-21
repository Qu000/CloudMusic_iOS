//
//  Common.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "Common.h"
@implementation Common

//拨打电话
+ (void)callPhone:(NSString *)iphoneNum view:(UIView*)view
{
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectZero];
    [view addSubview:web];
    NSString *tel = [NSString stringWithFormat:@"tel://%@",iphoneNum];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    
}
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//数据非空验证
+ (BOOL) dataIsNULL:(NSString *)data{
    data = [data stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([data isEqualToString:@""] || [data length] == 0 ) {
        return YES;
    }
    return NO;
}


//-------------判断登陆
+(BOOL)getLoginStatus{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"myUserInfo.plist"];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    if (dic2) {
        return YES;
    }else{
        return NO;
    }
}
//-------------得到登陆用户个人信息
+(NSDictionary *)getLoginInfo{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"myUserInfo.plist"];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    return dic2;
}
//删除plist文件
+ (BOOL)DeleteSingleFile{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"myUserInfo.plist"];
    
    
    NSError *err = nil;
    
    if (nil == filePath) {
        return NO;
    }
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
    }
    
    return [appFileManager removeItemAtPath:filePath error:&err];
}


//sha加密
+ (NSString *) shaEncrypt:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    base64 = [base64 base64EncodedDataWithOptions:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    output = [output substringToIndex:output.length-1];
    return output;
}

+ (NSString *)updateTimeForData:(NSString * )data {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    CGFloat currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    CGFloat createTime = [data floatValue]/1000;
    // 时间差
    CGFloat time = currentTime - createTime;
    if (time<=0) {
        time = 1;
    }
    //秒转分
    NSInteger minutes = time/60;
    // 秒转小时
    NSInteger hours = time/3600;
    //秒转天数
    NSInteger days = time/3600/24;
    //秒转月
    NSInteger months = time/3600/24/30;
    //秒转年
    NSInteger years = time/3600/24/30/12;
    
    if (minutes==0) {
        return [NSString stringWithFormat:@"%ld秒前",(NSInteger)time];
    }else if (minutes<60) {
        return [NSString stringWithFormat:@"%ld分钟前",minutes];
    }else if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }else{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTime];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MM月dd日"];
        
        return [formatter stringFromDate:date];
    }
//    else if (days < 30) {
//        return [NSString stringWithFormat:@"%ld天前",days];
//    }else if (months < 12) {
//        return [NSString stringWithFormat:@"%ld月前",months];
//    }else{
//        return [NSString stringWithFormat:@"%ld年前",years];
//    }
}

+ (NSString *)stringFromData:(id)data{
    if ([data isEqual:[NSNull null]]||!data) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",data];
    }
}

+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}


#pragma mark === 去掉数字末尾的0
+ (NSString *)deletLastZero:(CGFloat)num leftNum:(NSInteger)leftNum{
    NSString * Present = [NSString stringWithFormat:@"%.1f",num];
    NSMutableString * present = [NSMutableString stringWithFormat:@"%.1f",num];

    if (leftNum==2) {
        Present = [NSString stringWithFormat:@"%.2f",num];
        present = [NSMutableString stringWithFormat:@"%.2f",num];
    }else if (leftNum==3){
        Present = [NSString stringWithFormat:@"%.3f",num];
        present = [NSMutableString stringWithFormat:@"%.3f",num];
    }else if (leftNum==4){
        Present = [NSString stringWithFormat:@"%.4f",num];
        present = [NSMutableString stringWithFormat:@"%.4f",num];
    }else if (leftNum>4){
        NSLog(@"==========================请修改方法");
        return present;
    }
    
    
    if (num==0) {
        present = [[NSMutableString alloc]initWithString:@"0"];
    }else{
        for (NSInteger i = Present.length-1; i>=0; i--) {
            NSString * str = [Present substringWithRange:NSMakeRange(i, 1)];
            if ([str isEqualToString:@"0"]) {
                [present deleteCharactersInRange:NSMakeRange(i, 1)];
            }else if ([str isEqualToString:@"."]){
                [present deleteCharactersInRange:NSMakeRange(i, 1)];
                break;
            }else{
                break;
            }
        }
    }
    return present;
}

+ (UIViewController *)getViewControllerWithStoryboardName:(NSString *)storyboardName Identifier:(NSString *)identifier{
    UIStoryboard * secondstory = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController* page = [secondstory instantiateViewControllerWithIdentifier:identifier];
    return page;
}

@end
