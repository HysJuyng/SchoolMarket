/*
 个人主页第一个区的cell
 图片和标题
 */

#import "PersonalCell.h"

@implementation PersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSuperVc:(UIViewController*)supervc
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //标题图片
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, self.frame.size.height - 20, self.frame.size.height - 20)];
        self.titleImgv = tempimgv;
        self.titleImgv.backgroundColor = [UIColor blueColor];
        [self addSubview:self.titleImgv];
        
        //标题
        UILabel *temptitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height - 5, 5, self.frame.size.width / 2, self.frame.size.height - 10)];
        self.lbTitle = temptitle;
        self.lbTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbTitle];
        
        //next图标(右箭头)
        UIImageView *tempnext = [[UIImageView alloc] initWithFrame:CGRectMake(supervc.view.frame.size.width - self.frame.size.height + 5, 15, self.frame.size.height - 20, self.frame.size.height - 20)];
        self.nextImgv = tempnext;
        self.nextImgv.image = [UIImage imageNamed:@"personal_arrow_right"];
        [self addSubview:self.nextImgv];
        
    }
    return self;
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
