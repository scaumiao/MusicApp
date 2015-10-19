//
//  MusicData.h
//  MusicApp
//
//  Created by 许汝邈 on 15/10/3.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicData : NSObject

//歌曲的属性
@property(nonatomic,strong)NSString *trackIdentifier;
@property(nonatomic,strong)NSString *albumIdentifier;
@property(nonatomic,strong)NSString *artistIdentifier;
@property(nonatomic,strong)NSString *trackname;
@property(nonatomic,strong)NSString *albumname;
@property(nonatomic,strong)NSString *artistname;
@property(nonatomic,strong)NSString *logoname;
@property(nonatomic,strong)NSString *duration;
//api
+ (id)musicDataWithDic:(NSDictionary *)dic;

@end
