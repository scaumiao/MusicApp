//
//  MusicListFrame.m
//  测试搜索栏卡顿
//
//  Created by 许汝邈 on 15/9/29.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "MusicListFrame.h"
#define NJNameFont [UIFont systemFontOfSize:13]
#define NJTextFont [UIFont systemFontOfSize:16]

@implementation MusicListFrame

-(void)setMusicData:(MusicData *)musicData

{
    
    _musicData = musicData;
    // 间隙
    CGFloat xPadding = 20;
    CGFloat yPadding = 10;
    // 设置歌名的frame
    CGFloat songViewX = xPadding;
    CGFloat songViewY = yPadding;
    CGFloat songViewW = _musicData.trackname.length * 14;
    CGFloat songViewH = 14;
    self.songNameF = CGRectMake(songViewX, songViewY, songViewW, songViewH);
    

    
    
    //设置歌手的frame
    CGFloat userNameViewX = xPadding;
    CGFloat userNameViewY = songViewH + yPadding;
    //    CGSize userNameSize =  [self sizeWithString:_article.userName font:NJTextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    CGFloat userNameViewH = 20;
    
    CGFloat userNameViewW = _musicData.artistname.length * 13;
 
    self.userNameF = CGRectMake(userNameViewX, userNameViewY, userNameViewW, userNameViewH);
    
    //设置专辑名字的frame
    if (self.musicData.albumname.length > 14) {
        CGFloat albumNameViewX =  userNameViewX;
        CGFloat albumNameViewY = CGRectGetMaxY(self.userNameF);
        CGSize albumNameSize =  [self sizeWithString:_musicData.albumname font:NJNameFont maxSize:CGSizeMake(280, MAXFLOAT)];
        CGFloat albumNameViewW = albumNameSize.width;
        CGFloat albumNameViewH = albumNameSize.height;
        self.albumNameF = CGRectMake(albumNameViewX, albumNameViewY, albumNameViewW, albumNameViewH);
    }
    else
    {
        CGFloat albumNameViewX =  CGRectGetMaxX(self.userNameF) + yPadding;
        CGFloat albumNameViewY = userNameViewY ;
        CGFloat albumNameViewW = _musicData.albumname.length * 13;
        CGFloat albumNameViewH = 20;
        self.albumNameF = CGRectMake(albumNameViewX, albumNameViewY, albumNameViewW, albumNameViewH);
    }

    CGFloat moreViewX = 0;
    CGFloat moreViewY = CGRectGetMaxY(_albumNameF) +10 ;
    CGFloat moreViewH = 44;
    CGFloat moreViewW = 380;
    
    self.moreF = CGRectMake(moreViewX, moreViewY, moreViewW, moreViewH);
    
    
    
    self.cellHeight = CGRectGetMaxY(self.albumNameF) + yPadding;
    
    
    
//    //设置内容的frame
//    // 设置正文的frame
//    CGFloat textX = titleViewX;
//    CGFloat textY = CGRectGetMaxY(self.titleF) + padding;
//    CGSize textSize =  [self sizeWithString:_article.text font:NJTextFont maxSize:CGSizeMake(290, MAXFLOAT)];
//    
//    CGFloat textW = textSize.width;
//    CGFloat textH = textSize.height;
//    
//    self.textF = CGRectMake(textX, textY, textW , textH);
//    
//    //设置每行的高度，返回给tableView的height

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
