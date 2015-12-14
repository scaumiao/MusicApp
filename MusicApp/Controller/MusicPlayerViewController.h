//
//  MusicPlayerViewController.h
//  音乐播放界面
//
//  Created by 许汝邈 on 15/10/4.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayerView.h"
#import "FMDBUse.h"

@interface MusicPlayerViewController : UIViewController
{
    BOOL isPlaying;
}
@property(strong,nonatomic)MusicPlayerView *musicPlayerView;

@property(strong,nonatomic)NSString *newsUrl;

//时间
@property (nonatomic,strong)NSMutableArray *timeArray;

//歌词
@property(nonatomic,assign)NSString *lyric;

@property (nonatomic,strong)NSMutableArray *wordArray;
//
//
//@property (nonatomic,strong) UIButton * downLoadButton;
//
@property(nonatomic,strong)AVAudioPlayer *player;
//
////定时器
@property(nonatomic,strong)NSTimer *CurrentTimeTimer;

//请求音乐的Url
@property(nonatomic,strong)NSString *detailUrl;
//请求音乐的Id
@property(nonatomic,strong)NSString *musicId;
//请求音乐的名字
@property(nonatomic,strong)NSString *musicName;

-(void)getLyric:(NSString *)number;
-(void)parselyric:(NSString *)lyric;
-(void)getMusicPlayer:(NSURL *)url;
-(void)getMusic:(NSString *)url musicName:(NSString *)musicName identifier:(NSString *)identifier;
+(MusicPlayerViewController *)shareInstance;



-(void)test:(NSString *)url;
@end
