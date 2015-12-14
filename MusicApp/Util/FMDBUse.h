//
//  FMDBUse.h
//  MusicApp
//
//  Created by 许汝邈 on 15/11/16.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
@interface FMDBUse : NSObject

//保存到数据库
+(void)saveByMusicId:(NSString *)musicId lyric:(NSString *)lyric musicName:(NSString *)musicName;

//根据Id获取歌曲名
+(NSMutableArray *)findNameByMusicId:(NSString *)musicId;

@end
