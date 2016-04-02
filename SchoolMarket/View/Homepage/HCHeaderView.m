/*
 主页头部广告
 */

#import "HCHeaderView.h"

@implementation HCHeaderView

- (instancetype)initWithFrame:(CGRect)frame andImgs:(nullable NSArray*)imgs
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建滚动视图
        UIScrollView *tempscroll = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollview = tempscroll;
        self.scrollview.pagingEnabled = true;
        [self addSubview:self.scrollview];
        
        //创建page
        UIPageControl *temppage = [[UIPageControl alloc] init];
        self.pagec = temppage;
        self.pagec.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 5 * 4);
        self.pagec.numberOfPages = imgs.count;
        [self addSubview:self.pagec];
        
        
        for (int i = 0 ; i < imgs.count ; i++ ) {
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i , 0, frame.size.width, frame.size.height)];
            imgv.image = [UIImage imageNamed:imgs[i]];
            [self.scrollview addSubview:imgv];
        }
        
        self.scrollview.contentSize = CGSizeMake(frame.size.width * imgs.count, 0);
    }
    return self;
}

@end
