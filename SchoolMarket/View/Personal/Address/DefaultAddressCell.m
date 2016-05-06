/*
 设置默认地址cell
 */

#import "DefaultAddressCell.h"

@implementation DefaultAddressCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        
        //标题
        UILabel *temptitle = [[UILabel alloc] initWithFrame:CGRectMake(15,0, frame.size.width / 4, frame.size.height)];
        self.lbTitle = temptitle;
        [self addSubview:self.lbTitle];
        
        //设置默认地址开关
        UISwitch *tempsw = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height-10, 5, self.frame.size.height * 2, self.frame.size.height)];
        self.swDefault = tempsw;
        [self.swDefault addTarget:self.delegate action:@selector(switchOnOrOff:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.swDefault];
    }
    return self;
}

/**
 *  设置cell
 *
 *  @param title      标题
 *  @param defaultadd 默认状态
 */
- (void)setDefaultAddressCell:(NSString *)title andIsDefault:(int)defaultadd {
    self.lbTitle.text = title;
    self.swDefault.on = defaultadd;
}



- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
