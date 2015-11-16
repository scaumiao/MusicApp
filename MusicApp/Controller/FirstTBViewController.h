//
//  FirstTBViewController.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/13.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTBView.h"
//#import "HttpSearchUtil.h"
#import "FetchDataFromNet.h"
#import "MJRefresh.h"
#import "MusicList.h"
#import "MusicListCell.h"
#import "MusicPlayerViewController.h"

static MusicPlayerViewController *_musicPlayerVC;

@interface FirstTBViewController : UIViewController


@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)FirstTBView *firstTBView;


@property (nonatomic, strong) UISearchController *searchController;

@property(nonatomic,strong)UISearchBar *searchBar;

//@property(nonatomic,strong)MusicPlayerViewController *musicPlayerVC;

//暂时在这里设置view
//@property(nonatomic,strong)UITableView *tableView;


//放置自定义cell的frame
@property (nonatomic, strong) NSMutableArray *statusFrames;

@property(strong,nonatomic)AVAudioPlayer *player;

//时间
@property (nonatomic,strong)NSMutableArray *timeArray;

//歌词
@property (nonatomic,strong)NSMutableArray *wordArray;







@end
