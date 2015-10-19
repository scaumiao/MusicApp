//
//  Music.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/10.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject


//歌词、id、标题、图片、作者

@property(strong,nonatomic)NSString *picUrl;
@property(strong,nonatomic)NSString *mp3Url;
@property(strong,nonatomic)NSString *lyric;

@end


