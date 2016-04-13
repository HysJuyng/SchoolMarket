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
        UIScrollView *tempscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 20)];
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
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i , 0, frame.size.width, frame.size.height - 20)];
            imgv.image = [UIImage imageNamed:imgs[i]];
            [self.scrollview addSubview:imgv];
        }
        
        self.scrollview.contentSize = CGSizeMake(frame.size.width * imgs.count, 0);
        
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

@end
