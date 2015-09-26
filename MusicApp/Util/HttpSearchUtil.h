//
//  HttpSearchUtil.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/14.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpSearchUtil : NSObject <NSURLConnectionDelegate>


//接收从服务器返回数据。

@property (strong,nonatomic) NSMutableData *datas;


-(NSDictionary *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg;




@end
