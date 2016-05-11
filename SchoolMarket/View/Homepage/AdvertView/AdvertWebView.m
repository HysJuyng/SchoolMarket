/*
 广告web view
 */

#import "AdvertWebView.h"

@implementation AdvertWebView

/** 初始化*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //广告web
        UIWebView *tempwebview = [[UIWebView alloc] initWithFrame:self.frame];
        self.advertWebView = tempwebview;
        [self addSubview:self.advertWebView];
        self.advertWebView.scrollView.bounces = NO;  //反弹
        self.advertWebView.scalesPageToFit = true; //适应页面
    }
    return self;
}

/**
 *  设置链接
 *
 *  @param link 链接
 */
- (void)setAdvertWebLink:(NSString*)link {
    //链接地址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",link]];
    [self.advertWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
