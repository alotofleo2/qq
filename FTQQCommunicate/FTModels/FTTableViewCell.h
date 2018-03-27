//
//  FTTableViewCell.h
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTCommunicationModel;
@class FTCommunicaTionFrame;
@interface FTTableViewCell : UITableViewCell
//数据模型
@property (strong, nonatomic) FTCommunicationModel *communicationModel;

//frame模型
@property (strong, nonatomic) FTCommunicaTionFrame *frameModel;


/**
 *  判断重用以后再决定是否创建对象
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
