/*
 主页tableview   商品区单元格
 */

#import "HomepageCell.h"

@implementation HomepageCell

- (instancetype)initWithFrame:(CGRect)frame andSuperVC:(UIViewController*)superVC
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //头图片
        UIImageView *tempimgv = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 15, 15)];
        self.imgvTitle = tempimgv;
        self.imgvTitle.backgroundColor = [UIColor blueColor];
        [self addSubview:self.imgvTitle];
        
        //头标题
        UILabel *temptitle = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 100, 15)];
        self.lbTitle = temptitle;
        self.lbTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbTitle];
        
        //更多按钮
        UIButton *tempmore = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnMore = tempmore;
        self.btnMore.frame = CGRectMake(superVC.view.frame.size.width - 60, 10, 60, 15);
        self.btnMore.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.btnMore setTitle:@"更多..." forState:(UIControlStateNormal)];
        [self.btnMore addTarget:superVC action:@selector(goSuperMarket) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.btnMore];
        
        //collectionView
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *tempcv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, superVC.view.frame.size.width, superVC.view.frame.size.width / 6 * 5 + 20) collectionViewLayout:layout];
        self.cvComm = tempcv;
        self.cvComm.backgroundColor = [UIColor greenColor];
        [self addSubview:self.cvComm];
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
