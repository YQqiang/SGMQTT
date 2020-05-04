//
//  SGMQTTSubscribe.h
//  SGMQTT
//
//  Created by sungrow on 2020/4/9.
//

#import <Foundation/Foundation.h>
#import <MQTTClient/MQTTClient.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SGMQTTReceiveDataHandler)(MQTTSessionManager *sessionManager, NSData *data, NSString *topic, BOOL retained);

@interface SGMQTTSubscribe : NSObject

@property (nonatomic, copy) NSString *topic;

@property (nonatomic, assign) MQTTQosLevel qos;

@property (nonatomic, copy) SGMQTTReceiveDataHandler handler;

@property (nonatomic, strong, readonly)NSDictionary<NSString *, NSNumber *> *subscription;

- (instancetype)initWithTopic:(NSString *)topic qos:(MQTTQosLevel)qos handler:(SGMQTTReceiveDataHandler)handler;

- (BOOL)containsOtherTopic:(NSString *)other;

+ (NSArray <NSString *>*)topics:(NSString *)topic;
+ (BOOL)topic:(NSString *)topic containsOther:(NSString *)other;

@end

NS_ASSUME_NONNULL_END
