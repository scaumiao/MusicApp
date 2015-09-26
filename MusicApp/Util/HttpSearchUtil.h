//
//  HttpSearchUtil.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/14.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

// 相当于定义一个函数指针
typedef void (^FinishBlock)(NSDictionary *dataString);


@interface HttpSearchUtil : NSObject <NSURLConnectionDelegate>


//接收从服务器返回数据。

@property (strong,nonatomic) NSMutableData *datas;

@property (strong, nonatomic) FinishBlock finishBlock;//回调方法

//-(NSDictionary *)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg;


@property (strong,nonatomic) NSMutableDictionary* dict;




+(void)httpNsynchronousRequestUrl:(NSString*) spec  finshedBlock:(FinishBlock)block;

@end
