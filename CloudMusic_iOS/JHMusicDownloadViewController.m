//
//  JHMusicDownloadViewController.m
//  CloudMusic_iOS
//
//  Created by qujiahong on 2017/9/26.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMusicDownloadViewController.h"
#import "JHMusicDownloadTableViewCell.h"

#import "JHMusicPlayViewController.h"
#import "JHMusicListModel.h"
#import "JHFMDBHelp.h"
#import "MJExtension.h"
static NSString *CellIdentifier = @"JHMusicDownloadTableViewCell";
@interface JHMusicDownloadViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) JHFMDBHelp * fmdbHelp;
@end

@implementation JHMusicDownloadViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray array]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewLayout];

    JHFMDBHelp * fmdb = [[JHFMDBHelp alloc]init];
    [fmdb fmdbCreate];
    [fmdb fmdbTableCreate];
    _fmdbHelp = fmdb;
    _dataArr = [_fmdbHelp fmdbSelectData];

    
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
    return 80*VerticalRatio();
}

//定义 UITableView cell 展示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHMusicDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[JHMusicDownloadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = cellColor;
    

    UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:_dataArr[indexPath.row][@"image"]];
    [cell.musicImage setImage:imgFromUrl];
    cell.musicNameLab.text = _dataArr[indexPath.row][@"name"];
    cell.deleteBlock = ^{
        //删除数据库歌曲
        [_fmdbHelp fmdbDeleteData:_dataArr[indexPath.row][@"name"]];
        //刷新table
        _dataArr = [_fmdbHelp fmdbSelectData];
        
        [_tableView reloadData];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [MusicManager shareInfo].index = indexPath.row;
    [MusicManager shareInfo].musicArray = self.dataArr;
    
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JHMusicPlayViewController *page = [secondStroyBoard instantiateViewControllerWithIdentifier:@"MusicPlay"];
//    page.trackId = _dataArr[indexPath.row][@"trackId"];
    page.name = _dataArr[indexPath.row][@"name"];
    page.image = _dataArr[indexPath.row][@"image"];
    page.path = _dataArr[indexPath.row][@"music"];
    page.playIndex = 1;
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
