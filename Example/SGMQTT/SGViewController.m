//
//  SGViewController.m
//  SGMQTT
//
//  Created by 1054572107@qq.com on 04/08/2020.
//  Copyright (c) 2020 1054572107@qq.com. All rights reserved.
//

#import "SGViewController.h"
#import <SGMQTT/SGMQTTManage.h>

@interface SGViewController ()
@property (weak, nonatomic) IBOutlet UITextView *msgTextView;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITextView *topicTextView;

@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SGMQTTManage.shared.addChangeState(@"test", ^(MQTTSessionManager * _Nonnull sessionManager, MQTTSessionManagerState newState) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-state=%@", @(newState)]];
    });
}

- (NSString *)currentTopic {
    return self.topicTextView.text;
}

- (IBAction)connectAction:(UIButton *)sender {
    SGMQTTManage.shared
    .host(@"demo.abc.com")
    .port(1883)
    .auth(YES)
    .user(@"user")
    .pass(@"123")
    .connect(^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-连接-%@", !error ? @"成功" : error]];
    });
}

- (IBAction)disconnectAction:(UIButton *)sender {
    SGMQTTManage.shared.disConnect(^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-断开-%@", !error ? @"成功" : error]];
    });
}

- (IBAction)sendMessageAction:(UIButton *)sender {
    NSData *data = [self.inputTextView.text dataUsingEncoding:NSUTF8StringEncoding];
    SGMQTTManage.shared.publishData(data, [self currentTopic], NO, MQTTQosLevelExactlyOnce, ^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-发送-%@", !error ? @"成功" : error]];
    });
}

- (IBAction)subscribeAction:(UIButton *)sender {
    SGMQTTManage.shared.subscribe([self currentTopic], MQTTQosLevelExactlyOnce, ^(NSError *error, NSArray<NSNumber *> *gQoss) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-订阅-%@", !error ? @"成功" : error]];
    }, ^(MQTTSessionManager * _Nonnull sessionManager, NSData * _Nonnull data, NSString * _Nonnull topic, BOOL retained) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-Data-%@; topic-%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], topic]];
    });
}
- (IBAction)unsubscribeAction:(UIButton *)sender {
    SGMQTTManage.shared.unsubscribe([self currentTopic], ^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"MQTT-取消订阅-%@", !error ? @"成功" : error]];
    });
}

- (void)showMessage:(NSString *)msg {
    self.msgTextView.text = msg;
}

- (IBAction)dismissKeyboardAction:(UIButton *)sender {
    [self.view endEditing:YES];
}

@end
