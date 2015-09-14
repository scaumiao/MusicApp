//
//  FirstTBViewController.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/13.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTBView.h"

@interface FirstTBViewController : UIViewController

@property(strong,nonatomic)FirstTBView *firstTBView;


@property (nonatomic, strong) UISearchController *searchController;

@property(nonatomic,strong)UISearchBar *searchBar;

@end
