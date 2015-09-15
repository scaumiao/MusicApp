//
//  HttpSearchUtil.m
//  MusicApp
//
//  Created by 许汝邈 on 15/9/14.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "HttpSearchUtil.h"
#define apikey @"10c7516e0e5add013a854f3fc55fb3d8"//调用音乐搜索api的key

@implementation HttpSearchUtil



-(NSDictionary *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    
    
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: apikey forHTTPHeaderField: @"apikey"];
    
    
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *totalDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    NSArray *array = [[[totalDic objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"list"];
    return totalDic;
    
    
    
    //_searchDic = [[array objectAtIndex:0] copy];
    
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
     }];*/
    
    
}





@end
