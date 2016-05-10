/*
 广告页面控制器
 */

#import "AdvertViewController.h"
#import "AdvertWebView.h"

@interface AdvertViewController ()

@property (nonatomic,strong) AdvertWebView *advertWebView;

@end

@implementation AdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建webview
    self.advertWebView = [[AdvertWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.advertWebView];
    
    //设置链接
    [self.advertWebView setAdvertWebLink:self.advertLink];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
