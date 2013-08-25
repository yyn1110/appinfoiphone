//
//  KXNetworkManager.m
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import "KXNetworkManager.h"

#import "ASIHTTPRequest+KX.h"
#import "ASINetworkQueue.h"


@interface KXNetworkManager ()

@property (nonatomic, retain) ASINetworkQueue *networkQueue;

- (NSError *)createErrorWithMessage:(NSString *)string code:(NSInteger)code;
- (void)notifyError:(NSError *)error;

@end


@implementation KXNetworkManager
+ (KXNetworkManager *)sharedKXNetworkManager
{
    static KXNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KXNetworkManager alloc] init];
        //Do any other initialisation stuff here
    });
    return sharedInstance;
}
#pragma mark -
#pragma mark Init and dealloc

- (id)init
{
    if (self = [super init]) {
        self.networkQueue = [[ASINetworkQueue alloc] init] ;
        self.networkQueue.shouldCancelAllRequestsOnFailure = NO;
        [self.networkQueue setMaxConcurrentOperationCount:5];
        self.networkQueue.delegate = self;
        self.networkQueue.requestDidFinishSelector = @selector(requestDone:);
        self.networkQueue.requestDidFailSelector = @selector(requestWentWrong:);
        self.networkQueue.queueDidFinishSelector = @selector(queueFinished:);
        [self.networkQueue go];
    }
    return self;
}


- (void)cancelConnections
{
    [self.networkQueue cancelAllOperations];
}

#pragma mark - ASINetworkQueue delegate methods

- (void)requestDone:(KXBaseRequest *)request
{    DLog(@" requestDone = %@",request.responseString);

    NSString *errorMessage = [request validateResponse];
    if (errorMessage == nil) {
        [request processResponse];
    } else if (request.responseStatusCode == 302) {
        NSNotification *notif = [NSNotification notificationWithName:KXNetworkManagerDidFailLoginNotification
                                                              object:self
                                                            userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notif];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:errorMessage, NSLocalizedDescriptionKey, nil];
        NSError *error = [NSError errorWithDomain:@"Server"
                                             code:request.responseStatusCode
                                         userInfo:userInfo];
        [self notifyError:error];
    }
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
DLog(@" requestWentWrong = %@",request.responseString);
    NSError *error = [request error];
    [self notifyError:error];
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
}

#pragma mark - Error management

- (NSError *)createErrorWithMessage:(NSString *)text code:(NSInteger)code
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:text, NSLocalizedDescriptionKey, nil];
    NSError *error = [NSError errorWithDomain:@"Server"
                                         code:code
                                     userInfo:userInfo];
    return error;
}

- (void)notifyError:(NSError *)error
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:error, @"Error", nil];
    NSNotification *notif = [NSNotification notificationWithName:KXNetworkManagerDidFailWithErrorNotification
                                                          object:self
                                                        userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notif];
}


- (void)requestWithUID:(NSNumber *)uid
{
    id request = [YYRoomListRequest requestWithUID:uid];
    [self.networkQueue addOperation:request];
}



@end
