//
//  SCCommCell.m
//  SchoolMarket
//
//  Created by tb on 16/4/10.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "SCCommCell.h"

@interface SCCommCell ()

/**  商品图片 */
@property (nonatomic, weak) UIImageView *pictureImgView;
/**  商品名称 */
@property (nonatomic, weak) UILabel *commNameLabel;
/**  规格 */
@property (nonatomic, weak) UILabel *specificationLabel;
/**  价格 */
@property (nonatomic, weak) UILabel *priceLabel;

/**  商品数量 */
@property (nonatomic, weak) UIButton *numBtn;
/**  增加按钮 */
@property (nonatomic, weak) UIButton *increaseBtn;
/**  减少按钮 */
@property (nonatomic, weak) UIButton *decreaseBtn;

@end

@implementation SCCommCell


+ (instancetype)cellWithTableView:(UITableView *)tableView andFrame:(CGRect)frame
{
    static NSString *ID = @"SCComm";
    
    SCCommCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SCCommCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andFrame:frame];
        NSLog(@"%s", __func__);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        picture.backgroundColor = [UIColor blackColor];
        self.pictureImgView = picture;
        [self addSubview:self.pictureImgView];
        
        UILabel *commName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImgView.frame) + 10, self.pictureImgView.frame.origin.y, frame.size.width * 0.6, 20)];
        commName.text = @"Comm";
        self.commNameLabel = commName;
        [self addSubview:self.commNameLabel];
        
        UILabel *specification = [[UILabel alloc] initWithFrame:CGRectMake(self.commNameLabel.frame.origin.x, CGRectGetMaxY(self.commNameLabel.frame), 80, 20)];
        specification.text = @"20g";
        specification.textColor = [UIColor colorWithWhite:0.0f alpha:0.2];
        specification.font = [UIFont systemFontOfSize:11.0f];
        self.specificationLabel = specification;
        [self addSubview:self.specificationLabel];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(self.commNameLabel.frame.origin.x, CGRectGetMaxY(self.specificationLabel.frame), 80, 20)];
        price.text = @"￥20  ";
        price.textColor = [UIColor redColor];
        price.font = [UIFont systemFontOfSize:14.0f];
        self.priceLabel = price;
        [self addSubview:self.priceLabel];
        
        UIButton *num = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - (90 + 10), CGRectGetMaxY(self.pictureImgView.frame) - 30, 90, 30)];
        [num setTitle:@"0" forState:UIControlStateNormal];
        [num setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        num.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
        num.layer.cornerRadius = 10;
        self.numBtn = num;
        [self addSubview:self.numBtn];
        
        UIButton *increase = [[UIButton alloc] initWithFrame:CGRectMake(self.numBtn.frame.size.width - 30, 0, 30, 30)];
        [increase setTitle:@"+" forState:UIControlStateNormal];
        [increase setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        increase.titleLabel.font = [UIFont systemFontOfSize:20.0];
        
        self.increaseBtn = increase;
        [self.numBtn addSubview:self.increaseBtn];
        
        UIButton *decrease = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [decrease setTitle:@"-" forState:UIControlStateNormal];
        [decrease setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        decrease.titleLabel.font = [UIFont systemFontOfSize:20.0];
        self.decreaseBtn = decrease;
        [self.numBtn addSubview:self.decreaseBtn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
