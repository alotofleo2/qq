//
//  FTCommunicaTionFrame.h
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FTCommunicationModel;
@interface FTCommunicaTionFrame : NSObject
//传入数据,重写它的setter方法,来完成frame的计算
/**
 *  要传入的数据
 */
@property (strong, nonatomic) FTCommunicationModel *model;
/**
 *  时间的frame
 */
@property (assign, nonatomic) CGRect timeLableFrame;
/**
 *  头像frame
 */
@property (assign, nonatomic) CGRect userIconImageViewFrame;

@property (nonatomic, assign) CGRect nameLabelFrame;
/**
 *  文字frame
 */
@property (assign, nonatomic) CGRect messageButtonFrame;
/**
 *  cell行高
 */
@property (assign, nonatomic) CGFloat rowHeight;
/**
 *  cell的Frame
 */
@property (assign, nonatomic) CGRect cellFrame;
- (instancetype)initWithModel:(FTCommunicationModel *)model;
+ (instancetype)frameWithModel:(FTCommunicationModel *)model;
@end
