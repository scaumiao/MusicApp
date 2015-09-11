//
//  MusicList.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/10.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface MusicList : NSObject

@property(copy,nonatomic) NSString *albumName;
@property(copy,nonatomic) NSString *albumPic;
@property(copy,nonatomic) NSString *songId;
@property(copy,nonatomic) NSString *songName;
@property(copy,nonatomic) NSString *songUrl;
@property(copy,nonatomic) NSString *userName;

@end
