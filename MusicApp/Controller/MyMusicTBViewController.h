//
//  MyMusicTBViewController.h
//  MusicApp
//
//  Created by 许汝邈 on 15/10/16.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayerViewController.h"
#import "FetchDataFromNet.h"
#import "FMDBUse.h"
@interface MyMusicTBViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *nameArray;

@property(strong,nonatomic)NSMutableArray *requestArray;
@property(strong,nonatomic)MusicPlayerViewController *musicPlayerVC;

@property(strong,nonatomic)NSMutableArray *wordArray;
@property(strong,nonatomic)NSMutableArray *timeArray;

@property(strong,nonatomic)NSMutableArray *totalWordArray;

@property(strong,nonatomic)AVAudioPlayer *player;


@property(strong,nonatomic) UINavigationController *nav;
@end
