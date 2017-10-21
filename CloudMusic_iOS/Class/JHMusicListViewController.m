//
//  JHMusicListViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicListViewController.h"
#import "JHMusicListTableViewCell.h"
#import "JHMusicPlayViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "JHFMDBHelp.h"
static NSString *CellIdentifier = @"JHMusicListTableViewCell";
@interface JHMusicListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTask;
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTaskImageS;
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTaskImageL;

}
@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *remindsView;
@property (weak, nonatomic) IBOutlet UILabel *remindsLab;


@property (nonatomic, strong) NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIImageView *largeImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *showsNumberLab;
@property (nonatomic, strong) NSMutableDictionary * topDataDic;
//订阅
@property (weak, nonatomic) IBOutlet UIButton *subscribeBtn;

//排序
@property (weak, nonatomic) IBOutlet UIButton *sequencingBtn;

@property (nonatomic, strong) NSString * downloadUrl;
@property (nonatomic, strong) NSString * coverSmallUrl;
@property (nonatomic, strong) NSString * albumCoverSmallUrl;
@property (nonatomic, strong) NSMutableArray * urlArr;
@property (nonatomic, strong) NSString * musicName;

@property (nonatomic, assign) NSUInteger successTag;

@property (nonatomic, assign) NSUInteger buttonTag;
/**
 我的本地音乐path
 */
@property (nonatomic, strong) NSMutableArray * myMusicPathArr;
@property (nonatomic, strong) NSMutableDictionary * myMusicPathDic;

@property (nonatomic, copy) NSString * myPath;


@property (nonatomic, strong) JHFMDBHelp * fmdbHelp;
@end

