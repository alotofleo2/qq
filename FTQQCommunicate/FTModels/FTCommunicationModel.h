//
//  FTCommunicationModel.h
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    FTCommunicationModelMe = 0,
    FTCommunicationModelOther 
}FTCommunicationTpye;

@interface FTCommunicationModel : NSObject
@property (copy, nonatomic) NSString *text;

@property (copy, nonatomic) NSString *time;

@property (assign, nonatomic) FTCommunicationTpye type;

@property (strong, nonatomic) UIImage *userIconImage;

@property (assign ,nonatomic, getter = isTimeHidden) BOOL timeHidden;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *iconImageName;

/**初始化方法*/
- (instancetype)initWithDic:(NSDictionary *)dic NS_DESIGNATED_INITIALIZER;
/**快速创建方法*/
+ (instancetype)communicationWithDic:(NSDictionary *)dic;
/**快速创建model的的对象方法,参数为plist文件的地址*/
+ (NSArray *)communicationWithFile:(NSString *)path;
@end
