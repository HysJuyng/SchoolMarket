/*
  主页头部cell 的 collectionviewcell
 图片 + 标题
 */

#import "HCHeaderCollectionCell.h"

@implementation HCHeaderCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //图片
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, frame.size.height - 20, frame.size.height - 20)];
        self.imgv = tempimgv;
        [self addSubview:self.imgv];
        
        //标题
        UILabel *tempTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        self.lbTitle = tempTitle;
        self.lbTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lbTitle];
    }
    return self;
}

@end
