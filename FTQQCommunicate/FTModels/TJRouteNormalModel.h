//
//  TJRouteNormalModel.h
//  FTQQCommunicate
//
//  Created by 方焘 on 2018/3/27.
//  Copyright © 2018年 taofang. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJRouteNormalModel : TJBaseModel
/**房间号*/
@property (nonatomic, copy) NSString *roomName;

/**在线人数*/
@property (nonatomic, copy) NSString *onLineNumber;

/**背景图*/
@property (nonatomic, copy) NSString *backgroundImgName;
@end
