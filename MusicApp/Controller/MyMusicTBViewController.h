//
//  MyMusicTBViewController.h
//  MusicApp
//
//  Created by 许汝邈 on 15/10/16.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayerViewController.h"

@interface MyMusicTBViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *nameArray;

@property(strong,nonatomic)NSMutableArray *requestArray;
@property(strong,nonatomic)MusicPlayerViewController *musicPlayerVC;
@end
