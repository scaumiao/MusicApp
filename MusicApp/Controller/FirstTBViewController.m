//
//  FirstTBViewController.m
//  MusicApp
//  第一个界面，用来搜索歌曲
//  Created by 许汝邈 on 15/9/13.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "FirstTBViewController.h"

NSString *const httpUrl =    @"http://apis.baidu.com/geekery/music/query";


@interface FirstTBViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage;//当前页
    NSMutableArray *dataList;
   // NSMutableArray *dataMusicList;//模型数组
    NSMutableArray *musicDataList;
   // HttpSearchUtil *httpSearchUtil;

    int note;//标示为那种tableview
    
    BOOL isSelect;
    int selectNum;//记录上次选中的cell
    MusicListCell *oldCell;
}
@end

@implementation FirstTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _wordArray = [[NSMutableArray alloc] init];
    _timeArray = [[NSMutableArray alloc] init];
    
    note = 0;
    //并行操作测试
    
    isSelect = NO;
    selectNum = -1;
    
    
    //为部分变量分配空间
    currentPage = 1;
    dataList = [[NSMutableArray alloc] init];
    musicDataList = [[NSMutableArray alloc] init];

    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cm2_list_detail_icn_music_sm.png"] style:UIBarButtonItemStylePlain target:self action:@selector(selectLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
     UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cm2_list_detail_icn_music_sm.png"] style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    //cm2_list_detail_icn_music_sm
    
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;
 
    
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,220.0f,44.0f)];
    _searchBar.delegate = self;
    [_searchBar setTintColor:[UIColor redColor]];
    [_searchBar setPlaceholder:@"搜索音乐、歌词、电台"];
    _searchBar.backgroundColor = [UIColor colorWithRed:214/255.0 green:84/255.0 blue:76/255.0 alpha:1.0f];
    //实体机的颜色
    //_searchBar.backgroundColor = [UIColor colorWithRed:211/255.0 green:58/255.0 blue:49/255.0 alpha:1.0f];
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

    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //隐藏多余线条
    [_tableView setTableFooterView:[[UIView alloc] init]];
    //self.title = @"发现音乐";
   
    
    

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
  
    if (_musicPlayerVC != nil) {
  
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_musicPlayerVC];
        
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    
 

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
    [musicDataList removeAllObjects];
    [_tableView reloadData];
    [_searchBar endEditing:YES];
   
}



#pragma mark - searchBar协议
#pragma mark 搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self endSearch];
}


#pragma mark 结束搜索
-(void)endSearch
{
    [_searchBar endEditing:YES];
    note = 1;
    
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:musicDataList.count];
    
    for (MusicData *musicData in musicDataList) {
        // MusicList *musicList = [MusicList musicListWithDict:dict];
        MusicListFrame *musicListF = [[MusicListFrame alloc] init];
        musicListF.musicData = musicData;
        //  NSLog(@"%f",musicListF.songNameF.size.width);
        
        [models addObject:musicListF];
        
    }
    self.statusFrames = [models copy];
    

    
    [_tableView reloadData];
    
}

#pragma mark 开始搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    currentPage = 1;
   
     note = 0;
   
  

    [FetchDataFromNet fetchMusicData:_searchBar.text page:1  limit:10 callback:^(NSArray *array, NSInteger page, NSError *error){
        if (error) {
            NSLog(@"error = %@",error);
        } else{
            
            [musicDataList removeAllObjects];
            for (id a in array) {
                [musicDataList addObject:a];
            }
            if (isSelect) {//重新搜索的时候把之前的控件刷新
                MusicListFrame *musicListFrame =  _statusFrames[selectNum];
                musicListFrame.cellHeight -= 44;
                [oldCell.moreView removeFromSuperview];
                oldCell = nil;
                isSelect = NO;
            }
          
            
            // 刷新表格
            [self.tableView reloadData];
            
        }
    }];

    
    
    
    
}




