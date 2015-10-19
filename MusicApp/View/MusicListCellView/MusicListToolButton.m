//
//  MusicListToolButton.m
//  MusicApp
//
//  Created by 许汝邈 on 15/10/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicListToolButton.h"

@implementation MusicListToolButton

-(void)layoutSubviews
{
 
    
    
    [super layoutSubviews];
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    CGRect frame = [self titleLabel].frame;
    frame.origin.x = 0;
    frame.origin.y = self.imageView.frame.size.height ;
    frame.size.width = self.frame.size.width;
    self.titleLabel.frame = frame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    
}

@end
