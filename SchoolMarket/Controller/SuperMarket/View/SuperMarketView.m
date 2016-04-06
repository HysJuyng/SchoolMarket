//
//  SuperMarketView.m
//  SchoolMarket
//
//  Created by tb on 16/4/5.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "SuperMarketView.h"
#import "Categories.h"
#import "CategoriesCell.h"
#import "SubCategoriesCell.h"

@interface SuperMarketView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIButton *openTimeView;
@property (nonatomic, weak) UITableView *category;
@property (nonatomic, weak) UITableView *subCategory;
@property (nonatomic, weak) UICollectionView *goods;

@property (nonatomic, strong) NSArray *categoriesList;
@property (nonatomic, assign) NSInteger *selectedCategory;

@end

@implementation SuperMarketView

- (NSArray *)categoriesList
{
    if (_categoriesList == nil) {
        _categoriesList = [Categories categoriesList];
    }
    return _categoriesList;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self openTimeViewWithFrame:frame];
        [self categoryTableView];
        [self subCategoryTablelView];
        [self goodsCollectionView];
        
        [self setSelectedIndexPath:self.category];
        // 被点击的分类
        self.selectedCategory = self.categoriesList[0];
        // 刷新子分类数据
        [self.subCategory reloadData];
        [self setSelectedIndexPath:self.subCategory];
        
    }
    return self;
}

#pragma mark - 添加控件

#pragma mark 营业时间
/**  创建营业时间 */
- (UIButton *)openTimeViewWithFrame:(CGRect)frame
{
    if (self.openTimeView == nil) {
        CGFloat openTimeViewW = frame.size.width;
        
        UIButton *openTimeView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, openTimeViewW, 20)];
        
        // 设置按钮颜色
        openTimeView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        // 设置按钮文字
        [openTimeView setTitle:@"超市营业时间：9:00 - 23:00" forState:UIControlStateNormal];
        [openTimeView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        openTimeView.titleLabel.font = [UIFont systemFontOfSize:14.0];
        // 设置文字偏移量
        openTimeView.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 80);
        
        // 设置按钮不可用
        openTimeView.enabled = NO;
        
        // 设置时钟图片
        
        [self addSubview:(self.openTimeView = openTimeView)];
    }
    return self.openTimeView;
}

#pragma mark 大分类
/**  创建大分类category */
- (void)categoryTableView
{
    CGFloat categoryY = CGRectGetMaxY(self.openTimeView.frame);
    CGFloat categoryW = self.frame.size.width * 0.3;
    CGFloat categoryH = self.frame.size.height - categoryY;
        
    UITableView *category = [[UITableView alloc] initWithFrame:CGRectMake(0, categoryY, categoryW, categoryH) style:UITableViewStylePlain];
    category.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.06];
    category.delegate = self;
    category.dataSource = self;
    // 设置单元格分割线
    category.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    [self addSubview:(self.category = category)];
}

#pragma mark 小分类
/**  创建小分类subCategory */
- (void)subCategoryTablelView
{
    CGFloat subH = self.frame.size.width - CGRectGetWidth(self.category.frame);
    CGFloat subW = 44;
    CGFloat subX = subH * 0.5 + CGRectGetWidth(self.category.frame) - subW / 2;
    CGFloat subY = self.category.frame.origin.y - (subH - subW) * 0.5;
    
    UITableView *subCategory = [[UITableView alloc] initWithFrame:CGRectMake(subX, subY, subW, subH)];
    subCategory.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.06];
    // 使滚动条不可见
    subCategory.showsVerticalScrollIndicator = NO;
    // 逆时针旋转90°
    subCategory.transform = CGAffineTransformMakeRotation(-M_PI_2);
    subCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
    subCategory.delegate = self;
    subCategory.dataSource = self;
    
    [self addSubview:(self.subCategory = subCategory)];
}

#pragma mark - 数据源方法
/**  数据源方法 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.category) {
        // 如果是主分类TableView，则返回主分类的数量
        return self.categoriesList.count;
    } else {
        // 如果是子分类TableView，则返回子分类的数量
        return self.selectedCategory.subCategories.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    UITableViewCell *cell = nil;
    if (tableView == self.category) {
        // 主分类
        cell = [CategoriesCell cellWithTableView:tableView];
        // 通过数据模型，设置Cell内容
        Categories *category = self.categoriesList[indexPath.row];
        cell.textLabel.text = category.name;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // 子分类
        cell = [SubCategoriesCell cellWithTableView:tableView];
        
        cell.textLabel.text = self.selectedCategory.subCategories[indexPath.row];
        [cell.textLabel sizeToFit];
        cell.textLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
        tableView.rowHeight = cell.textLabel.frame.size.height + 10;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.category) {
        // 被点击的分类
        self.selectedCategory = indexPath.row;
        // 刷新子分类数据
        [self.subCategory reloadData];
        [self setSelectedIndexPath:self.subCategory];
    }
}

- (void)setSelectedIndexPath:(UITableView *)tableView
{
    // 设置默认选中第一个cell
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark 商品展示
/**  创建商品展示goods */
- (void)goodsCollectionView
{
    CGFloat goodsX = self.subCategory.frame.origin.x;
    CGFloat goodsY = CGRectGetMaxY(self.subCategory.frame);
    CGFloat goodsW = self.frame.size.width - self.category.frame.size.width;
    CGFloat goodsH = self.frame.size.height - goodsY;
        
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    UICollectionView *goods = [[UICollectionView alloc] initWithFrame:CGRectMake(goodsX, goodsY, goodsW, goodsH) collectionViewLayout:layout];
    goods.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:(self.goods = goods)];
}
@end
