#define ZQAppKey @"2185175942"
#define ZQAppSecret @"6876d271f6f25cf47b567ef7615c28af"
#define ZQRedirectURI @"http://www.baidu.com"
#define ZQLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", ZQAppKey, ZQRedirectURI]

#define ZQPostSuccessNotificationName @"ZQPostSuccessNotificationName"

/** 昵称的字体 */
#define ZQStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define ZQRetweetStatusNameFont ZQStatusNameFont

/** 时间的字体 */
#define ZQStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define ZQStatusSourceFont ZQStatusTimeFont

/** 正文的字体 */
#define ZQStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define ZQRetweetStatusContentFont ZQStatusContentFont

#define ZQCellMargin 10
#define ZQCellBorder 5

#define ZQPhotoW 70
#define ZQPhotoH 70
#define ZQPhotoMargin 10

#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import "UIImage+ZQ.h"
    #import "ZQAccountTool.h"
    #import "ZQRootVCTool.h"
    #define iOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
    #define ZQColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#endif

#ifdef DEBUG
#define ZQLog(...) NSLog(__VA_ARGS__)
#else
#define ZQLog(...)
#endif