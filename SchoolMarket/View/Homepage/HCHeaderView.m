/*
 主页头部广告
 */

#import "HCHeaderView.h"
#import "Advert.h"
#import "SDWebImage-umbrella.h"

@implementation HCHeaderView


- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建滚动视图
        UIScrollView *tempscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 20)];
        self.scrollview = tempscroll;
        self.scrollview.pagingEnabled = true;
        self.scrollview.showsHorizontalScrollIndicator = false;
        [self addSubview:self.scrollview];
        
        self.scrollview.delegate = self;
        
        //创建page
        UIPageControl *temppage = [[UIPageControl alloc] init];
        self.pagec = temppage;
        self.pagec.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 5 * 4);
        
        [self addSubview:self.pagec];
        
        //放头图片和头标题的view
        UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        self.titleView = tempview;
        self.titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleView];
        
        //头图片
        UIImageView *tempimgv = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 10, 10)];
        self.imgvTitle = tempimgv;
        self.imgvTitle.image = [UIImage imageNamed:@"home_notice"];
        [self.titleView addSubview:self.imgvTitle];

        //头标题
        UILabel *temptitle = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 100, 10)];
        self.lbTitle = temptitle;
        self.lbTitle.textAlignment = NSTextAlignmentLeft;
        self.lbTitle.font = [UIFont systemFontOfSize:self.lbTitle.frame.size.height];
        [self.titleView addSubview:self.lbTitle];
    }
    return self;
}

/**
 *  设置广告
 *
 *  @param advertises 广告model数组
 */
- (void)setAdvertises:(nullable NSArray*)advert {
    
    _advertises = [[NSArray alloc] initWithArray:advert];
    
    //page个数
    self.pagec.numberOfPages = advert.count;
    
    //图片
    for (int i = 0 ; i < advert.count ; i++ ) {
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i , 0, self.frame.size.width, self.frame.size.height - 20)];
        
        NSString *pic = ((Advert*)advert[i]).advertisePic;
        
        [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",pic]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"广告：%@",pic);
        }];
        [self.scrollview addSubview:imgv];
    }
    
    self.scrollview.contentSize = CGSizeMake(self.frame.size.width * advert.count, 0);
}

//设置公告
- (void)setTitle:(nonnull NSString*)guanggao {
    self.lbTitle.text = guanggao;
}

#pragma mark 滚动视图代理
/** 滚动*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //设置page
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pagec.currentPage = page;
}
/** 开始拖拽的时候调用*/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
/** 结束拖拽*/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开启定时器
    [self addTimer];
}

#pragma mark 轮播方法
/** 下一张图片*/
- (void)nextImage {
    int page = (int)self.pagec.currentPage;
    if (page == self.advertises.count - 1) {
        page = 0;
    }else
    {
        page++;
    }
   
    //  滚动scrollview
    CGFloat x = page * self.scrollview.frame.size.width;
    self.scrollview.contentOffset = CGPointMake(x, 0);
}
/**
*  开启定时器
*/
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/**
*  关闭定时器
*/
- (void)removeTimer
{
    [self.timer invalidate];
}



@end
