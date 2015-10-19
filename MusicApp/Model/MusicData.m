//
//  MusicData.m
//  MusicApp
//
//  Created by 许汝邈 on 15/10/3.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicData.h"

@implementation MusicData


+ (id)musicDataWithDic:(NSDictionary *)dic{
    
    return [[self alloc] initWithDic:dic];
}
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.trackIdentifier = [dic objectForKey:@"id"];
        self.trackname = [dic objectForKey:@"name"];
        self.duration = [dic objectForKey:@"duration"];
        //进入字典中的字典去标识，用key去标识内层中的属性
        NSDictionary *albumDic = [dic objectForKey:@"album"];
        self.albumIdentifier = [albumDic objectForKey:@"id"];
        self.albumname = [albumDic objectForKey:@"name"];
        
        NSDictionary *artistDic = [[dic objectForKey:@"artists" ] firstObject];
        self.artistIdentifier = [artistDic objectForKey:@"id"];
        self.artistname = [artistDic objectForKey:@"name"];
        
        self.logoname = [artistDic objectForKey:@"img1v1Url"];
        
    }
    return self;
}



@end
