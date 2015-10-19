//
//  ViewController.m
//  音乐播放界面
//
//  Created by 许汝邈 on 15/9/30.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "FetchDataFromNet.h"
#import "UIImageView+WebCache.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
@interface MusicPlayerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentRow;
    NSMutableDictionary *memCache;//内存缓存图片引用
    UIImage *img;
    
}
@end


@implementation MusicPlayerViewController
+(MusicPlayerViewController *)shareInstance
{
    static MusicPlayerViewController *shareInstance = nil;
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MusicPlayerViewController alloc] init];
    });
    
    
    
    return shareInstance;
}





-(void)viewDidLoad
{
   
    _musicPlayerView = [[MusicPlayerView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height)];
    
    _timeArray = [[NSMutableArray alloc] init];
    _wordArray = [[NSMutableArray alloc] init];
    
    //获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , _musicId];
    

    
//    NSString *plistName = [docDirPath stringByAppendingPathComponent:@"download.plist"];
//    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile:plistName];
//    
//    if (dic2 == nil) {
//        NSFileManager *fm = [NSFileManager defaultManager];
//        [fm createFileAtPath:plistName contents:nil attributes:nil];
//        
//    }
    
    //写入真机Plist
//    NSString *lib = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *libPath = [lib stringByAppendingString:@"/Caches"];
//    NSString* plistPath = [libPath stringByAppendingFormat:@"/download.plist"];
//    
//    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
//        NSMutableArray *dictplist = [[NSMutableArray alloc] init];
//        [dictplist insertObject:@"download" atIndex:0];
//        
//        [dictplist writeToFile:plistPath atomically:YES];
//        NSLog(@"------1-----%@",dictplist);
//    }
//    NSMutableDictionary *allDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"shi%@",plistPath);
//    [allDic setObject:_musicId forKey:_musicName];
//    [allDic writeToFile:plistPath atomically:YES];
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"is not exit");
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_detailUrl]];
        
        //创建一个可变字典用来存储plist之前的内容
       //模拟器
       
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            //写入plist中
//            int intString = [_musicId intValue];
//            NSString *str =  [NSString stringWithFormat:@"%d",intString];
//            
//            [allDic setObject:_musicName forKey:str];
//            [allDic writeToFile:plistPath atomically:YES];
            
            
            //[allDic setObject:_musicName forKey:str];
           // [allDic writeToFile:plistName atomically:YES];
            
            
         
            
            //下载文件
            [data writeToFile:filePath atomically:YES];
            _player = [[AVAudioPlayer alloc] initWithData:data error:nil];
            [_player play];
            _musicPlayerView.totalPlaybackTime.text = [self strWithTime:_player.duration];//duration为总时长
        }];
        
    }
    else
    {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
    }
    [_player play];
    isPlaying = YES;
    
    _musicPlayerView.totalPlaybackTime.text = [self strWithTime:_player.duration];//duration为总时长
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(updateSliderValue) userInfo:nil repeats:YES];
    
    
    
    [self getLyric:_musicId];
    //SDImageCache
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    
    [manager downloadImageWithURL:[NSURL URLWithString:@"http://p3.music.126.net/NEVUYIRYgOzxhZD_v4x9GQ==/23089744195559.jpg"]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                
                                
                                //设置模糊背景
                                //此方法适用于IOS8及以上
                                UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
                                visualEffectView.frame = self.view.bounds;
                                visualEffectView.alpha = 1.0;
                                
//                                                                  visualEffectView.backgroundColor = [UIColor colorWithPatternImage:image];占用内存舍弃
                                
                                visualEffectView.layer.contents = (id)image.CGImage;
                              
                                _musicPlayerView.noLrcTableView.backgroundView = visualEffectView;
                                
                                
                                //                                    UIImageView *blurImageView = [[UIImageView alloc]initWithFrame: _musicPlayerView.noLrcTableView.bounds];
                                //                                    blurImageView.image = [self blur:image];
                                //
                                //
                                //
                                //
                                ////                                    blurImageView.image = image;
                                //                                    _musicPlayerView.noLrcTableView.backgroundView = blurImageView;
//                                NSString *homePath=NSHomeDirectory();
//                                 NSLog(@"%@",homePath);
                            
                            }
                        }];
