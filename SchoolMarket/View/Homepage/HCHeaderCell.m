/*
 主页头部cell
 
 collectinview  4个按钮
 */

#import "HCHeaderCell.h"


@implementation HCHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
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
