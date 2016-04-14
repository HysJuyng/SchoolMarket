/*
 主页头部cell
 
 collectinview  4个按钮
 */

#import "HCHeaderCell.h"


@implementation HCHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //collectionview
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *tempcv = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        self.cvHeader = tempcv;
        self.cvHeader.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.cvHeader];
        
    }
    return self;
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
