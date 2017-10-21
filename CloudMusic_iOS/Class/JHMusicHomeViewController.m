//
//  JHMusicHomeViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicHomeViewController.h"
#import "JHMusicHomeTableViewCell.h"
#import "JHMusicAlbumsViewController.h"
#import "JHMusicDownloadViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "JHMusicPlayViewController.h"

static NSString *CellIdentifier = @"JHMusicHomeTableViewCell";

@interface JHMusicHomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (weak, nonatomic) IBOutlet UIView *personalView;
@property (weak, nonatomic) IBOutlet UIButton *bigBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation JHMusicHomeViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self whiteStatusBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewLayout];
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//    }];
    //或
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDJMusicHome)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
   
}

-(void)initViewLayout{
    [self adaptiveViewLayout:self.view];
    [self adaptiveViewLayout:self.NavView];
    [self adaptiveViewLayout:self.tableView];
    [self adaptiveViewLayout:self.personalView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
}

#pragma mark - 音乐盒主页数据
- (void)getDJMusicHome{
//    self.shareApi.delegate=self;
//    NSMutableDictionary  *dic=[NSMutableDictionary dictionary];
//    [self.shareApi  requestOperationWithDic:dic withPath:DJMusicHomeUrl withHttpType:@"GET" withTag:L_DJMusicHomeUrl];

    //1.请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"totalCount"] = @1;//一条数据//此处有34条
    //3.发送请求
    [mgr GET:kMusicAlbumUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将字典 数组 转为 模型 数组
        NSArray *dictArray = responseObject[@"list"];
        for (NSDictionary *dict in dictArray) {
            JHMusicHomeModel *model = [JHMusicHomeModel objectWithKeyValues:dict];
            [self.dataArr addObject:model];
        }
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"GET请求失败--%@",error);
    }];
    [self.tableView.header endRefreshing];
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
    return 110*VerticalRatio();
}

//定义 UITableView cell 展示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHMusicHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[JHMusicHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.backgroundColor = cellColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JHMusicHomeModel *model = self.dataArr[indexPath.row];
    [cell setValueFromModel:model];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JHMusicHomeModel *model = self.dataArr[indexPath.row];
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JHMusicAlbumsViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"MusicAlbums"];
    page.uid = model.uid;
    [self.navgationVC pushToViewController:page];
}

//#pragma   mark---- GetADBanner Request Delegate
//
//-(void)fetchDatabaseFinished:(NSMutableDictionary *)database withTag:(NSInteger)tag{
//    
//    [_tableView.footer endRefreshing];
//    [_tableView.header endRefreshing];
//
//    if (tag==L_DJMusicHomeUrl) {
//        self.dataArr = database[@"list"];
//    }
//}
//-(void)fetchDatabaseFailed:(NSError *)error message:(NSString *)message{
//
//    [_tableView.footer endRefreshing];
//    [_tableView.header endRefreshing];
//    [self dismissWaitDialog];
// 
//}
- (IBAction)clickPersonalBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(0, 20, 200, 548), NO);
    self.bigBtn.hidden = NO;

    
}

#pragma mark---个人中心页面
- (IBAction)clickBigBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
}
//首页
- (IBAction)clickMusicHomeBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
    
}
//书城
- (IBAction)clickBookCityBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
}
//下载听
- (IBAction)clickDownloadBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JHMusicDownloadViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"Download"];
    [self.navgationVC pushToViewController:page];
}
//订阅历史
- (IBAction)clickCollectBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
}

//播放中心
- (IBAction)clickMusicPlayBtn:(id)sender {
    self.personalView.frame = flexibleFrame(CGRectMake(-200, 20, 200, 548), NO);
    self.bigBtn.hidden = YES;
    
//    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    JHMusicPlayViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"MusicPlay"];
//    [self.navgationVC pushToViewController:page];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
