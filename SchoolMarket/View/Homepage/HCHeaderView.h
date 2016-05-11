/*
 主页头部广告
 */

#import <UIKit/UIKit.h>

@protocol HCHeaderViewDelegate <NSObject>

- (void)goImgLink;

@end

@interface HCHeaderView : UIView <UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (weak,nonatomic) UIScrollView *scrollview;   //滚动视图
@property (weak,nonatomic) UIPageControl *pagec;
@property (weak,nonatomic) UIImageView *imgvTitle;   //头图片
@property (weak,nonatomic) UILabel *lbTitle;   //头标题
@property (weak,nonatomic) UIView *titleView;   //放头图片和头标题的view
@property (strong,nonatomic) NSArray *advertises;  //广告数组
@property (nonatomic, strong) NSTimer *timer;  //计时器

//代理
@property (nonatomic,assign) id<HCHeaderViewDelegate> delegate;

//初始化方法  
- (nonnull instancetype)initWithFrame:(CGRect)frame;

//设置公告
- (void)setTitle:(nonnull NSString*)guanggao;

@end
