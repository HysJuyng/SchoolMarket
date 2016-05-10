/*
 广告web view
 */

#import <UIKit/UIKit.h>

@interface AdvertWebView : UIView 

/**
 *  广告web
 */
@property (nonatomic,weak) UIWebView *advertWebView;



/**
 *  设置链接
 *
 *  @param link 链接
 */
- (void)setAdvertWebLink:(NSString*)link;

@end
