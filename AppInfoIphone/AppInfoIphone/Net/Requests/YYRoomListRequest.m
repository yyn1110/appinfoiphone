//
//  YYRoomListRequest.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYRoomListRequest.h"

@implementation YYRoomListRequest
static NSString *kFLEFTLIST_REQUEST = @"/roomlist";
+(id)requestWithUID:(NSNumber *)uid
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareManager].kServerURL,kFLEFTLIST_REQUEST];
    NSURL *url = [NSURL URLWithString:urlString];
    YYRoomListRequest *request = [self requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setShouldRedirect:NO];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setPostValue:uid forKey:@"uid"];
    for (int i=0; i<[request.deviceInfo allKeys].count; i++) {
        NSArray *allkeys= [request.deviceInfo allKeys];
        NSString *key = allkeys[i];
        [request setPostValue:request.deviceInfo[key]  forKey:key];
    }
   
    return request;
}
- (void)processResponse
{
    DLog(@"%@",    self.requestHeaders);
    RoomListEntity *entity = [[RoomListEntity alloc] init];
    RoomListEntity *info = [self parseJson:entity];
    if (info) {
        NSMutableDictionary *responseDic = [NSMutableDictionary dictionaryWithCapacity:10];
        NSDictionary *results = info.responseInfo[@"Results"];

        NSArray *allkey = results.allKeys;
        for (int i=0; i<allkey.count; i++) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
            NSString *key  = allkey[i];
            NSArray *books = results[key];
            for (int j=0; j<books.count; j++) {
                NSDictionary *bookdic = books[j];
                BookInfoEntity *book = [[BookInfoEntity alloc] init];
                book.BookID = bookdic[@"BookID"];
                book.BookIntr = bookdic[@"BookIntr"];
                book.BookName = bookdic[@"Name"];
                [array addObject:book];
            }
            [responseDic setObject:array forKey:key];
        }
        info.Results = responseDic;
        [[NSNotificationCenter defaultCenter] postNotificationName:KXRoomListNotification object:info];
    }

}
@end
