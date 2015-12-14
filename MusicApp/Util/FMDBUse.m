//
//  FMDBUse.m
//  MusicApp
//
//  Created by 许汝邈 on 15/11/16.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "FMDBUse.h"

@implementation FMDBUse


+(void)saveByMusicId:(NSString *)musicId lyric:(NSString *)lyric musicName:(NSString *)musicName
{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"tmp.sqlite"];
    NSLog(@"%@",dbpath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbpath];
    
    if (![db open]) {
        NSLog(@"error");
        return ;
    }
    
    //为数据库设置缓存提高查询效率
    [db setShouldCacheStatements:YES];
    
    //监测表是否存在
    if (![db tableExists:@"music"]) {
        
        [db executeUpdate:@"create table music(music_id INTEGER  , music_name TEXT, music_lyric TEXT); "];
        
    }
    
    NSString *sql = @"insert into music (music_id, music_name, music_lyric) values (?, ?, ?)";
  
    [db executeUpdate:sql,musicId,musicName,lyric];

    [db close];
}

+(NSMutableArray *)findNameByMusicId:(NSString *)musicId
{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"tmp.sqlite"];
   // NSLog(@"%@",dbpath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbpath];
    
    if (![db open]) {
        NSLog(@"error");
        NSMutableArray *array;
        return array;
    }
    
    //为数据库设置缓存提高查询效率
    [db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [db executeQuery:@"select music_name, music_lyric from music where music_id = ?",musicId];
    
    NSMutableArray *array = [NSMutableArray array];
    
    while ([rs next]) {
        NSString *musicLyric = [rs stringForColumn:@"music_lyric"];
        NSString *musicName = [rs stringForColumn:@"music_name"];
        
        [array addObject:musicName];
        [array addObject:musicLyric];
        
    }
    //NSString *musicName = [rs stringForColumn:@"music_name"];

   

    
    [rs close];
    [db close];
    return array;
    
}

@end
