//
//  SGMQTTChangeState.m
//  SGMQTT
//
//  Created by sungrow on 2020/4/9.
//

#import "SGMQTTChangeState.h"

@implementation SGMQTTChangeState

- (instancetype)initWithLabel:(NSString *)label handler:(SGMQTTDidChangeStateHandler)handler; {
    if (self = [super init]) {
        self.label = label;
        self.handler = handler;
    }
    return self;
}

@end
