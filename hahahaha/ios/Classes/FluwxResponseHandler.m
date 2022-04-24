//
//  FluwxResponseHandler.m
//  Pods-Runner
//
//  Created by NWBSSJMNF on 2022/4/24.
//

#import "FluwxResponseHandler.h"
#import "FluwxStringUtil.h"

@implementation FluwxResponseHandler

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    static FluwxResponseHandler *instance;
    dispatch_once(&onceToken, ^{
        instance = [[FluwxResponseHandler alloc] init];
    });
    return instance;
}

FlutterMethodChannel *fluwxMethodChannel = nil;

- (void)setMethodChannel:(FlutterMethodChannel *)flutterMethodChannel {
    fluwxMethodChannel = flutterMethodChannel;
}

#pragma mark - WXApiDelegate

- (void)onResp:(WWKBaseResp *)resp {
    /*! @brief 所有通过sendReq发送的SDK请求的结果都在这个函数内部进行异步回调
     * @param resp SDK处理请求后的返回结果 需要判断具体是哪项业务的回调
     */
    
    /* SSO的回调 */
    if ([resp isKindOfClass:[WWKSSOResp class]]) {
        WWKSSOResp *authResp = (WWKSSOResp *)resp;
        NSDictionary *result = @{
            @"code": [FluwxStringUtil nilToEmpty:authResp.code],
            @"state": [FluwxStringUtil nilToEmpty:authResp.state]
        };
        [fluwxMethodChannel invokeMethod:@"onAuthResponse" arguments:result];
    }
}

@end
