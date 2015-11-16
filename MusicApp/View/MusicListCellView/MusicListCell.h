//
//  MusicListCesllTableViewCell.h
//  测试搜索栏卡顿
//
//  Created by 许汝邈 on 15/9/29.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicListFrame.h"
#import "MusicListTool.h"
@class MusicData;

@interface MusicListCell: UITableViewCell

@property (strong,nonatomic) MusicListFrame    *musicListFrame;

/**
 *  歌曲名字
 */
@property (nonatomic, weak ) UILabel         *songNameLabelView;
/**
 *  作者
 */
@property (nonatomic, weak ) UILabel         *userNameLabelView;
/**
 *  专辑名字
 */
@property (nonatomic, weak ) UILabel         *albumNameLabelView;

@property(nonatomic,strong)UILabel *moreLabelView;

//@property(nonatomic,strong)UIButton *downloadButton;


@property(nonatomic,strong)MusicListTool *moreView;

+(instancetype)cellWithTableView:(UITableView *)tableView andIdentify:(NSString *)identify;





//@property (nonatomic,copy ) NSString     *albumPic;//专辑图片路径
//@property (nonatomic,copy ) NSString     *songUrl;//歌曲地址


@end
