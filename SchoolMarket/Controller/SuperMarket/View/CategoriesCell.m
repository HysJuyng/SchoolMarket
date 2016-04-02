//
//  CategoriesCell.m
//  SchoolMarket
//
//  Created by tb on 16/4/2.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "CategoriesCell.h"
#import "Categories.h"

@implementation CategoriesCell

/**  初始化cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 可重用标识符
    static NSString *ID = @"Categories";
    
    // tableView查询可重用Cell
    CategoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 如果没有可重用cell
    if (cell == nil) {
        cell = [[CategoriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setMainCategories:(Categories *)mainCategories
{
    _mainCategories = mainCategories;
    
    self.textLabel.text = mainCategories.name;
    self.textLabel.font = [UIFont systemFontOfSize:14.0];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    } else {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.08];
    }
}

@end
