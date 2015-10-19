//
//  MusicPlayerView.m
//  音乐播放界面
//
//  Created by 许汝邈 on 15/10/4.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicPlayerView.h"

@implementation MusicPlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        
        
        _currentPlaybackTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 50, 25)];
        _currentPlaybackTime.font =[UIFont boldSystemFontOfSize:14.0f];
        _currentPlaybackTime.textAlignment = NSTextAlignmentCenter;
        _currentPlaybackTime.textColor = [UIColor blackColor];
        _currentPlaybackTime.text = @"00:00";
        [self addSubview:_currentPlaybackTime];
        
        //设置slider的高度为手指能触摸到的高度即可
        _progress = [[UISlider alloc] initWithFrame:CGRectMake(_currentPlaybackTime.frame.size.width+_currentPlaybackTime.frame.origin.x, 20,self.frame.size.width-110,  25)];
        _progress.continuous = YES;
        _progress.minimumTrackTintColor = [UIColor colorWithRed:244.0f/255.0f green:147.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
        _progress.maximumTrackTintColor = [UIColor lightGrayColor];
        [_progress setThumbImage:[UIImage imageNamed:@"player-progress-point-h"] forState:UIControlStateNormal];
        //        [progress setThumbImage:nil forState:UIControlStateNormal];
     //   [_progress addTarget:self action:@selector(processChanged) forControlEvents:UIControlEventValueChanged];
        
        
        [self addSubview:_progress];
        
        
        
        
        _totalPlaybackTime = [[UILabel alloc] initWithFrame:CGRectMake(_progress.frame.size.width+_progress.frame.origin.x, 20, 50, 25)];
        _totalPlaybackTime.font =[UIFont boldSystemFontOfSize:14.0f];
        _totalPlaybackTime.textAlignment = NSTextAlignmentCenter;
        _totalPlaybackTime.textColor = [UIColor blackColor];
        _totalPlaybackTime.text = @"00:00";
        [self addSubview:_totalPlaybackTime];
        
        
        
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.frame = CGRectMake(self.frame.size.width/2-64/2,self.frame.size.height-64-40, 64, 64);
        [_playButton setImage:[UIImage imageNamed:@"pasue.png"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"playHight.png"] forState:UIControlStateHighlighted];
     //   [_playButton addTarget:self action:@selector(playButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playButton];
        
        
        _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preButton.frame = CGRectMake(_playButton.frame.origin.x-60, _playButton.frame.origin.y+8, 48, 48);
        [_preButton setImage:[UIImage imageNamed:@"preSong.png"] forState:UIControlStateNormal];
        // [_preButton addTarget:self action:@selector(preButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_preButton];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(_playButton.frame.origin.x+70, _playButton.frame.origin.y+8, 48, 48);
        [_nextButton setImage:[UIImage imageNamed:@"nextSong.png"] forState:UIControlStateNormal];
        //[_nextButton addTarget:self action:@selector(nextButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextButton];
        
        
        _playbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playbackButton.frame =  CGRectMake(5, _preButton.frame.origin.y, 48, 48);
        [_playbackButton setImage:[UIImage imageNamed:@"order.png"] forState:UIControlStateNormal];
        //  [_playbackButton addTarget:self action:@selector(playBackButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playbackButton];
        //    isPlayBack = 0;
        
        
        
        
        
        _playListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playListButton.frame =  CGRectMake(self.frame.size.width-48-5, _preButton.frame.origin.y, 48, 48);
        [_playListButton setImage:[UIImage imageNamed:@"playList.png"] forState:UIControlStateNormal];
        //  [_playListButton addTarget:self action:@selector(playListButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playListButton];
        
        
        
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectButton.frame = CGRectMake(_currentPlaybackTime.frame.origin.x, _currentPlaybackTime.frame.origin.y+_currentPlaybackTime.frame.size.height, 48, 48);
        [_collectButton setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        //[_collectButton addTarget:self action:@selector(collectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_collectButton];
        
        self.downLoadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.downLoadButton.frame = CGRectMake(_totalPlaybackTime.frame.origin.x, _totalPlaybackTime.frame.origin.y+_totalPlaybackTime.frame.size.height, 48, 48);
        self.downLoadButton.enabled = NO;
        [self.downLoadButton setImage:[UIImage imageNamed:@"downLoad"] forState:UIControlStateNormal];
        // [self.downLoadButton addTarget:self action:@selector(downLoadButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.downLoadButton];
        
        
        //    noLrcLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height/2-25/2, self.view.frame.size.width, 25)];
        //    noLrcLabel.textAlignment = NSTextAlignmentCenter;
        //    noLrcLabel.textColor =[UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
        //    [self.view addSubview:noLrcLabel];
        //    noLrcLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        
        _noLrcTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.downLoadButton.frame.origin.y + self.downLoadButton.frame.size.height, self.frame.size.width, 260) style:UITableViewStylePlain];
  
        [self addSubview:_noLrcTableView];

        
        
        
    }
    return self;
}



@end