//    f83c5b3f2b2bdcd7254bcbdd5a6a2238
  
    
    
   
    if (_wordArray && _timeArray) {
         _musicPlayerView.noLrcTableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消cell分隔线
        _musicPlayerView.noLrcTableView.delegate = self;
        _musicPlayerView.noLrcTableView.dataSource = self;
        [_musicPlayerView.progress addTarget:self action:@selector(processChanged) forControlEvents:UIControlEventValueChanged];
        [_musicPlayerView.playButton addTarget:self action:@selector(playButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }


    [self.view addSubview:_musicPlayerView];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_chbackbtn.png"] style:UIBarButtonItemStylePlain target:self action:@selector(selectLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    
    
}
//#pragma mark - 通知
//-(void)SendMusicDetailUrl:(NSNotification*)notification{
//    //读取并设置请求的音乐地址
//    NSDictionary *nameDictionary = [notification userInfo];
//    _detailUrl = [nameDictionary objectForKey:@"url"];
//    _musicId = [nameDictionary objectForKey:@"musicId"];
//    
//}
////生成一张毛玻璃图片
//- (UIImage*)blur:(UIImage*)theImage
//{
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:inputImage forKey:kCIInputImageKey];
//    [filter setValue:[NSNumber numberWithFloat:50.0f] forKey:@"inputRadius"];
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    
//    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
//    
//    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    return returnImage;
//}

-(void)playButtonEvent
{
    if (isPlaying) {
        [_player pause];
        isPlaying = NO;
        [_musicPlayerView.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [_musicPlayerView.playButton setImage:[UIImage imageNamed:@"pasue.png"] forState:UIControlStateNormal];
        isPlaying = YES;
        [_player play];
        
    }
    NSLog(@"click");
}

/**
 *把时间长度-->时间字符串
 */
-(NSString *)strWithTime:(NSTimeInterval)time
{
    int minute=time / 60;
    int second=(int)time % 60;
    if (minute < 10 && second < 10) {
        return [NSString stringWithFormat:@"0%d:0%d",minute,second];
    }
    else if(minute < 10){
        return [NSString stringWithFormat:@"0%d:%d",minute,second];;
    }
    else if(second < 10){
        return [NSString stringWithFormat:@"%d:0%d",minute,second];;
    }
    else
    {
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
}


#pragma mark - 滑动条事件
-(void)processChanged
{
//    [_player setCurrentTime:progress.value*_player.duration];
      [_player setCurrentTime:_musicPlayerView.progress.value*_player.duration];
}
#pragma mark - 计时器事件
//计算滑动条的长度以及更改当前时间显示
-(void)updateSliderValue
{
    _musicPlayerView.progress.value = _player.currentTime/_player.duration;
    _musicPlayerView.currentPlaybackTime.text = [self strWithTime:_player.currentTime];
    
    //CGFloat currentTime = _player.currentTime;
    for (int i = 0; i < _timeArray.count; i ++) {
        
        NSArray *arr = [_timeArray[i] componentsSeparatedByString:@":"];
        
        CGFloat compTime = [arr[0] integerValue]*60 + [arr[1] floatValue];
        
        if (_player.currentTime > compTime)
        {
            currentRow = i;
        }
        else
        {
            break;
        }
    }
    if (isPlaying) {

        [_musicPlayerView.noLrcTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];

    }

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



#pragma mark - tableview协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    return [_wordArray count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    UITableViewCell *cell;
    UILabel *label =nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        CGFloat size = label.font.pointSize;
        [label setMinimumScaleFactor:FONT_SIZE/size];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTag:1];
        [[cell contentView]addSubview:label];
        
    }
    
    NSString *text = [_wordArray objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN *2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    if (!label)
        label = (UILabel*)[cell viewWithTag:1];
    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN *2), MAX(size.height, 44.0f))];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
   
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",_wordArray[indexPath.row]);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {

    NSString *text = [_wordArray objectAtIndex:[indexPath row]];
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN *2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];

    CGFloat height =MAX(size.height, 34.0f);
 
    return height + (CELL_CONTENT_MARGIN );
   // NSString
}



-(void)selectLeftAction:(id)sender
{
    //
   // [[NSNotificationCenter defaultCenter ] removeObserver:self];

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    @property(strong,nonatomic)MusicPlayerView *musicPlayerView;
//    
//    @property(strong,nonatomic)NSString *newsUrl;
//    
//    //时间
//    @property (nonatomic,strong)NSMutableArray *timeArray;
//    
//    //歌词
//    @property (nonatomic,strong)NSMutableArray *wordArray;
//    //
//    //
//    //@property (nonatomic,strong) UIButton * downLoadButton;
//    //
//    @property(nonatomic,strong)AVAudioPlayer *player;
//    //
//    ////定时器
//    @property(nonatomic,strong)NSTimer *CurrentTimeTimer;
//    
//    //请求音乐的Url
//    @property(nonatomic,strong)NSString *detailUrl;
//    //请求音乐的Id
//    @property(nonatomic,strong)NSString *musicId;
    
}


#pragma mark - 重置音乐
-(void)resetMusicPlayer
{
    _player = nil;
    
    [self removeCurrentTime];
    
}


-(void)removeCurrentTime
{
    [self.CurrentTimeTimer invalidate];
    
     //把定时器清空
    self.CurrentTimeTimer=nil;
    
    
}

-(void)setMusic:(NSString *)url{
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"视图消失");
}

@end
