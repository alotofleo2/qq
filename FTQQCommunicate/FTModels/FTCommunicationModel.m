//
//  FTCommunicationModel.m
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "FTCommunicationModel.h"

@implementation FTCommunicationModel


/**
 *  userIconImage 的懒加载
 */
- (UIImage *)userIconImage{
    if (_userIconImage == nil) {
        if (self.type == FTCommunicationModelMe) {
            _userIconImage = [UIImage imageNamed:@"me"];
        } else if (self.type == FTCommunicationModelOther) {
            _userIconImage = [UIImage imageNamed:@"other"];
        }
        
    }
    return _userIconImage;
}

- (instancetype)init {
    return [self initWithDic:nil];
}
/**初始化方法*/
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
/**快速创建方法*/
+ (instancetype)communicationWithDic:(NSDictionary *)dic {
    return  [[self alloc]initWithDic:dic];
}
/**快速创建model的的对象方法,参数为plist文件的地址*/
+ (NSArray *)communicationWithFile:(NSString *)path {
    NSArray *plistArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:plistArr.count];
    for (NSDictionary *dic in plistArr) {
        FTCommunicationModel *model = [modelArr lastObject];
        //判断时间是否隐藏
        if ([dic[@"time"]isEqualToString:model.time] ) {
            [modelArr addObject:[[self alloc]initWithDic:dic]];
            [[modelArr lastObject] setTimeHidden:YES];
        } else {
            [modelArr addObject:[[self alloc]initWithDic:dic]];
        }
        
    }
    
    return modelArr;
}
@end
