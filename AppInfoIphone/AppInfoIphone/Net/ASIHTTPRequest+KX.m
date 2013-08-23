//
//  ASIHTTPRequest+KX.m
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import "ASIHTTPRequest+KX.h"
#import "KXNotifications.h"

@implementation ASIHTTPRequest (ASIHTTPRequest_KX)

- (void)processResponse
{
    // To be overridden by subclasses
}

- (NSString *)validateResponse
{
    NSInteger statusCode = self.responseStatusCode;
    NSString *errorMessage = nil;
    
    switch (statusCode)
    {
        case 200:
        case 201:
        {
            break;
        }
            
        case 302:
        case 401:
        {
            // In the case of FFCRM, bad login API requests receive a 302,
            // with a redirection body taking to the login form
            errorMessage = @"Unauthorized";
            break;
        }
            
        case 404:
        {
            errorMessage = @"The specified path cannot be found (404)";
            break;
        }
            
        case 500:
        {
            errorMessage = @"The server experienced an error (500)";
            break;
        }
            
        default:
        {
            errorMessage = [NSString stringWithFormat:@"The communication with the server failed with error %d", statusCode];
            break;
        }
    }
    
    return errorMessage;
}

@end
