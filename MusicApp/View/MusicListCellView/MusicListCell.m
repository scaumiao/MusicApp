//
//  MusicListCesllTableViewCell.m
//  测试搜索栏卡顿
//
//  Created by 许汝邈 on 15/9/29.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicListCell.h"

#define NJNameFont [UIFont systemFontOfSize:13]
#define NJTextFont [UIFont systemFontOfSize:16]


@implementation MusicListCell






+(instancetype)cellWithTableView:(UITableView *)tableView andIdentify:(NSString *)identify
{
    
    // NSLog(@"cellForRowAtIndexPath");
  
    // 1.缓存中取
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    // 2.创建
    if (cell == nil) {
        cell = [[MusicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
    
    
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 让自定义Cell和系统的cell一样, 一创建出来就拥有一些子控件提供给我们使用
        // 1.歌曲名字
        UILabel *songNameLabelView = [[UILabel alloc] init];
        
        [self addSubview:songNameLabelView];
        self.songNameLabelView = songNameLabelView;
        self.songNameLabelView.font = [UIFont boldSystemFontOfSize:14];
        
        //2.创建作者
        UILabel *userNameLabelView = [[UILabel alloc] init];
        [self.contentView addSubview:userNameLabelView];
        //userNameLabelView.numberOfLines = 0;
        self.userNameLabelView = userNameLabelView;
        self.userNameLabelView.font = [UIFont systemFontOfSize:13];
        
        // 3.创建专辑名字
        UILabel *albumNameLabelView = [[UILabel alloc] init];
        albumNameLabelView.font = NJNameFont;
        // nameLabel.backgroundColor = [UIColor redColor];
        albumNameLabelView.numberOfLines = 0;
        [self.contentView addSubview:albumNameLabelView];
        self.albumNameLabelView = albumNameLabelView;
        
        
        //4.创建下拉菜单
        MusicListTool *musicListTool = [[MusicListTool alloc] init];
        self.moreView = musicListTool;
        
        
 /*
        // 4.创建作者
        UILabel *authorLabelView = [[UILabel alloc] init];
        [self.contentView addSubview:authorLabelView];
        self.authorLabelView = authorLabelView;
        
        
        // 5.创建正文
        UILabel *textLabelView = [[UILabel alloc] init];
        textLabelView.font = NJTextFont;
        textLabelView.numberOfLines = 0;
        // introLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:textLabelView];
        self.textLabelView = textLabelView;
*/
        
    }
    return self;
}

-(void)setMusicListFrame:(MusicListFrame *)musicListFrame
{
    _musicListFrame = musicListFrame;
    
    // 1.给子控件赋值数据
    [self settingData];
    // 2.设置frame
    [self settingFrame];
    
}



/**
 *  设置子控件的数据
 */
- (void)settingData
{
    MusicData *musicData = self.musicListFrame.musicData;
    
    // 设置歌名
    self.songNameLabelView.text = musicData.trackname;
 
    //设置作者
    self.userNameLabelView.text = musicData.artistname;
    // 设置专辑名
    self.albumNameLabelView.text = musicData.albumname;
   
   

    }
/**
 *  设置子控件的frame
 */
- (void)settingFrame
{
    
    // 设置标题的frame
    self.songNameLabelView.frame = self.musicListFrame.songNameF;
    
    //    设置头像为圆形的
    //    _iconView.layer.cornerRadius = self.iconView.frame.size.width / 2;
    //    _iconView.clipsToBounds = YES;
    

    
    // 设置作者的frame
    self.userNameLabelView.frame = self.musicListFrame.userNameF;
    
    // 设置专辑名的frame
    self.albumNameLabelView.frame = self.musicListFrame.albumNameF;
    

    self.moreView.frame = self.musicListFrame.moreF;
    self.moreView.backgroundColor = [UIColor darkGrayColor];
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}




@end
