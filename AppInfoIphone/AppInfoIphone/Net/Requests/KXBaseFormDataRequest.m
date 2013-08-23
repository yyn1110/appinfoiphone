//
//  KXBaseFormDataRequest.m
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import "KXBaseFormDataRequest.h"

@implementation KXBaseFormDataRequest
- (id)initWithURL:(NSURL *)newURL
{
    self = [super initWithURL:newURL]; 
    if (self) {
        [self setShouldRedirect:NO];
        [self setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self setTimeOutSeconds:10];
        [self addRequestHeader:@"Accept" value:@"text/json"];
        self.deviceInfo = [NSMutableDictionary dictionaryWithCapacity:2];
        NSString *curVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        float version = [curVersion floatValue];
       
        [self.deviceInfo setObject:[NSNumber numberWithFloat:version] forKey:@"version"];
        NSString *plat = [[UIDevice currentDevice] platformString];
        [self.deviceInfo setObject:@"ipad" forKey:@"DeviceSystemName"];
        [self.deviceInfo setObject:plat forKey:@"DevicePlat"];
        NSString *sysversion = [[UIDevice currentDevice] systemVersion];
        [self.deviceInfo setObject:sysversion forKey:@"SystemVersion"];

    }
    return self;
}
+ (BOOL)isNetOk
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case kNotReachable:
        {
            return NO;
        }
            break;
            
        default:
            break;
    }
    return YES;
}
+ (void)isNetOkShowInfo
{
    if (![KXBaseFormDataRequest isNetOk]) {
      //  [KXBaseFormDataRequest showError:@"网络异常,请检查网络。"];
    }
}
- (id)parseJson
{
    NSData *responseData = [self responseData];
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    DLog(@"httpResponseStr:%@",responseStr);
    NSDictionary *responseString = [responseStr objectFromJSONString];
    DLog(@"httpResponseDic:%@",responseString);
    if (responseString) {
        NSDictionary *responseInfo = [responseString objectForKey:@"ResponseInfo"];
        self.errorInfo = [[HttpResponseBaseEntity alloc] init];
        self.errorInfo.resultCode = [[responseInfo objectForKey:@"result"] intValue];
        self.errorInfo.msg = [responseInfo objectForKey:@"msg"];
        return responseInfo;
    } else {
        self.errorInfo = [[HttpResponseBaseEntity alloc] init];
        self.errorInfo.resultCode = -1000;
        self.errorInfo.msg = @"服务器异常！";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"服务器异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NULL;
    }
    return nil;

}

@end
