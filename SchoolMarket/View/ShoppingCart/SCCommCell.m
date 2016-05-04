//
//  SCCommCell.m
//  SchoolMarket
//
//  Created by tb on 16/4/10.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "SCCommCell.h"
#import "Commodity.h"
#import "SDWebImage-umbrella.h"

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
- (void)setComm:(Commodity *)comm {
    _comm = comm;
    self.commNameLabel.text = _comm.commName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", _comm.price];
    self.specificationLabel.text = _comm.specification;
    [self.numBtn setTitle:[NSString stringWithFormat:@"%d", _comm.selectedNum] forState:UIControlStateNormal];
    if ([_comm.picture isEqual:[NSNull null]]) {
        self.pictureImgView.image = [UIImage imageNamed:@"default_img_failed"];
    } else {
        [self.pictureImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",_comm.picture]]
                         placeholderImage:[UIImage imageNamed:@"default_img"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    if (error) {
                                        self.pictureImgView.image = [UIImage imageNamed:@"default_img_failed"];
                                    }
                                }];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView andFrame:(CGRect)frame
{
    static NSString *ID = @"SCComm";
    
    SCCommCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SCCommCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andFrame:frame];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        self.pictureImgView = picture;
        [self addSubview:self.pictureImgView];
        
        UILabel *commName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImgView.frame) + 10, self.pictureImgView.frame.origin.y, frame.size.width * 0.6, 20)];
        self.commNameLabel = commName;
        [self addSubview:self.commNameLabel];
        
        UILabel *specification = [[UILabel alloc] initWithFrame:CGRectMake(self.commNameLabel.frame.origin.x, CGRectGetMaxY(self.commNameLabel.frame), 80, 20)];
        specification.textColor = [UIColor colorWithWhite:0.0f alpha:0.2];
        specification.font = [UIFont systemFontOfSize:11.0f];
        self.specificationLabel = specification;
        [self addSubview:self.specificationLabel];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(self.commNameLabel.frame.origin.x, CGRectGetMaxY(self.specificationLabel.frame), 80, 20)];
        price.textColor = [UIColor redColor];
        price.font = [UIFont systemFontOfSize:14.0f];
        self.priceLabel = price;
        [self addSubview:self.priceLabel];
        
        UIButton *num = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - (90 + 10), CGRectGetMaxY(self.pictureImgView.frame) - 30, 90, 30)];
        [num setTitleColor:[UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        num.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
        num.layer.cornerRadius = 10;
        self.numBtn = num;
        [self addSubview:self.numBtn];
        
        UIButton *increase = [[UIButton alloc] initWithFrame:CGRectMake(self.numBtn.frame.size.width - 30, 0, 30, 30)];
        [increase setTitle:@"+" forState:UIControlStateNormal];
        [increase setTitleColor:[UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        increase.titleLabel.font = [UIFont systemFontOfSize:20.0];
        self.increaseBtn = increase;
        [self.increaseBtn addTarget:self.delegate action:@selector(increaseOrDecreaseButtonDidClickWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.numBtn addSubview:self.increaseBtn];
        
        UIButton *decrease = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [decrease setTitle:@"-" forState:UIControlStateNormal];
        [decrease setTitleColor:[UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        decrease.titleLabel.font = [UIFont systemFontOfSize:20.0];
        self.decreaseBtn = decrease;
        [self.decreaseBtn addTarget:self.delegate action:@selector(increaseOrDecreaseButtonDidClickWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.numBtn addSubview:self.decreaseBtn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
