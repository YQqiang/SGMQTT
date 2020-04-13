# SGMQTT

[![CI Status](https://img.shields.io/travis/1054572107@qq.com/SGMQTT.svg?style=flat)](https://travis-ci.org/1054572107@qq.com/SGMQTT)
[![Version](https://img.shields.io/cocoapods/v/SGMQTT.svg?style=flat)](https://cocoapods.org/pods/SGMQTT)
[![License](https://img.shields.io/cocoapods/l/SGMQTT.svg?style=flat)](https://cocoapods.org/pods/SGMQTT)
[![Platform](https://img.shields.io/cocoapods/p/SGMQTT.svg?style=flat)](https://cocoapods.org/pods/SGMQTT)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SGMQTT is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SGMQTT'
```

## Usage

* Config

```Objective-C
SGMQTTManage.shared
.host(@"demo.abc.com")
.port(1883)
.auth(YES)
.user(@"user")
.pass(@"123");
```

* Connect

```Objective-C
SGMQTTManage.shared
.connect(^(NSError *error) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-连接-%@", !error ? @"成功" : error]];
});
```

* Disconnect

```Objective-C
SGMQTTManage.shared
.disConnect(^(NSError *error) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-断开-%@", !error ? @"成功" : error]];
});
```
* Subscribe

```Objective-C
SGMQTTManage.shared
.subscribe([self currentTopic], MQTTQosLevelExactlyOnce, ^(NSError *error, NSArray<NSNumber *> *gQoss) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-订阅-%@", !error ? @"成功" : error]];
}, ^(MQTTSessionManager * _Nonnull sessionManager, NSData * _Nonnull data, NSString * _Nonnull topic, BOOL retained) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-Data-%@; topic-%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], topic]];
});
```
* Unsubscribe

```Objective-C
SGMQTTManage.shared
.unsubscribe([self currentTopic], ^(NSError *error) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-取消订阅-%@", !error ? @"成功" : error]];
});
```
* PublishData

```Objective-C
SGMQTTManage.shared
.publishData(data, [self currentTopic], NO, MQTTQosLevelExactlyOnce, ^(NSError *error) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-发送-%@", !error ? @"成功" : error]];
});
```
* State

```Objective-C
SGMQTTManage.shared
.addChangeState(@"test", ^(MQTTSessionManager * _Nonnull sessionManager, MQTTSessionManagerState newState) {
    [self showMessage:[NSString stringWithFormat:@"MQTT-state=%@", @(newState)]];
});
```

## Author

yuqiang, yuqiang.coder@gmail.com

## License

SGMQTT is available under the MIT license. See the LICENSE file for more info.
