//
//  FTCommunicaTionFrame.m
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "FTCommunicaTionFrame.h"
#import "FTCommunicationModel.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height
#define KMARGIN 10
@implementation FTCommunicaTionFrame
-(instancetype)initWithModel:(FTCommunicationModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
+ (instancetype)frameWithModel:(FTCommunicationModel *)model {
    
    return [[self alloc]initWithModel:model];
    
}
-(void)setModel:(FTCommunicationModel *)model {
    _model = model;
    //timeLable的rect
    CGRect timeLableSize = [model.time boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    //timeLabel的Frame 居中处理
    self.timeLableFrame = CGRectMake(KWIDTH / 2 - timeLableSize.size.width / 2, 0, timeLableSize.size.width, timeLableSize.size.height);
    
    //头像iamgeView的Frame
    _userIconImageViewFrame.origin.y = CGRectGetMaxY(self.timeLableFrame) + KMARGIN;
    _userIconImageViewFrame.size = CGSizeMake(55, 55);
    if (model.type == 0) {
        _userIconImageViewFrame.origin.x = KMARGIN;
    } else {
        _userIconImageViewFrame.origin.x = KWIDTH - self.userIconImageViewFrame.size.width - KMARGIN;
    }
    
    //messageLable 的size
    CGRect messageLableSize = [model.text boundingRectWithSize:CGSizeMake(KWIDTH - (self.userIconImageViewFrame.size.width + KMARGIN * 2) * 3, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    //messageLable 的frame                                          为拉伸增加2个margin
    _messageButtonFrame.size.height = messageLableSize.size.height + KMARGIN * 4;
    _messageButtonFrame.size.width = messageLableSize.size.width + KMARGIN * 4;
    _messageButtonFrame.origin.y = CGRectGetMaxY(self.timeLableFrame) + KMARGIN * 2;
    if (model.type == FTCommunicationModelMe) {
        _messageButtonFrame.origin.x = CGRectGetMaxX(self.userIconImageViewFrame) + KMARGIN * 2;
    } else {
        _messageButtonFrame.origin.x = CGRectGetMidX(self.userIconImageViewFrame) - self.messageButtonFrame.size.width - KMARGIN * 4;
    }
    
    CGRect nameLabelSize = [model.name boundingRectWithSize:CGSizeMake((DEVICE_SCREEN_WIDTH / 3), MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    _nameLabelFrame.size = nameLabelSize.size ;
    _nameLabelFrame.origin.y = CGRectGetMaxY(self.timeLableFrame);
    if (model.type == FTCommunicationModelMe) {
        _nameLabelFrame.origin.x = CGRectGetMaxX(self.userIconImageViewFrame) + KMARGIN * 2;
    } else {
        _nameLabelFrame.origin.x = CGRectGetMidX(self.userIconImageViewFrame) - self.messageButtonFrame.size.width - KMARGIN * 4;
    }
    
    
    //行高
   self.rowHeight = (CGRectGetMaxY(self.userIconImageViewFrame) > CGRectGetMaxY(self.messageButtonFrame) ? CGRectGetMaxY(self.userIconImageViewFrame) : CGRectGetMaxY(self.messageButtonFrame)) + KMARGIN * 2;
    
    
    //cellframe
    self.cellFrame = CGRectMake(0, 0, KWIDTH, self.rowHeight);
}

@end
