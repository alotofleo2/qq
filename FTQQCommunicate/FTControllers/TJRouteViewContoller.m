//
//  TJRouteViewContoller.m
//  FTQQCommunicate
//
//  Created by 方焘 on 2018/3/27.
//  Copyright © 2018年 taofang. All rights reserved.
//

#import "TJRouteViewContoller.h"
#import "TJBannerCell.h"
#import "TJHomeBannerModel.h"
#import "TJRouteNormalCell.h"
#import "TJRouteNormalModel.h"

@import SocketIO;
@interface TJRouteViewContoller ()
@property (nonatomic, strong) NSMutableArray *bannerModels;

@property (nonatomic, strong) NSMutableArray *roomModels;

@property (nonatomic, strong) SocketIOClient* socket;

@property (nonatomic, strong) SocketManager* manager;
@end

@implementation TJRouteViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
     [self registerCellWithClassName:@"TJHomeTopBannerCell" reuseIdentifier:@"TJHomeTopBannerCell"];
    [self registerCellWithClassName:@"TJRouteNormalCell" reuseIdentifier:@"TJRouteNormalCell"];
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + self.roomModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJBaseTableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeTopBannerCell" forIndexPath:indexPath];
        [cell setupViewWithModel:self.bannerModels];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TJRouteNormalCell" forIndexPath:indexPath];
        
        [cell setupViewWithModel:self.roomModels[indexPath.row - 1]];
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        return  TJSystem2Xphone6Height(250);
    } else {
        return TJSystem2Xphone6Height(274);
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc =  [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    [vc setValue:self.roomModels[indexPath.row - 1] forKey:@"roomModel"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)bannerModels {
    if (!_bannerModels) {
        _bannerModels = @[].mutableCopy;
        for (NSInteger i = 0; i < 3; i++) {
            TJHomeBannerModel *model = [[TJHomeBannerModel alloc]init];
            model.image = i==0 ? @"Group 27": @"bg1";
            
            [_bannerModels addObject:model];
        }
    }
    return _bannerModels;
}
- (NSMutableArray *)roomModels {
    if (!_roomModels) {
        _roomModels = [NSMutableArray arrayWithCapacity:2];
        TJRouteNormalModel *modelA = [[TJRouteNormalModel alloc]init];
        modelA.roomName = @"房间A";
        modelA.onLineNumber = @"1892";
        modelA.backgroundImgName = @"bg1";
        
        [_roomModels addObject:modelA];
        
        TJRouteNormalModel *modelB = [[TJRouteNormalModel alloc]init];
        modelB.roomName = @"房间B";
        modelB.onLineNumber = @"1892";
        modelB.backgroundImgName = @"Group 27";
        
        [_roomModels addObject:modelB];
    }
    return _roomModels;
}

- (void)requestTableViewDataSource {
    TJRequest *request = [[TJRequest alloc]init];
    
    request.requestType = TJHTTPReuestTypeGET;
    
    NSDictionary *params =@{@"type" : @"RoomBanner" };
    [request startWithURLString:@"api/banners" Params:params successBlock:^(TJResult *result) {
        NSLog(@"%@", result.data);
        
        
    } failureBlock:^(TJResult *result) {
        
        
        NSLog(@"%@", result.data);
    }];
    
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://192.168.31.163:3101"];
    self.manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @(1)}];
    self.socket = self.manager.defaultSocket;

    BLOCK_WEAK_SELF

    [self.socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
       [[self.socket emitWithAck:@"joinIreliaRoom" with:(@[@{@"room_id" : @1}])] timingOutAfter:0 callback:^(NSArray* data) {
           NSLog(@"%@", data);
           [weakSelf.socket emit:@"joinIreliaRoom" with:@[@{@"room_id" : @1}]];
       }];
    }];
    [self.socket on:@"irelia:room:message_received" callback:^(NSArray *data , SocketAckEmitter *ack ) {
        NSLog(@"%@", data);
    }];
    

    [self.socket connect];

    
}

@end
