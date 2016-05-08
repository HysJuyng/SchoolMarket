/*
 订单详情cell
 */

#import "OrderDetailCell.h"

@implementation OrderDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
        //标题
        UILabel *temptitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width / 4, self.frame.size.height)];
        self.lbTitle = temptitle;
        self.lbTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbTitle];
        
        //内容
        UILabel *tempcontent = [[UILabel alloc] initWithFrame:CGRectMake(self.lbTitle.frame.size.width + 10, 0, self.frame.size.width - self.lbTitle.frame.size.width - 15, self.frame.size.height)];
        self.lbContent = tempcontent;
        self.lbContent.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.lbContent];
        
    }
    return self;
}

/**
 *  设置cell内容
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)setOrderDetail:(NSString *)title andContent:(NSString *)content {
    self.lbTitle.text = title;
    self.lbContent.text = content;
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
