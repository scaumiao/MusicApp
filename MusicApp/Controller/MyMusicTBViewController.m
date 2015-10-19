//
//  MyMusicTBViewController.m
//  MusicApp
//  显示下载的音乐控制器
//  Created by 许汝邈 on 15/10/16.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MyMusicTBViewController.h"

@interface MyMusicTBViewController ()

@end

@implementation MyMusicTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    NSLog(@"这个是多少%f",_tableView.frame.origin.y);
    
    [self getMusicId];

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
    NSLog(@"%d",[_nameArray count]);
    return [_nameArray count];
}


#pragma mark - 获取目录中的歌曲ID
-(void)getMusicId
{
   
    _nameArray = [NSMutableArray array];
    //获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];


    //初始化
    _requestArray = [NSMutableArray array];
    
    NSArray *files = [fileManager subpathsAtPath:docDirPath];
    

    for (int i = 0; i < [files count]  ; i++) {
       // [_nameArray addObject:[allDic objectForKey:files[i]]];
        [_nameArray addObject:files[i]];
         NSArray *sepArray = [files[i] componentsSeparatedByString:@"."];
        [_requestArray addObject:sepArray[0]];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    
    _musicPlayerVC.player = nil;
    _musicPlayerVC.musicPlayerView = nil;
    
    
    _musicPlayerVC = [[MusicPlayerViewController alloc] init];
    
    
    _musicPlayerVC.musicId = _requestArray[indexPath.row];
 
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_musicPlayerVC];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

-(void)selectRightAction:(id)sender
{
    
    if (_musicPlayerVC != nil) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_musicPlayerVC];
        
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
    
}

@end