//
//  SubCategoriesCell.h
//  SchoolMarket
//
//  Created by tb on 16/4/3.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>
// 告诉编译器，Categories是一个类
@class Categories;

@interface SubCategoriesCell : UITableViewCell

/**  分类的数据模型 */
@property (nonatomic, strong) Categories *subCategories;

/**  提供一个类方法快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