#pragma mark - UITableView协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (note == 0)
        return [musicDataList count];
    else
    {
        
      
         return [_statusFrames count];
        
    }
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (note == 0) {
        //重定位符
        static NSString * str = @"cell";
        //取出队列中的cell
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
        //如果cell为null ，则创建新的cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        //cell.textLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"songName"];
        //MusicList *musicList = [musicDataList objectAtIndex:indexPath.row];
       // cell.textLabel.text = musicList.songName;
        MusicData *musicData = [musicDataList objectAtIndex:indexPath.row];
        cell.textLabel.text = musicData.trackname;
       
        return cell;
    }
    else
    {
        
        
        MusicListCell *cell = [MusicListCell cellWithTableView:tableView];
        // 3.设置数据
        cell.musicListFrame = self.statusFrames[indexPath.row];
        
        [cell.moreView.btn1 addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreView.btn2 addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreView.btn3 addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreView.btn4 addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreView.btn5 addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moreView.btn6 addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"heightForRowAtIndexPath");
    // 取出对应航的frame模型
    if (note == 0) {
        return 30;
    }
    
    else
    {
        
      
        
        MusicListFrame *musicListFrame = _statusFrames[indexPath.row];
        return musicListFrame.cellHeight;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (note == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _searchBar.text =cell.textLabel.text;
        [self endSearch];
    }
    else
    {
        NSMutableArray *array;
        MusicListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (isSelect && selectNum >=0) {
            if(indexPath.row != selectNum)//如果之前选中的和当前的不一样
            {
                
                MusicListFrame *musicListOldFrame = _statusFrames[selectNum];
                musicListOldFrame.cellHeight -= 44;
                [oldCell.moreView removeFromSuperview];
               
              
               
                
                MusicListFrame *musicListNewFrame = _statusFrames[indexPath.row];
                
  
                //改变它的frame的x,y的值
                musicListNewFrame.cellHeight += 44;
               
                [cell addSubview:cell.moreView];
                [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    cell.moreView.alpha = 1;
                    
                } completion:^(BOOL finished) {
                    
                    　　}
                 ];
                oldCell = cell;
                selectNum = indexPath.row;
                
                
               
                
            }
            else//之前选中的和当前取消的相同
            {
                MusicListFrame *musicListOldFrame = _statusFrames[selectNum];
                musicListOldFrame.cellHeight -= 44;
              
             
                isSelect = NO;
                NSLog(@"选中相同");
                [cell.moreView removeFromSuperview];
               
            }

            
        }
        else
        {
            MusicListFrame *musicListFrame = _statusFrames[indexPath.row];
            cell.moreView.alpha = 0;
            musicListFrame.cellHeight += 44;
            isSelect = YES;
            [cell addSubview:cell.moreView];
            
          
            [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    cell.moreView.alpha = 1;
            
            } completion:^(BOOL finished) {
              }
             ];
            
            oldCell = cell;
            selectNum = indexPath.row;
            
        }
       
        for (int i = 0; i < [_statusFrames count]; i++) {
            NSIndexPath *te=[NSIndexPath indexPathForRow:i inSection:0];
            [array addObject:te];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
       // [_tableView reloadData];
       
    }
    
}

#pragma mark - 下拉加载
- (void)footerRereshing
{
    NSLog(@"下拉加载测试");
    //这段代码用来解除下拉时候那些道具条不会消失的问题
    if (oldCell != nil) {
        MusicListFrame *musicListFrame =  _statusFrames[selectNum];
        musicListFrame.cellHeight -= 44;
        [oldCell.moreView removeFromSuperview];
        oldCell = nil;
        isSelect = NO;
    }
    
    currentPage++;
    
    
    [FetchDataFromNet fetchMusicData:_searchBar.text page:currentPage limit:10 callback:^(NSArray *array, NSInteger page, NSError *error){
        if (error) {
            NSLog(@"error = %@",error);
        } else{
            
           
            for (id a in array) {
                [musicDataList addObject:a];
            }
            // 刷新表格
            [self.tableView reloadData];
            
        }
    }];

    
   
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self endSearch];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

#pragma mark - 定义tool点击事件
-(void)toolClick:(id)sender {

    MusicListCell *cell = [[sender superview] superview];

    NSString *identifier = cell.musicListFrame.musicData.trackIdentifier;
    NSString *urlString = [NSString stringWithFormat:@"http://music.163.com/api/song/detail/?id=%@&ids=[%@]", identifier,identifier];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *itemDictionary = [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:nil];
    NSArray *array = [itemDictionary objectForKey:@"songs"];
    NSString *str = [array[0] objectForKey:@"mp3Url"];
   
  
    //将player放在此处，跳转页面用单例实现
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , identifier];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"is not exit");
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            
            //下载文件
            [data writeToFile:filePath atomically:YES];
            _player = [[AVAudioPlayer alloc] initWithData:data error:nil];
            
        }];
        
    }
    else
    {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
    }
    [_player play];

    [_wordArray removeAllObjects];
    [_timeArray removeAllObjects];
    [self getLyric:identifier];
    
    
    _musicPlayerVC = [MusicPlayerViewController shareInstance];
    
    _musicPlayerVC.wordArray = _wordArray;
    _musicPlayerVC.timeArray = _timeArray;
    _musicPlayerVC.player = _player;
   // _musicPlayerVC.musicPlayerView = nil;
    // _musicPlayerVC = nil;
    _musicPlayerVC.musicId = identifier;
    _musicPlayerVC.detailUrl = str;
    _musicPlayerVC.musicName = cell.musicListFrame.musicData.trackname;



    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_musicPlayerVC];
   
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}


#pragma mark - 获取歌词
-(void)getLyric:(NSString *)number{
    
    
    [FetchDataFromNet fetchMusicLyric:number callback:^(NSString *stringItem,  NSError *error){
        if (error) {
            NSLog(@"error = %@",error);
            _wordArray[0] = @"无网络";
            _timeArray[0] = @"00:00";
        } else{
            if (stringItem == nil) {
                _wordArray[0] = @"暂无歌词";
                _timeArray[0] = @"00:00";
            }
            else
              
                [self parselyric:stringItem];
            
        }
        
    }];
    
    
}


#pragma mark - 解析歌词
-(void)parselyric:(NSString *)lyric
{
    
    NSArray *sepArray = [lyric componentsSeparatedByString:@"["];
    for (int i = 1; i < sepArray.count; i++) {
        NSArray *arr = [sepArray[i] componentsSeparatedByString:@"]"];
        [_timeArray addObject:arr[0]];
        [_wordArray addObject:arr[1]];
    }
   
}

@end
