//
//  SGMQTTManage.h
//  SGMQTT
//
//  Created by sungrow on 2020/4/8.
//

#import <Foundation/Foundation.h>
#import <SGMQTT/SGMQTTManageBuilder.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGMQTTManage : NSObject

+ (instancetype)shared;

@property (nonatomic, copy, readonly) SGMQTTManage * (^host)(NSString *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^port)(NSInteger);
@property (nonatomic, copy, readonly) SGMQTTManage * (^tls)(BOOL);
@property (nonatomic, copy, readonly) SGMQTTManage * (^keepalive)(NSInteger);
@property (nonatomic, copy, readonly) SGMQTTManage * (^clean)(BOOL);
@property (nonatomic, copy, readonly) SGMQTTManage * (^auth)(BOOL);
@property (nonatomic, copy, readonly) SGMQTTManage * (^user)(NSString *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^pass)(NSString *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^will)(BOOL);
@property (nonatomic, copy, readonly) SGMQTTManage * (^willTopic)(NSString *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^willMsg)(NSData *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^willQos)(MQTTQosLevel);
@property (nonatomic, copy, readonly) SGMQTTManage * (^willRetainFlag)(BOOL);
@property (nonatomic, copy, readonly) SGMQTTManage * (^clientId)(NSString *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^securityPolicy)(MQTTSSLSecurityPolicy *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^certificates)(NSArray *);
@property (nonatomic, copy, readonly) SGMQTTManage * (^protocolLevel)(MQTTProtocolVersion);
@property (nonatomic, copy, readonly) SGMQTTManage * (^runLoop)(NSRunLoop *);

/// 重置配置信息
@property (nonatomic, copy, readonly) SGMQTTManage * (^reset)(void);

/// 连接
@property (nonatomic, copy, readonly) SGMQTTManage * (^connect)(MQTTConnectHandler);
/// 断开连接
@property (nonatomic, copy, readonly) SGMQTTManage * (^disConnect)(MQTTDisconnectHandler);

/// 订阅
@property (nonatomic, copy, readonly) SGMQTTManage * (^subscribe)(NSString *topic, MQTTQosLevel level, MQTTSubscribeHandler result, SGMQTTReceiveDataHandler receiveData);
/// 取消订阅
@property (nonatomic, copy, readonly) SGMQTTManage * (^unsubscribe)(NSString *topic, MQTTUnsubscribeHandler handler);

/// 发布数据
@property (nonatomic, copy, readonly) SGMQTTManage * (^publishData)(NSData *data, NSString *topic, BOOL retain, MQTTQosLevel qos, MQTTPublishHandler handler);
/// 接收数据监听
@property (nonatomic, copy, readonly) SGMQTTManage * (^addReceive)(NSString *label, SGMQTTReceiveDataHandler handler);
/// 移除接收数据监听
@property (nonatomic, copy, readonly) SGMQTTManage * (^removeReceive)(NSString *label);

/// 连接状态改变监听
@property (nonatomic, copy, readonly) SGMQTTManage * (^addChangeState)(NSString *label, SGMQTTDidChangeStateHandler handler);
/// 移除连接状态改变的监听
@property (nonatomic, copy, readonly) SGMQTTManage * (^removeChangeState)(NSString *label);

@end

NS_ASSUME_NONNULL_END
