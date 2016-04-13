/*
 主页头部广告
 */

#import <UIKit/UIKit.h>

@interface HCHeaderView : UIView

@property (weak,nonatomic) UIScrollView *scrollview;   //滚动视图
@property (weak,nonatomic) UIPageControl *pagec;
@property (weak,nonatomic) UIImageView *imgvTitle;   //头图片
@property (weak,nonatomic) UILabel *lbTitle;   //头标题
@property (weak,nonatomic) UIView *titleView;   //放头图片和头标题的view

//初始化方法  附带图片数组
- (nonnull instancetype)initWithFrame:(CGRect)frame andImgs:(nullable NSArray*)imgs;

//设置公告
- (void)setTitle:(nonnull NSString*)guanggao;

@end
