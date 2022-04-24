//
//  FluwxResponseHandler.h
//  Pods-Runner
//
//  Created by NWBSSJMNF on 2022/4/24.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "WWKApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface FluwxResponseHandler : NSObject<WWKApiDelegate>

+ (instancetype)defaultManager;

- (void)setMethodChannel:(FlutterMethodChannel *)flutterMethodChannel;

@end

NS_ASSUME_NONNULL_END
