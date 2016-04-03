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
    static NSString *ID = @"categories";
    
    // tableView查询可重用Cell
    CategoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 如果没有可重用cell，则进行初始化
    if (cell == nil) {
        cell = [[CategoriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

/**  setter方法 */
- (void)setMainCategories:(Categories *)mainCategories
{
    // 赋值，在其它方法中使用模型时才可以访问到
    _mainCategories = mainCategories;
    
    self.textLabel.text = mainCategories.name;
    self.textLabel.font = [UIFont systemFontOfSize:14.0];
}

/**  cell初始化方法 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

/**  cell被选中或取消选中时调用的方法 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor greenColor];
    } else {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.08];
        self.textLabel.textColor = [UIColor blackColor];
    }
}

@end
