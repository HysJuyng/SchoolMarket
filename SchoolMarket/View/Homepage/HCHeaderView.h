/*
 主页头部广告
 */

#import <UIKit/UIKit.h>

@interface HCHeaderView : UIView

@property (weak,nonatomic) UIScrollView *scrollview;   //滚动视图
@property (weak,nonatomic) UIPageControl *pagec;

//初始化方法  附带图片数组
- (instancetype)initWithFrame:(CGRect)frame andImgs:(nullable NSArray*)imgs;

@end
