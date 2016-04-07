/*
 主页tableview   商品区单元格
 */

#import "HomepageCell.h"

@implementation HomepageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSuperVc:(UIViewController*)supervc andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
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
        self.btnMore.frame = CGRectMake(supervc.view.frame.size.width - 60, 10, 60, 15);
        self.btnMore.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.btnMore setTitle:@"更多..." forState:(UIControlStateNormal)];
        [self.btnMore addTarget:supervc action:@selector(goSuperMarket) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.btnMore];
        
        //collectionView
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *tempcv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, supervc.view.frame.size.width, supervc.view.frame.size.width / 6 * 5 + 20) collectionViewLayout:layout];
        self.cvComm = tempcv;
        self.cvComm.backgroundColor = [UIColor whiteColor];
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