@implementation JHMusicListViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)urlArr
{
    if (!_urlArr) {
        _urlArr = [[NSMutableArray alloc] init];
    }
    return _urlArr;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    JHFMDBHelp * fmdb = [[JHFMDBHelp alloc]init];
    [fmdb fmdbCreate];
    [fmdb fmdbTableCreate];
    _fmdbHelp = fmdb;
    _topDataDic = [[NSMutableDictionary alloc] init];
    _myMusicPathDic = [[NSMutableDictionary alloc] init];
    _myMusicPathArr = [[NSMutableArray alloc] init];
    [self initViewLayout];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDJMusicList)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    _buttonTag = 0;

    
    
}
-(void)initViewLayout{
    [self adaptiveViewLayout:self.view];
    [self adaptiveViewLayout:self.NavView];
    [self adaptiveViewLayout:self.tableView];
    [self adaptiveViewLayout:self.remindsView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    self.remindsView.hidden=YES;
    
}

- (IBAction)clickBack:(id)sender {
    [self backHandel];
}
#pragma mark--订阅
- (IBAction)clickSubscribeBtn:(id)sender {
}
#pragma mark--简介
- (IBAction)clickProfileBtn:(id)sender {
    self.remindsView.hidden = NO;
}
#pragma mark--排序
- (IBAction)clickSequencingBtn:(id)sender {
    if (_buttonTag==0) {
        //此时为正序，点击后，发送倒序的请求
        [self getDJMusicList2];
        _buttonTag = 1;
    }else{
        //此时为倒序，点击后，发送正序的请求
        [self getDJMusicList];
        _buttonTag = 0;
    }
    [self setSequencingBtnStatus];
}

-(void)setSequencingBtnStatus{
    if (_buttonTag==0) {
        [_sequencingBtn setTitle:@"倒序" forState:UIControlStateNormal];
    }else{
        [_sequencingBtn setTitle:@"正序" forState:UIControlStateNormal];
    }
}
- (IBAction)clickremindsBtn:(id)sender {

    self.remindsView.hidden = YES;
}


#pragma mark---网络请求
-(void)getDJMusicList{
    _urlArr = nil;
    _dataArr = nil;
    //1.请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //3.发送请求//url还要拼接
    NSString *musicDetailUrl = [NSString stringWithFormat:@"http://app.9nali.com/1268/albums/%@?page_id=1&isAsc=true&device=iPhone&version=1.1.5",_ablumld];
    [mgr GET:musicDetailUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将字典 数组 转为 模型 数组
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = responseObject[@"tracks"];
        NSArray *dictArray = dic[@"list"];
        _urlArr = dic[@"list"];
        
        for (NSDictionary *dict in dictArray) {
            JHMusicListModel *model = [JHMusicListModel objectWithKeyValues:dict];
            [self.dataArr addObject:model];
        }

        self.nameLab.text = responseObject[@"album"][@"title"];
        if (responseObject[@"album"][@"intro"]){
            if ([[Common stringFromData:responseObject[@"album"][@"intro"] ] isEqualToString:@""]) {
                self.remindsLab.text = @"暂无介绍";
            }else{
                self.remindsLab.text = responseObject[@"album"][@"intro"];
            }
        }
        
        
        [_largeImage sd_setImageWithURL:[NSURL URLWithString:responseObject[@"album"][@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"noImage"]];
        [_smallImage sd_setImageWithURL:[NSURL URLWithString:responseObject[@"album"][@"coverSmall"]] placeholderImage:[UIImage imageNamed:@"noImage"]];

        _showsNumberLab.text = [Common stringFromData: responseObject[@"album"][@"tracks"]];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"GET请求失败--%@",error);
    }];
    [self.tableView.header endRefreshing];
}
-(void)getDJMusicList2{
    _dataArr = nil;
    _urlArr = nil;
    //1.请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //3.发送请求//url还要拼接
    NSString *musicDetailUrl = [NSString stringWithFormat:@"http://app.9nali.com/1268/albums/%@?page_id=1&isAsc=false&device=iPhone&version=1.1.5",_ablumld];
    [mgr GET:musicDetailUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将字典 数组 转为 模型 数组
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = responseObject[@"tracks"];
        NSArray *dictArray = dic[@"list"];
        _urlArr = dic[@"list"];
        
        for (NSDictionary *dict in dictArray) {
            JHMusicListModel *model = [JHMusicListModel objectWithKeyValues:dict];
            [self.dataArr addObject:model];
//            MyLog(@"__%@",dict);
        }
        
        self.nameLab.text = responseObject[@"album"][@"title"];
        if ([responseObject[@"album"][@"intro"] isEqualToString:@""]) {
            self.remindsLab.text = @"暂无介绍";
        }else{
            self.remindsLab.text = responseObject[@"album"][@"intro"];
        }
        
        [_largeImage sd_setImageWithURL:[NSURL URLWithString:responseObject[@"album"][@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"noImage"]];
        [_smallImage sd_setImageWithURL:[NSURL URLWithString:responseObject[@"album"][@"coverSmall"]] placeholderImage:[UIImage imageNamed:@"noImage"]];
        //smallLogo
        _showsNumberLab.text = [Common stringFromData: responseObject[@"album"][@"tracks"]];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"GET请求失败--%@",error);
    }];
    
}


#pragma mark - <UITableViewDelegate&&UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//定义 UITableView cell 的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;

}

//定义 UITableView cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100*VerticalRatio();
}

//定义 UITableView cell 展示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JHMusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[JHMusicListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = cellColor;
    JHMusicListModel *model = self.dataArr[indexPath.row];
    [cell setValueFromModel:model];
    cell.trackId = _urlArr[indexPath.row][@"trackId"];
    cell.downloadBlock = ^{
        _trackId = cell.trackId;
        [self getDownloadUrl];
    };
    
//    MyLog(@"刷新一次");
    return cell;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
        JHMusicListModel *model = self.dataArr[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [MusicManager shareInfo].index = indexPath.row;
        [MusicManager shareInfo].musicArray = self.dataArr;
        
        UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JHMusicPlayViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"MusicPlay"];
        page.trackId = model.trackId;
        page.playIndex = 0;
        [self.navgationVC pushToViewController:page];

}


