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

/**  cell初始化方法 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *whiteSelectedBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        whiteSelectedBg.backgroundColor = [UIColor whiteColor];
        UIView *greenSelectedBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
        greenSelectedBg.backgroundColor = [UIColor greenColor];
        [whiteSelectedBg addSubview:greenSelectedBg];
        [self.selectedBackgroundView addSubview:whiteSelectedBg];
    }
    return self;
}

/**  cell被选中或取消选中时调用的方法 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.textLabel.textColor = [UIColor greenColor];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
}

@end
