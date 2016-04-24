//
//  SubCategoriesCell.m
//  SchoolMarket
//
//  Created by tb on 16/4/3.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "SubCategoriesCell.h"

@implementation SubCategoriesCell

/**  初始化cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 可重用标识符
    static NSString *ID = @"subCategories";
    
    // 查询可重用cell
    SubCategoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 如果没有可重用cell，进行初始化
    if (cell == nil) {
        cell = [[SubCategoriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bg.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = bg;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.textLabel.textColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
}
@end
