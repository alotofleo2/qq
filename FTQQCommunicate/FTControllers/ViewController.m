//
//  ViewController.m
//  FTQQCommunicate
//
//  Created by 方焘 on 16/4/6.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "ViewController.h"
#import "FTCommunicationModel.h"
#import "FTTableViewCell.h"
#import "FTCommunicaTionFrame.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@import SocketIO;
@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/**
 *  数据model
 */
@property (strong, nonatomic) NSArray *communicationModels;
/**frameModels*/
@property (strong, nonatomic) NSArray *frameModels;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"加拿大";
    [self creatTableView];
    [self.view bringSubviewToFront:self.bottomView];
    self.bottomView.layer.cornerRadius = 5;
    self.bottomView.layer.masksToBounds = YES;
    //让光标右移
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.textField.leftView = view;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
    //textFidld 代理设置
    self.textField.delegate = self;
    
}

#pragma mark -- textFiled 代理事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //自己发送消息
    [self sendMessageWithType:(FTCommunicationModelMe) andMessage:textField.text];
    
    //别人发送消息
//    [self sendMessageWithType:FTCommunicationModelOther andMessage:[NSString stringWithFormat:@"%@ 别烦我,走开", textField.text]];
   
    //tablevie重载
    [self.tableView reloadData];
    //滚动到最后一个cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.communicationModels.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    
    //将文字清空
    textField.text = nil;
    return YES;
}

/**
 *  //发送消息的方法
 */
- (void)sendMessageWithType:(FTCommunicationTpye)type andMessage:(NSString *)message {
    //设置时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";
    NSString *currentTime = [formatter stringFromDate:date];
    
    //创建新的dic
    NSDictionary *dic = @{@"text":message, @"time":currentTime, @"type":@(type)};
    
    //设置是否隐藏
    FTCommunicationModel *model = [self.communicationModels lastObject];
    //暂存数组
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.communicationModels];
    //判断是否隐藏
    if ([dic[@"time"]isEqualToString:model.time] ) {
        [tempArr addObject:[[FTCommunicationModel alloc]initWithDic:dic]];
        [[tempArr lastObject] setTimeHidden:YES];
    } else {
        [tempArr addObject:[[FTCommunicationModel alloc]initWithDic:dic]];
    }
    
    self.communicationModels = tempArr;
    //让fraModels重新加载
    self.frameModels = nil;
    
    
}
#pragma mark -- 键盘通知
/**
 *  键盘显示和隐藏的回调方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)Notification {
    NSLog(@"%@",Notification);
    NSDictionary *dic = Notification.userInfo;
    //获取endFrame
    CGRect keyboardEndFrame = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算移动值
    CGFloat moveY = self.view.bounds.size.height - keyboardEndFrame.origin.y;
    
    //动画效果改变transform 如果移动值为0 因为是maketranslat  所以会回位
    [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0,- moveY);
    }];
    
}
#pragma mark -- tableView dataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//设置row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.communicationModels.count;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //运用封装好的方法判断重用 和创建
    FTTableViewCell *cell = [FTTableViewCell cellWithTableView:tableView];
    
    //设置model
    cell.frameModel = self.frameModels[indexPath.row];
    
    //设置frame
    cell.communicationModel = self.communicationModels[indexPath.row];
    
    return cell;
}
#pragma mark -- delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTCommunicaTionFrame *frameModel = self.frameModels[indexPath.row];
    return frameModel.rowHeight;
}
/**创建tableView */
- (void)creatTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - self.bottomView.frame.size.height) style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:tableView];
    //设置分割线样式
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置能否被点击
    self.tableView.allowsSelection = NO;
    
}

/**懒加载模型*/
- (NSArray *)communicationModels {
    if (_communicationModels == nil) {
        
        _communicationModels = [NSMutableArray arrayWithCapacity:0];
        _communicationModels = [FTCommunicationModel communicationWithFile:[[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil]];
    }
    return _communicationModels;
}
/**懒加载frame*/
- (NSArray *)frameModels {
    if (_frameModels == nil) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.communicationModels.count];
        for (FTCommunicationModel *model in self.communicationModels) {
            [tempArr addObject:[FTCommunicaTionFrame frameWithModel:model]];
        }
        _frameModels = tempArr;
    }
    return _frameModels;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)requestTableViewDataSource {
    NSURL* url = [[NSURL alloc] initWithString:@"http://192.168.31.163:3101/"];
    SocketManager* manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @YES, @"compress": @YES}];
    SocketIOClient* socket = manager.defaultSocket;
    
    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
    }];
    
    [socket on:@"irelia" callback:^(NSArray* data, SocketAckEmitter* ack) {
        //        double cur = [[data objectAtIndex:0] floatValue];
        
        [[socket emitWithAck:@"joinIreliaRoom" with:@[@(1)]] timingOutAfter:0 callback:^(NSArray* data) {
            [socket emit:@"joinIreliaRoom" with:data];
        }];
        
        [ack with:data];
    }];
    
    [socket connect];
}
@end
