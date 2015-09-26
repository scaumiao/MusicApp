//
//  FirstTBViewController.m
//  MusicApp
//
//  Created by 许汝邈 on 15/9/13.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "FirstTBViewController.h"

NSString *const httpUrl =    @"http://apis.baidu.com/geekery/music/query";


@interface FirstTBViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage;//当前页
    NSMutableArray *dataList;
    NSMutableArray *dataMusicList;//模型数组
    HttpSearchUtil *httpSearchUtil;
}
@end

@implementation FirstTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //并行操作测试
    
    
    
    
    
    //为部分变量分配空间
    currentPage = 1;
    dataList = [[NSMutableArray alloc] init];
    dataMusicList = [[NSMutableArray alloc] init];

    
//    _firstTBView = [[FirstTBView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width , self.view.frame.size.height)];
//    _firstTBView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:_firstTBView];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction:)];
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;
 
    
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,220.0f,44.0f)];
    _searchBar.delegate = self;
    [_searchBar setTintColor:[UIColor redColor]];
    [_searchBar setPlaceholder:@"搜索音乐、歌词、电台"];
    //_searchBar.backgroundColor = [UIColor colorWithRed:214/255.0 green:84/255.0 blue:76/255.0 alpha:1.0f];
    //实体机的颜色
    _searchBar.backgroundColor = [UIColor colorWithRed:211/255.0 green:58/255.0 blue:49/255.0 alpha:1.0f];
    _searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size];
    
    
    
    
    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 44)];
    searchView.backgroundColor = [UIColor blueColor];
    [searchView addSubview:_searchBar];
    self.navigationItem.titleView = searchView;
    self.navigationItem.titleView.backgroundColor = [UIColor whiteColor];
    
    
    //键盘隐藏
    [_searchBar endEditing:NO];
    [self setUpForDismissKeyboard];
    
    
    //添加tableview

    CGFloat tableViewHeight = self.view.frame.size.height - self.parentViewController.tabBarController.tabBar.frame.size.height ;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,tableViewHeight) style:UITableViewStylePlain];
  //  _tableView.backgroundColor = [UIColor blueColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //隐藏多余线条
    [_tableView setTableFooterView:[[UIView alloc] init]];
    //self.title = @"发现音乐";
   
    
    
    //搜索框
    /*
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    
    _searchController.dimsBackgroundDuringPresentation = NO;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(100, 30, 100, 44.0);
    
    _searchController.searchBar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_searchController.searchBar];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 20, 100, 44.0)];
    
    [self.view addSubview:_searchBar];
     */

}


-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectLeftAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}
-(void)selectRightAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}




-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
   
}



#pragma -mark 取消searchbar背景色
//网上搜索的方法

- (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size


{


    CGRect rect = CGRectMake(0, 0, size.width, size.height);


    UIGraphicsBeginImageContext(rect.size);


    CGContextRef context = UIGraphicsGetCurrentContext();



    CGContextSetFillColorWithColor(context,[color CGColor]);


    CGContextFillRect(context,rect);




    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();


    UIGraphicsEndImageContext();



    return image;


}

#pragma -mark 隐藏键盘
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    _searchBar.text = @"";
    //[_searchBar setPlaceholder:@"搜索音乐、歌词、电台"];
    [dataMusicList removeAllObjects];
    [_tableView reloadData];
    [_searchBar endEditing:YES];
   
}



#pragma mark - searchBar协议
#pragma mark 搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   [_searchBar endEditing:YES];
}

#pragma mark 开始搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    currentPage = 1;
   
   
       
        NSString *str = [NSString stringWithFormat:@"s=%@&limit=10&p=%d",searchBar.text,currentPage];
        NSString *httpArg = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
        //[httpSearchUtil request: httpUrl withHttpArg: httpArg];
    
    
        

        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        [HttpSearchUtil httpNsynchronousRequestUrl:urlStr finshedBlock:^(NSDictionary *totalDic){
            
            if ([[totalDic objectForKey:@"status"]  isEqual: @"success"]) {
                //getList获取中间变量为一页的数量，array转换成模型存储到dataMusicList中
                NSArray *getList = [[NSArray alloc]initWithArray:[[[totalDic objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"list"]];
                NSArray *array = [MusicList objectArrayWithKeyValuesArray:getList];
                [dataMusicList removeAllObjects];
                for (id a in array) {
                    [dataMusicList addObject:a];
                }
                
            }
            
            NSLog(@"%@",dataMusicList);
            
            // 刷新表格
            [self.tableView reloadData];
        }];

    });

    
}




#pragma mark - UITableView协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataMusicList count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //重定位符
    static NSString * str = @"cell";
    //取出队列中的cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    //如果cell为null ，则创建新的cell
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    //cell.textLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"songName"];
    MusicList *musicList = [dataMusicList objectAtIndex:indexPath.row];
    cell.textLabel.text = musicList.albumName;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    
}

#pragma mark - 下拉加载
- (void)footerRereshing
{
    NSLog(@"下拉加载测试");
    
    currentPage++;
    
    
    [self getRequestByText:_searchBar.text];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

#pragma mark - 封装服务器请求

-(void)getRequestByText:(NSString *)text
{


    NSString *str = [NSString stringWithFormat:@"s=%@&limit=10&p=%d",text,currentPage];
    NSString *httpArg = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];

    [HttpSearchUtil httpNsynchronousRequestUrl:urlStr finshedBlock:^(NSDictionary *totalDic){
        
        if ([[totalDic objectForKey:@"status"]  isEqual: @"success"]) {
            //getList获取中间变量为一页的数量，array转换成模型存储到dataMusicList中
            NSArray *getList = [[NSArray alloc]initWithArray:[[[totalDic objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"list"]];
            NSArray *array = [MusicList objectArrayWithKeyValuesArray:getList];
           
            for (id a in array) {
                [dataMusicList addObject:a];
            }
            
        }

    }];
    
    
}

@end
