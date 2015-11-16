//
//  ViewController.m
//  MusicApp
//
//  Created by 许汝邈 on 15/9/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "ViewController.h"
#import "Music.h"
#define apikey @"10c7516e0e5add013a854f3fc55fb3d8"//调用音乐搜索api的key
@interface ViewController ()

@end

@implementation ViewController

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
  
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: apikey forHTTPHeaderField: @"apikey"];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *totalDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    NSArray *array = [[[totalDic objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"list"];
   
    _searchDic = [[array objectAtIndex:0] copy];
    
   /* [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", (long)responseCode);
                                   //                                   NSLog(@"HttpResponseBody %@",responseString);
                                   NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                  NSArray *array = [[[dic objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"list"];
                               
                                   _searchDic = [array objectAtIndex:0];
                                   // NSLog(@"%@",_searchDic);
                               }
                           }];异步*/
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title=@"记得";
    
    _searchDic = [NSDictionary dictionary];

    NSString *httpUrl = @"http://apis.baidu.com/geekery/music/query";
    NSString *str = [NSString stringWithFormat:@"s=%@&limit=1&p=1",title];
    NSString *httpArg = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self request: httpUrl withHttpArg: httpArg];
    
    MusicList *musicList = [MusicList objectWithKeyValues:_searchDic];
   NSLog(@"albumName=%@",musicList.albumName);
   // NSLog(@"%@",_searchDic);
    
}



@end
