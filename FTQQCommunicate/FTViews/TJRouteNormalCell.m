//
//  TJRouteNormalCell.m
//  FTQQCommunicate
//
//  Created by 方焘 on 2018/3/27.
//  Copyright © 2018年 taofang. All rights reserved.
//

#import "TJRouteNormalCell.h"
#import "TJRouteNormalModel.h"

@interface TJRouteNormalCell ()
@property (nonatomic, strong) UIImageView *background;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UILabel *roomNumber;

@property (nonatomic, strong) UILabel *onLineNumber;

@property (nonatomic, strong) UIImageView *bottomIcon;

@property (nonatomic, strong) UILabel *bottomLabelGray;

@property (nonatomic, strong) UILabel *bottomLabelGold;

@end

@implementation TJRouteNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.background = [[UIImageView alloc]init];
    [self.contentView addSubview:self.background];
    self.background.layer.cornerRadius = 6;
    self.background.layer.masksToBounds = YES;
    
    self.bottomLineView = [[UIView alloc]init];
    [self.background addSubview:self.bottomLineView];
    self.bottomLineView.backgroundColor = [UIColor blackColor];
    
    self.roomNumber = [[UILabel alloc]init];
    self.roomNumber.font = [UIFont systemFontOfSize:32 *[TJAdaptiveManager adaptiveScale]];
    self.roomNumber.textColor = [UIColor whiteColor];
    [self.background addSubview:self.roomNumber];
    
    self.onLineNumber = [[UILabel alloc]init];
    self.onLineNumber.textColor = UIColorFromRGB(0xbacff5);
    self.onLineNumber.font = [UIFont systemFontOfSize:16 * [TJAdaptiveManager adaptiveScale]];
    [self.background addSubview:self.onLineNumber];
    
    self.bottomIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"speaker"]];
    [self.bottomLineView  addSubview:self.bottomIcon];
    
    self.bottomLabelGray = [[UILabel alloc]init];
    self.bottomLabelGray.textColor  = [UIColor grayColor];
    self.bottomLabelGray.text = @"恭喜玩家 131****8902 赢得";
    self.bottomLabelGray.font = [UIFont systemFontOfSize:11 * [TJAdaptiveManager adaptiveScale]];
    [self.background addSubview:self.bottomLabelGray];
    
    self.bottomLabelGold = [[UILabel alloc]init];
    self.bottomLabelGold.text = @"12893金币";
    self.bottomLabelGold.font = [UIFont systemFontOfSize:11 * [TJAdaptiveManager adaptiveScale]];
    self.bottomLabelGold.textColor = UIColorFromRGB(0xf19e47);
    [self.background addSubview:self.bottomLabelGold];
}

- (void)setupLayoutSubviews {
    
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_offset(TJSystem2Xphone6Width(24));
        make.right.mas_offset(- TJSystem2Xphone6Width(24));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.background);
        make.height.equalTo(@(TJSystem2Xphone6Height(50)));
    }];
    
    
    [self.onLineNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(TJSystem2Xphone6Width(40));
        make.bottom.equalTo(self.bottomLineView).mas_offset(- TJSystem2Xphone6Height(84));
    }];
    
    [self.roomNumber mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.onLineNumber);
        make.bottom.mas_offset(- TJSystem2Xphone6Height(136));
    }];
    
    [self.bottomIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.bottomLineView);
        make.left.mas_offset(TJSystem2Xphone6Width(40));
    }];
    
    [self.bottomLabelGray mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_offset(TJSystem2Xphone6Width(84));
        make.centerY.equalTo(self.bottomLineView);
    }];
    
    [self.bottomLabelGold mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.bottomLabelGray.mas_right);
        make.centerY.equalTo(self.bottomLineView);
    }];
}

- (void)setupViewWithModel:(TJRouteNormalModel *)model {
    self.roomNumber.text = model.roomName;
    self.onLineNumber.text = [NSString stringWithFormat:@"%@人在线", model.onLineNumber];
    self.background.image = [UIImage imageNamed:model.backgroundImgName];
}
@end