#pragma mark----给我要下载的文件指定一个路径
-(void)getMyPath{
    //Documents路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // 创建music文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *musicPath = [path stringByAppendingPathComponent:@"music"];
    [fileManager createDirectoryAtPath:musicPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //每首歌创建一个文件夹（以歌名命名）
    NSString *songPath = [musicPath stringByAppendingPathComponent:_musicName];
    [fileManager createDirectoryAtPath:songPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //音频下载
    [self downloadMusic:songPath];
    //小图下载
    [self downloadMusicImageS:songPath];
    //大图下载
//    [self downloadMusicImageL:songPath];
}
#pragma mark----歌曲下载到本地的指定路径
-(void)downloadMusic:(NSString *)songPath{
    //远程地址
    NSURL *URL = [[NSURL alloc] initWithString:_downloadUrl];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSProgress *progress = [[NSProgress alloc]init];
    //下载Task操作
    _downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 给Progress添加监听 KVO
        NSLog(@"--%f--",1.0 * progress.completedUnitCount / progress.totalUnitCount);
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径

        NSString *path = [songPath stringByAppendingPathComponent:response.suggestedFilename];
        MyLog(@"下载后路径为%@",path);//存入并命名

        _myMusicPathDic[@"music"] = path;
        _successTag = 1;
//        [self saveMyAllPaths];
        [self creatFMDBToSaveMusicPath];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        MyLog(@"下载后读取");
    }];
}
#pragma mark----歌曲的小图下载到本地的指定路径
-(void)downloadMusicImageS:(NSString *)imagePath{
    //远程地址
    NSURL *URL = [[NSURL alloc] initWithString:_coverSmallUrl];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSProgress *progress = [[NSProgress alloc]init];
    //下载Task操作
    _downloadTaskImageS = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 给Progress添加监听 KVO
        NSLog(@"--%f--",1.0 * progress.completedUnitCount / progress.totalUnitCount);
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *path = [imagePath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"下载后路径为%@",path);//存入并命名
        _myMusicPathDic[@"image"] = path;
        _successTag = 2;
//        [self saveMyAllPaths];
        [self creatFMDBToSaveMusicPath];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"下载后读取");
    }];
}
#pragma mark---获取下载地址
-(void)getDownloadUrl{
    //1.请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //3.发送请求//url还要拼接
    NSString *urlStr = [NSString stringWithFormat:@"http://app.9nali.com/1268/%@/track/%@/download?device=iPhone&version=1.1.5",_uid,_trackId];
    [mgr GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = responseObject[@"data"];
        _downloadUrl = dic[@"downloadUrl"];
        _coverSmallUrl = dic[@"coverSmall"];
        _albumCoverSmallUrl = dic[@"albumCoverSmall"];
        _musicName = dic[@"title"];
        [_myMusicPathDic setObject:_musicName forKey:@"name"];
        [self getMyPath];
        [_downloadTask resume];
        [_downloadTaskImageS resume];
//        [_downloadTaskImageL resume];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"GET请求失败--%@",error);
    }];
    
}


#pragma mark----修改FMDB数据库
-(void)creatFMDBToSaveMusicPath{
    if (_successTag==1) {
        MyLog(@"满足条件,开始向FMDB加入元素");
        [_fmdbHelp fmdbInsertData:_myMusicPathDic[@"name"] music:_myMusicPathDic[@"music"] image:_myMusicPathDic[@"image"]trackId:_trackId];
        
       NSMutableArray * dataArr = [_fmdbHelp fmdbSelectData];//查询
       [[NSUserDefaults standardUserDefaults]setObject:dataArr forKey:JHMusicFMDB];
       [[NSUserDefaults standardUserDefaults] synchronize];//写入磁盘
    }else{
        MyLog(@"不满足条件");
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
