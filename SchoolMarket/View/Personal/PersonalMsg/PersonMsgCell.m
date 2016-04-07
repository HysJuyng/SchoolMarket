/*
 账户信息 单元格
 标题  内容  图片
 */

#import "PersonMsgCell.h"

@implementation PersonMsgCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
        //标题
        UILabel *temptitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, self.frame.size.height - 10)];
        self.lbTitle = temptitle;
        self.lbTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbTitle];
        
        //内容
        UILabel *tempContent = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height - 90,5, 100, self.frame.size.height - 10)];
        self.lbContent = tempContent;
        self.lbContent.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.lbContent];
        
        //next图片
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height + 15, 10, self.frame.size.height - 20, self.frame.size.height - 20)];
        self.nextImgv = tempimgv;
        self.nextImgv.backgroundColor = [UIColor blueColor];
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
