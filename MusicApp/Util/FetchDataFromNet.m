//
//  FetchDataFromNet.m
//  MusicApp
//
//  Created by 许汝邈 on 15/10/3.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "FetchDataFromNet.h"
#import "MusicData.h"
//定义网络路径
#define url @"http://music.163.com/api/search/get/web"
#define lyricUrl @"http://music.163.com/api/song/lyric"
//定义可以获取的歌曲数
#define kLimit 10
@implementation FetchDataFromNet

#pragma mark - 请求歌曲
+ (void)fetchMusicData:(NSString *)key page:(NSInteger)page limit:(NSInteger)limit callback:(fetchTrackDataAndError)callback{
    
    NSURL *musicURL = [NSURL URLWithString:url];
    //创建该路径下的请求，用来设置http头部中的参数和方法类型
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:musicURL];
    
    [request setValue:@"deflate,gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [request setValue:@"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)" forHTTPHeaderField:@"User-Agent"];

    [request setHTTPMethod:@"POST"];
    
    NSString *bodyString = [NSString stringWithFormat:@"s=%@&limit=%ld&offset=%ld&type=1",key,(long)limit,page * limit];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    //建立网络链接，发送异步请求；
  
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            callback(nil,page,connectionError);
        } else{
            //创建一个可变数组，用来存放解析后的歌曲
            NSMutableArray *trackMusicData = [NSMutableArray new];
            @try {
                //创建一个字典用来存储json格式解析后的数据
                NSDictionary *itemDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                //打印该字典，看其中的属性。
                //NSLog(@"%@",itemDictionary);
                //利用属性中的key获得歌曲的数组，也就获得了songs数组中的数据
                NSArray *itemArray = [[itemDictionary objectForKey:@"result"] objectForKey:@"songs"];
                //循环遍历讲歌曲初始化成MusicData的对象
                [itemArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    MusicData *data = [MusicData musicDataWithDic:obj];
                    if (data) {
                        [trackMusicData addObject:data];
                        
                    }
                }];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                //调用回调方法，将歌曲传给array
                callback(trackMusicData,page,nil);
            }
        }
    }];
    
}


#pragma mark - 请求歌词
+ (void)fetchMusicLyric:(NSString *)key  callback:(fetchTrackLyricAndError)callback
{
    NSURL *musicURL = [NSURL URLWithString:lyricUrl];
    //创建该路径下的请求，用来设置http头部中的参数和方法类型
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:musicURL];
    
    [request setValue:@"deflate,gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [request setValue:@"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)" forHTTPHeaderField:@"User-Agent"];

    [request setHTTPMethod:@"POST"];
    
    NSString *bodyString = [NSString stringWithFormat:@"os=pc&id=%@&lv=-1&kv=-1&tv=-1",key];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    //发送同步请求
    @try {
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *itemDictionary = [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:nil];
        NSString *itemString = [[itemDictionary objectForKey:@"lrc"] objectForKey:@"lyric"];
        callback(itemString,nil);
    }
    @catch (NSException *exception) {
        NSLog(@"什么错误来的%@",exception);
        callback(nil,nil);
    }
    @finally {
        
    }

    
    //建立网络链接，发送异步请求；
//    NSOperationQueue *queue = [NSOperationQueue new];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (connectionError) {
//            callback(nil,connectionError);
//        } else{
//       
//            
//            @try {
//                
//                NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//                        NSDictionary *itemDictionary = [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:nil];
//                        NSString *itemString = [[itemDictionary objectForKey:@"lrc"] objectForKey:@"lyric"];
//                callback(itemString,nil);
//            
//            }
//            @catch (NSException *exception) {
//                
//            }
//            @finally {
//               
//                
//            }
//        }
//    }];
    
}

@end
