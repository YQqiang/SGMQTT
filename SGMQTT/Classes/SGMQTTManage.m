//
//  SGMQTTManage.m
//  SGMQTT
//
//  Created by sungrow on 2020/4/8.
//

#import "SGMQTTManage.h"

@interface SGMQTTManage ()<MQTTSessionManagerDelegate>

@property (nonatomic, strong) MQTTSessionManager *manager;

@property (nonatomic, strong) SGMQTTManageBuilder *builder;

@end

@implementation SGMQTTManage

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (MQTTSessionManager *)manager {
    if (!_manager) {
        _manager = [[MQTTSessionManager alloc] init];
    }
    return _manager;
}

- (SGMQTTManageBuilder *)builder {
    if (!_builder) {
        _builder = [[SGMQTTManageBuilder alloc] init];
    }
    return _builder;
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))host {
    return ^SGMQTTManage *(NSString *host) {
        self.builder.host = host;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSInteger))port {
    return ^SGMQTTManage *(NSInteger port) {
        self.builder.port = port;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(BOOL))tls {
    return ^SGMQTTManage *(BOOL tls) {
        self.builder.tls = tls;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSInteger))keepalive {
    return ^SGMQTTManage *(NSInteger keepalive) {
        self.builder.keepalive = keepalive;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(BOOL))clean {
    return ^SGMQTTManage *(BOOL clean) {
        self.builder.clean = clean;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(BOOL))auth {
    return ^SGMQTTManage *(BOOL auth) {
        self.builder.auth = auth;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))user {
    return ^SGMQTTManage *(NSString *user) {
        self.builder.user = user;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))pass {
    return ^SGMQTTManage *(NSString *pass) {
        self.builder.pass = pass;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(BOOL))will {
    return ^SGMQTTManage *(BOOL will) {
        self.builder.will = will;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))willTopic {
    return ^SGMQTTManage *(NSString *willTopic) {
        self.builder.willTopic = willTopic;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSData * _Nonnull))willMsg {
    return ^SGMQTTManage *(NSData *willMsg) {
        self.builder.willMsg = willMsg;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(MQTTQosLevel))willQos {
    return ^SGMQTTManage *(MQTTQosLevel willQos) {
        self.builder.willQos = willQos;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(BOOL))willRetainFlag {
    return ^SGMQTTManage *(BOOL willRetainFlag) {
        self.builder.willRetainFlag = willRetainFlag;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))clientId {
    return ^SGMQTTManage *(NSString *clientId) {
        self.builder.clientId = clientId;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(MQTTSSLSecurityPolicy * _Nonnull))securityPolicy {
    return ^SGMQTTManage *(MQTTSSLSecurityPolicy *securityPolicy) {
        self.builder.securityPolicy = securityPolicy;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSArray * _Nonnull))certificates {
    return ^SGMQTTManage *(NSArray *certificates) {
        self.builder.certificates = certificates;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(MQTTProtocolVersion))protocolLevel {
    return ^SGMQTTManage *(MQTTProtocolVersion protocolLevel) {
        self.builder.protocolLevel = protocolLevel;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSRunLoop *))runLoop {
    return ^SGMQTTManage *(NSRunLoop *runLoop) {
        self.builder.runLoop = runLoop;
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(void))reset {
    return ^SGMQTTManage *(void) {
        [self.builder reset];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(MQTTConnectHandler _Nonnull))connect {
    return ^SGMQTTManage *(MQTTConnectHandler _Nonnull complete) {
        SGMQTTManageBuilder *builder = self.builder;
        self.manager.delegate = self;
        [self.manager connectTo:builder.host port:builder.port tls:builder.tls keepalive:builder.keepalive clean:builder.clean auth:builder.auth user:builder.user pass:builder.pass will:builder.will willTopic:builder.willTopic willMsg:builder.willMsg willQos:builder.willQos willRetainFlag:builder.willRetainFlag withClientId:builder.clientId securityPolicy:builder.securityPolicy certificates:builder.certificates protocolLevel:builder.protocolLevel connectHandler:complete];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(MQTTDisconnectHandler _Nonnull))disConnect {
    return ^SGMQTTManage *(MQTTDisconnectHandler _Nonnull complete) {
        [self.manager disconnectWithDisconnectHandler:complete];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull, MQTTQosLevel, MQTTSubscribeHandler _Nonnull, SGMQTTReceiveDataHandler _Nonnull))subscribe {
    return ^SGMQTTManage *(NSString * _Nonnull topic, MQTTQosLevel qos, MQTTSubscribeHandler result, SGMQTTReceiveDataHandler receiveData) {
        [self.builder addSubscribe:topic qos:qos handler:receiveData];
        self.manager.subscriptions = self.builder.subscriptions;
        NSError *error;
        if (![self.manager.subscriptions.allKeys containsObject:topic]) {
            error = [NSError errorWithDomain:@"SGMQTT.subscribe.error" code:2020040901 userInfo:@{}];
        }
        result(error, self.manager.subscriptions.allValues);
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull, MQTTUnsubscribeHandler _Nonnull))unsubscribe {
    return ^SGMQTTManage *(NSString * _Nonnull topic, MQTTUnsubscribeHandler handler) {
        [self.builder removeSubscribe:topic];
        self.manager.subscriptions = self.builder.subscriptions;
        NSError *error;
        if ([self.manager.subscriptions.allKeys containsObject:topic]) {
            error = [NSError errorWithDomain:@"SGMQTT.unsubscribe.error" code:2020040902 userInfo:@{}];
        }
        handler(error);
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull, SGMQTTReceiveDataHandler _Nonnull))addReceive {
    return ^SGMQTTManage *(NSString *label, SGMQTTReceiveDataHandler handler) {
        [self.builder addReceive:label handler:handler];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))removeReceive {
    return ^SGMQTTManage *(NSString *label) {
        [self.builder removeReceive:label];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull, SGMQTTDidChangeStateHandler _Nonnull))addChangeState {
    return ^SGMQTTManage *(NSString * _Nonnull label, SGMQTTDidChangeStateHandler handler) {
        [self.builder addChangeState:label handler:handler];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSString * _Nonnull))removeChangeState {
    return ^SGMQTTManage *(NSString * _Nonnull label) {
        [self.builder removeChangeState:label];
        return self;
    };
}

- (SGMQTTManage * _Nonnull (^)(NSData * _Nonnull, NSString * _Nonnull, BOOL, MQTTQosLevel, MQTTPublishHandler _Nonnull))publishData {
    return ^SGMQTTManage *(NSData * _Nonnull data, NSString * _Nonnull topic, BOOL retain, MQTTQosLevel qos, MQTTPublishHandler _Nonnull handler) {
        [self.manager.session publishData:data onTopic:topic retain:retain qos:qos publishHandler:handler];
        return self;
    };
}

#pragma mark - MQTTSessionManagerDelegate
- (void)sessionManager:(MQTTSessionManager *)sessionManager didReceiveMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    [self.builder excuteReceiveDataHandlerSessionManager:sessionManager data:data onTopic:topic retained:retained];
}

- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MQTTSessionManagerState)newState {
    [self.builder excuteDidChangeStateSessionManager:sessionManager newState:newState];
}

@end
