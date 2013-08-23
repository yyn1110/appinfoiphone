//
//  NSString+Utils.m
//  KXShow
//
//  Created by guo xiaojie on 11-5-5.
//  Copyright 2011年 kuxing.com. All rights reserved.
//

#import "NSData+Utils.h"

@implementation NSData (Utils)
- (NSString *)hexString
{
	NSUInteger capacity = [self length] * 2;
	NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
	const unsigned char *dataBuffer = [self bytes];
    
	for (NSUInteger i = 0; i < [self length]; ++i) {
		[stringBuffer appendFormat:@"%02X",(unsigned int)dataBuffer[i]];
	}
	return (stringBuffer ? stringBuffer : nil);
}
@end
