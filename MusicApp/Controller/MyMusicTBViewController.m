//
//  MyMusicTBViewController.m
//  MusicApp
//  显示下载的音乐控制器
//  Created by 许汝邈 on 15/10/16.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MyMusicTBViewController.h"
#import "Reachability.h"
@interface MyMusicTBViewController ()

@end

@implementation MyMusicTBViewController{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    _wordArray = [[NSMutableArray alloc] init];
    _timeArray = [[NSMutableArray alloc] init];
    _totalWordArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cm2_list_detail_icn_music_sm.png"] style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    //cm2_list_detail_icn_music_sm
    
    self.navigationItem.rightBarButtonItem = rightButton;
  
    

    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
  //  NSLog(@"这个是多少%f",_tableView.frame.origin.y);
    
    [self getMusicId];
    
    [_tableView reloadData];

    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    
    cell.textLabel.text = _nameArray[indexPath.row];
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_nameArray count];
}


#pragma mark - 获取目录中的歌曲ID
-(void)getMusicId
{
   
    _nameArray = [NSMutableArray array];
    //获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
   // NSLog(@"%@",docDirPath);

    //初始化
    _requestArray = [NSMutableArray array];
    
    NSArray *files = [fileManager subpathsAtPath:docDirPath];
    
    
    [_totalWordArray removeAllObjects];
    for (int i = 0; i < [files count] -1 ; i++) {
       // [_nameArray addObject:[allDic objectForKey:files[i]]];
        
         NSArray *sepArray = [files[i] componentsSeparatedByString:@"."];
        
        NSMutableArray *array = [FMDBUse findNameByMusicId:sepArray[0]];
      //  NSLog(@"musicName为%@",array[0]);
       // [_nameArray addObject:files[i]];
        [_totalWordArray addObject:array[1]];
        [_nameArray addObject:array[0]];
        [_requestArray addObject:sepArray[0]];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    
    _musicPlayerVC = [MusicPlayerViewController shareInstance];
    if ([_musicPlayerVC.player isPlaying]) {
        [_musicPlayerVC.player stop];
    }
    
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , _requestArray[indexPath.row]];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    _musicPlayerVC.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    
    
//    [_wordArray removeAllObjects];
//    [_timeArray removeAllObjects];
//    [self getLyric:_requestArray[indexPath.row]];

    
    //解析歌词
    [self parselyric:_totalWordArray[indexPath.row]];
    
    _musicPlayerVC.wordArray = _wordArray;
    _musicPlayerVC.timeArray = _timeArray;
   // _musicPlayerVC.player = _player;
   // [_musicPlayerVC getMusicPlayer:fileURL];
    
    _musicPlayerVC.musicId = _requestArray[indexPath.row];
  
  //  [self presentModalViewController:_musicPlayerVC animated:YES];
   
    if (_nav != nil) {
       // NSLog(@"不为空");
    }
    else{
        _nav = [[UINavigationController alloc] initWithRootViewController:_musicPlayerVC];

       // NSLog(@"到底每次是不是空的");
        
    }
    NSLog(@"这次是多少%@",_musicPlayerVC.player);
    
    
       // [self presentViewController:_nav animated:YES completion:nil];
    self.tabBarController.tabBar.hidden = YES;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_musicPlayerVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
    //[self dismissViewControllerAnimated:YES completion:nil];

    
}

-(void)selectRightAction:(id)sender
{
    _musicPlayerVC = [MusicPlayerViewController shareInstance];
    if (_musicPlayerVC != nil) {
        
        
        self.tabBarController.tabBar.hidden = YES;
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:_musicPlayerVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
       
        
    }
    
    
}


#pragma mark - 获取歌词
-(void)getLyric:(NSString *)number{
    
    
    if ([self testConnection]) {
        
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
    
    else
    {
        _wordArray[0] = @"无网络";
        _timeArray[0] = @"00:00";
        _wordArray[1] = @"暂无歌词";
        _timeArray[1] = @"00:00";
        _wordArray[2] = @"暂无歌词";
        _timeArray[2] = @"00:00";
    }


    
    
}


#pragma mark - 解析歌词
-(void)parselyric:(NSString *)lyric
{
    [_wordArray removeAllObjects];
    NSArray *sepArray = [lyric componentsSeparatedByString:@"["];
    for (int i = 1; i < sepArray.count; i++) {
        NSArray *arr = [sepArray[i] componentsSeparatedByString:@"]"];
        [_timeArray addObject:arr[0]];
        [_wordArray addObject:arr[1]];
    }
    
}


#pragma mark - 判断是否有网络
- (BOOL)testConnection {
    BOOL result = YES;
    
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            NSLog(@"没有网络");
            return NO;
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"正在使用3G网络");
            return YES;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"正在使用wifi网络");
            return YES;
            break;
    }
    return result;
}
@end
