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
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
