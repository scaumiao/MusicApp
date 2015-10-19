//
//  FetchDataFromNet.h
//  MusicApp
//
//  Created by 许汝邈 on 15/10/3.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchDataFromNet : NSObject

typedef void(^fetchTrackDataAndError)(NSArray *array, NSInteger page, NSError *error);
typedef void(^fetchTrackLyricAndError)(NSString *itemString,  NSError *error);

+ (void)fetchMusicData:(NSString *)key page:(NSInteger)page limit:(NSInteger)limit callback:(fetchTrackDataAndError)callback;

+ (void)fetchMusicLyric:(NSString *)key  callback:(fetchTrackLyricAndError)callback;


@end
