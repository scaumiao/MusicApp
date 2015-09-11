//
//  Music.h
//  MusicApp
//
//  Created by 许汝邈 on 15/9/10.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicList.h"
typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface Music : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (assign, nonatomic, getter=isGay) BOOL gay;
@end


