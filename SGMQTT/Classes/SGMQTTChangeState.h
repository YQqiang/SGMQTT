//
//  SGMQTTChangeState.h
//  SGMQTT
//
//  Created by sungrow on 2020/4/9.
//

#import <Foundation/Foundation.h>
#import <MQTTClient/MQTTClient.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SGMQTTDidChangeStateHandler)(MQTTSessionManager *sessionManager, MQTTSessionManagerState newState);

@interface SGMQTTChangeState : NSObject

@property (nonatomic, copy) NSString *label;

@property (nonatomic, copy) SGMQTTDidChangeStateHandler handler;

- (instancetype)initWithLabel:(NSString *)label handler:(SGMQTTDidChangeStateHandler)handler;

@end

NS_ASSUME_NONNULL_END
