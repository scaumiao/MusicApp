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
//{
//    NSMutableDictionary* dict;
//}
@synthesize dict;



- (instancetype)init
{
    self = [super init];
    if (self) {
        _datas = [[NSMutableData alloc] init];
    }
    return self;
}

-(NSDictionary *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    
    
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10];
    
    [request setHTTPMethod: @"GET"];
    [request addValue: apikey forHTTPHeaderField: @"apikey"];
    
    
    
    NSURLConnection *connection = [[NSURLConnection alloc]  initWithRequest:request delegate:self];
    
    if (connection) {
        
        _datas = [NSMutableData new];
        
    }
    //NSLog(@"%@",_datas);
    //NSLog(@"%@",url);
//    NSDictionary *totalDic;
    
//    @try {
//        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//        totalDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//        //NSArray *array = [[[totalDic objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"list"];
//        
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
    
    //NSLog(@"%@",dict);
    return dict;

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



#pragma mark - 异步协议
-(void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
{
    [_datas appendData:data];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    
    NSLog(@"请求完成…");
    
    
    
    dict = [NSJSONSerialization JSONObjectWithData:_datas
            
                                           options:NSJSONReadingMutableLeaves error:nil];
    
   
   self.finishBlock(dict);
}


#pragma mark 添加Block版本
+(void) httpNsynchronousRequestUrl:(NSString*) spec  finshedBlock:(FinishBlock)block
{
    HttpSearchUtil *http = [[HttpSearchUtil alloc]init];
    http.finishBlock = block;
    //初始HTTP
    
    NSURL *url = [NSURL URLWithString:spec];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10];
    
    [request setHTTPMethod: @"GET"];
    [request addValue: apikey forHTTPHeaderField: @"apikey"];
    
    
    
    //连接
    NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:request delegate:http];
    NSLog(con ? @"连接创建成功" : @"连接创建失败");
}



@end
