//
//  MacroDefine.h
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//
#ifdef __KXDEBUG__

#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLog_object( arg ) NSLog( @"%s [Line %d] Object: %@", __PRETTY_FUNCTION__, __LINE__, arg );
#define DLog_int( arg ) NSLog( @"%s [Line %d] integer: %i", __PRETTY_FUNCTION__, __LINE__, arg );
#define DLog_float( arg ) NSLog( @"%s [Line %d] float: %f", __PRETTY_FUNCTION__, __LINE__, arg );
#define DLog_rect( arg ) NSLog( @"%s [Line %d] CGRect ( %f, %f, %f, %f)", __PRETTY_FUNCTION__, __LINE__, arg.origin.x, arg.origin.y, arg.size.width, arg.size.height );
#define DLog_point( arg ) NSLog( @"%s [Line %d] CGPoint ( %f, %f )", __PRETTY_FUNCTION__, __LINE__, arg.x, arg.y );
#define DLog_size( arg ) NSLog( @"%s [Line %d] CGSize ( %f, %f )", __PRETTY_FUNCTION__, __LINE__, arg.width, arg.height );
#define DLog_bool( arg )   NSLog( @"%s [Line %d] Boolean: %@", __PRETTY_FUNCTION__, __LINE__, ( arg == YES ? @"YES" : @"NO" ) );

#else

#define DLog(...)
#define DLog_object( arg )
#define DLog_int( arg )
#define DLog_rect( arg )
#define DLog_bool( arg )
#define DLog_point( arg )
#define DLog_float( arg )
#define DLog_size( arg )
#endif

#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define HOMEDIR NSHomeDirectory()
#define TMPDIR NSTemporaryDirectory()
#define DOCDIR [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CACHEDIR [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define DOWNLOADSDIR [CACHEDIR stringByAppendingPathComponent:@"Downloads"]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//#define LOCALSTR(str) NSLocalizedString(str, @"")
#define APPFRAME [[UIScreen mainScreen] applicationFrame]

//#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define LOCA(arg) NSLocalizedString(arg,nil)
//
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (NO)
#endif

