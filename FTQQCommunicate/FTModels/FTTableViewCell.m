//
//  FTTableViewCell.m
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "FTTableViewCell.h"
#import "FTCommunicaTionFrame.h"
#import "FTCommunicationModel.h"

@interface FTTableViewCell ()
//时间Lable
@property (strong, nonatomic) UILabel *timeLabel;

//头像图片
@property (strong, nonatomic) UIImageView *userIconImageView;

//messageLable
@property (strong, nonatomic) UIButton *messageButton;

@property (nonatomic, strong) UILabel *namelabel;

@end
@implementation FTTableViewCell


/**
 *  重写communicationModel的setter方法
 */
- (void)setCommunicationModel:(FTCommunicationModel *)communicationModel {
    _communicationModel = communicationModel;
    //设置时间
    self.timeLabel.text = self.communicationModel.time;
    //设置时间是否隐藏
    if (self.communicationModel.isTimeHidden) {
        self.timeLabel.hidden = YES;
    } else {
        self.timeLabel.hidden = NO;
    }
    self.namelabel.text = communicationModel.name;
    //设置头像
    self.userIconImageView.image = [UIImage imageNamed:communicationModel.iconImageName];
    //设置message
    [self.messageButton setTitle:self.communicationModel.text forState:UIControlStateNormal];
    
#pragma mark -- 背景图片拉伸
    //设置内边距
    self.messageButton.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    //设置聊天框背景
    if (self.communicationModel.type == 0) {
        UIImage *resizeImage = [UIImage imageNamed:@"chat_recive_nor"];
        //    UIImageResizingModeTile,  瓦片
        //UIImageResizingModeStretch,  拉伸
        //设置拉伸方式 1.填充方式
        UIImage *lastImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(resizeImage.size.height / 2, resizeImage.size.width / 2, resizeImage.size.height / 2, resizeImage.size.width / 2) resizingMode:(UIImageResizingModeStretch)];
        //设置nor图片
        [self.messageButton setBackgroundImage:lastImage forState:UIControlStateNormal];
        
        //pressed
        UIImage *resizeImagePress = [UIImage imageNamed:@"chat_recive_press_pic"];
        
        //设置拉伸方式 ---2.直接拉伸
        UIImage *lastImagePress = [resizeImagePress stretchableImageWithLeftCapWidth:resizeImagePress.size.width / 2 topCapHeight:resizeImagePress.size.height / 2];
        //设置press图片
        [self.messageButton setBackgroundImage:lastImagePress forState:UIControlStateHighlighted];
        
    } else {
        
        //normal
        UIImage *resizeImage = [UIImage imageNamed:@"chat_send_nor"];
        
        //设置拉伸方式
        UIImage *lastImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(resizeImage.size.height / 2, resizeImage.size.width / 2, resizeImage.size.height / 2, resizeImage.size.width / 2) resizingMode:(UIImageResizingModeStretch)];
        
        //设置nor图片
        [self.messageButton setBackgroundImage:lastImage forState:UIControlStateNormal];
        
        //pressed

       
        //设置拉伸方式
        //用了Assets中的可视化工具
        
        //设置press图片
        [self.messageButton setBackgroundImage:[UIImage imageNamed:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
        
    }
    
    
}

/**
 *  重写communicationFrame的Setter方法
 */
- (void)setFrameModel:(FTCommunicaTionFrame *)frameModel {
    _frameModel = frameModel;
    self.timeLabel.frame = frameModel.timeLableFrame;
    
    self.userIconImageView.frame = frameModel.userIconImageViewFrame;
    
    self.messageButton.frame = frameModel.messageButtonFrame;
    
    self.namelabel.frame = frameModel.nameLabelFrame;
}

//重写init
- (instancetype)init {
    if (self = [super init]) {
        //加载timeLabel
        self.timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        
        //加载iconImageView
        self.userIconImageView = [[UIImageView alloc]init];
        self.userIconImageView.layer.cornerRadius = 55 / 2;
        self.userIconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.userIconImageView];
        
        //加载messageLabel
        self.messageButton = [[UIButton alloc]init];
        [self.contentView addSubview:self.messageButton];
        self.messageButton.titleLabel.font = [UIFont systemFontOfSize:15];
        self.messageButton.titleLabel.numberOfLines = 0;
        [self.messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设cell背景颜色
        self.contentView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
        //加载nameLabel
        self.namelabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.namelabel];
        self.namelabel.textAlignment = NSTextAlignmentCenter;
        self.namelabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}
//快速创建对象
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"FTTableViewCell";
    
    FTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[self alloc]init];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
