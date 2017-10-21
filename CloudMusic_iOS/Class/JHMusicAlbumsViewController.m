//
//  JHMusicAlbumsViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicAlbumsViewController.h"
#import "JHMusicAlbumsTableViewCell.h"
#import "JHMusicListViewController.h"

#import "AFNetworking.h"
#import "MJExtension.h"

static NSString *CellIdentifier = @"JHMusicAlbumsTableViewCell";
@interface JHMusicAlbumsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation JHMusicAlbumsViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewLayout];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDJMusicAlums)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}
-(void)initViewLayout{
    [self adaptiveViewLayout:self.view];
    [self adaptiveViewLayout:self.NavView];
    [self adaptiveViewLayout:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
}

- (IBAction)clickBack:(id)sender {
    [self backHandel];
}
#pragma mark - 音乐盒专辑数据
- (void)getDJMusicAlums{
    //1.请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //3.发送请求//url还要拼接
    NSString *musicDetailUrl = [NSString stringWithFormat:@"http://app.9nali.com/1268/bozhus/%@?page_id=1&device=iPhone&version=1.1.5",_uid];
    [mgr GET:musicDetailUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //将字典 数组 转为 模型 数组
        NSArray *dictArray = responseObject[@"list"];
        for (NSDictionary *dict in dictArray) {
            JHMusicAlbumsModel *model = [JHMusicAlbumsModel objectWithKeyValues:dict];
            [self.dataArr addObject:model];
        }
       self.nameLab.text = responseObject[@"nickname"];
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
    return 100*VerticalRatio();
}

//定义 UITableView cell 展示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHMusicAlbumsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[JHMusicAlbumsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = cellColor;
    
    JHMusicAlbumsModel *model = self.dataArr[indexPath.row];
    [cell setValueFromModel:model];
   
//    self.navigationItem.title = cell.titleStr;//table刷新时
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JHMusicAlbumsModel *model = self.dataArr[indexPath.row];

    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JHMusicListViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"MusicList"];
    page.ablumld = model.albumId;
    page.uid = _uid;
    [self.navgationVC pushToViewController:page];
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
