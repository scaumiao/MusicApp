//
//  MusicListFrame.h
//  测试搜索栏卡顿
//
//  Created by 许汝邈 on 15/9/29.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicList.h"
@class MusicList;

@interface MusicListFrame : NSObject




@property (nonatomic, assign) CGRect songNameF;
@property (nonatomic, assign) CGRect userNameF;
@property (nonatomic, assign) CGRect albumNameF;



/**
 *  行高
 */
@property (nonatomic, assign) CGFloat  cellHeight;
@property (nonatomic, strong) MusicList  *musicList;


@end
