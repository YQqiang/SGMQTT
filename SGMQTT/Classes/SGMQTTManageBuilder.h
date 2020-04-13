//
//  SGMQTTManageBuilder.h
//  SGMQTT
//
//  Created by sungrow on 2020/4/8.
//

#import <Foundation/Foundation.h>
#import <SGMQTT/SGMQTTSubscribe.h>
#import <SGMQTT/SGMQTTChangeState.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGMQTTManageBuilder : NSObject

/// specifies the hostname or ip address to connect to. Defaults to @"localhost".
@property (nonatomic, copy) NSString *host;

/// specifies the port to connect to
@property (nonatomic, assign) NSInteger port;

/// specifies whether to use SSL or not
@property (nonatomic, assign) BOOL tls;

/// The Keep Alive is a time interval measured in seconds. The MQTTClient ensures that the interval between Control Packets being sent does not exceed the Keep Alive value. In the  absence of sending any other Control Packets, the Client sends a PINGREQ Packet.
@property (nonatomic, assign) NSInteger keepalive;

/// specifies if the server should discard previous session information.
@property (nonatomic, assign) BOOL clean;

/// specifies the user and pass parameters should be used for authenthication
@property (nonatomic, assign) BOOL auth;

/// an NSString object containing the user's name (or ID) for authentication. May be nil.
@property (nonatomic, copy) NSString *user;

/// an NSString object containing the user's password. If userName is nil, password must be nil as well.
@property (nonatomic, copy) NSString *pass;

/// indicates whether a will shall be sent
@property (nonatomic, assign) BOOL will;

/// the Will Topic is a string, may be nil
@property (nonatomic, copy) NSString *willTopic;

/// the Will Message, might be zero length or nil
@property (nonatomic, strong) NSData *willMsg;

/// specifies the QoS level to be used when publishing the Will Message.
@property (nonatomic, assign) MQTTQosLevel willQos;

///  indicates if the server should publish the Will Messages with retainFlag.
@property (nonatomic, assign) BOOL willRetainFlag;

/// The Client Identifier identifies the Client to the Server. If nil, a random clientId is generated
@property (nonatomic, copy) NSString *clientId;

/// A custom SSL security policy or nil.
@property (nonatomic, strong) MQTTSSLSecurityPolicy *securityPolicy;

/// An NSArray of the pinned certificates to use or nil.
@property (nonatomic, strong) NSArray *certificates;

/// Protocol version of the connection.
@property (nonatomic, assign) MQTTProtocolVersion protocolLevel;

/// Run loop for MQTTSession.
@property (nonatomic, strong) NSRunLoop *runLoop;

@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSNumber *> *subscriptions;

- (void)reset;

- (void)addSubscribe:(NSString *)topic qos:(MQTTQosLevel)qos handler:(SGMQTTReceiveDataHandler)handler;
- (void)removeSubscribe:(NSString *)topic;

- (void)addReceive:(NSString *)receive handler:(SGMQTTReceiveDataHandler)handler;
- (void)removeReceive:(NSString *)receive;

- (void)addChangeState:(NSString *)label handler:(SGMQTTDidChangeStateHandler)handler;
- (void)removeChangeState:(NSString *)label;

- (void)excuteReceiveDataHandlerSessionManager:(MQTTSessionManager *)sessionManager data:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained;
- (void)excuteDidChangeStateSessionManager:(MQTTSessionManager *)sessionManager newState:(MQTTSessionManagerState)newState;

@end

NS_ASSUME_NONNULL_END
