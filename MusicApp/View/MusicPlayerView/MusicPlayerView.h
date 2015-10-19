//
//  MusicPlayerView.h
//  音乐播放界面
//
//  Created by 许汝邈 on 15/10/4.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerView : UIView

@property(strong,nonatomic)UILabel *currentPlaybackTime;//当前播放时间
@property(strong,nonatomic)UISlider *progress;//进度条
@property(strong,nonatomic)UILabel *totalPlaybackTime;//结束时间
@property(strong,nonatomic)UIButton *playButton;//开始播放按钮
@property(strong,nonatomic)UIButton *preButton;//前一首按钮
@property(strong,nonatomic)UIButton *nextButton;//后一首按钮
@property(strong,nonatomic)UIButton *playbackButton;//单曲循环按钮
@property(strong,nonatomic)UIButton *playListButton;//歌单列表按钮
@property(strong,nonatomic)UIButton *collectButton;//星标按钮
@property (nonatomic,strong) UIButton * downLoadButton;
// UILabel * noLrcLabel;//歌词
@property(strong,nonatomic)UITableView *noLrcTableView;
@end
