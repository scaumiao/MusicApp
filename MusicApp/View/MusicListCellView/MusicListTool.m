//
//  MusicListTool.m
//  MusicApp
//
//  Created by 许汝邈 on 15/10/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicListTool.h"
#define padding 10
@implementation MusicListTool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btn1 = [MusicListToolButton buttonWithType:UIButtonTypeSystem];
        _btn1.frame = CGRectMake(20, 0, 40, 40);
        [self setButton:_btn1 imageName:@"musiclisttool01.png" title:@"添加"];
        _btn1.tag = 1;
        [self addSubview:_btn1];
        
        _btn2 = [MusicListToolButton buttonWithType:UIButtonTypeSystem];
        _btn2.frame = CGRectMake(CGRectGetMaxX(_btn1.frame) + padding, 0, 40, 40);
         [self setButton:_btn2 imageName:@"musiclisttool02.png" title:@"下载"];
         _btn2.tag = 2;
        [self addSubview:_btn2];
        

        
        
        
        _btn3 = [MusicListToolButton buttonWithType:UIButtonTypeSystem];
        _btn3.frame = CGRectMake(CGRectGetMaxX(_btn2.frame)+padding, 0, 40, 40);
        [self setButton:_btn3 imageName:@"musiclisttool03.png" title:@"分享"];
         _btn3.tag = 3;
        [self addSubview:_btn3];
        
        
        _btn4 = [MusicListToolButton buttonWithType:UIButtonTypeSystem];
        _btn4.frame = CGRectMake(CGRectGetMaxX(_btn3.frame)+padding, 0, 40, 40);
         [self setButton:_btn4 imageName:@"musiclisttool04.png" title:@"歌手"];
         _btn4.tag = 4;
        [self addSubview:_btn4];
        
        _btn5 = [MusicListToolButton buttonWithType:UIButtonTypeSystem];
        _btn5.frame = CGRectMake(CGRectGetMaxX(_btn4.frame)+padding, 0, 40, 40);
         [self setButton:_btn5 imageName:@"musiclisttool05.png" title:@"专辑"];
         _btn5.tag = 5;
        [self addSubview:_btn5];
        
        
        _btn6 = [MusicListToolButton buttonWithType:UIButtonTypeSystem];
        _btn6.frame = CGRectMake(CGRectGetMaxX(_btn5.frame)+padding, 0, 40, 40);
         [self setButton:_btn6 imageName:@"musiclisttool06.png" title:@"喜欢"];
         _btn6.tag = 6;
        [self addSubview:_btn6];
         
    }
    return self;
}

-(void)setButton:(UIButton *)btn imageName:(NSString *)imgName title:(NSString *)title
{
    
    
    
    UIImage *image = [UIImage imageNamed:imgName];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    btn.imageEdgeInsets = UIEdgeInsetsMake(10.0, 10.0 , 0.0, 0.0);
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -10.0, 0.0, 0.0);
    
    
    
    
}

@end
