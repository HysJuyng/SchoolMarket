/*
 超市
 */

#import "SuperMarketViewController.h"
#import "Categories.h"
#import "SubCategories.h"
#import "Commodity.h"
#import "CategoriesCell.h"
#import "SubCategoriesCell.h"
#import "CommCell.h"
#import "CommDetailViewController.h"
#import "AFRequest.h"
#import "FMDBsql.h"
#import "NotifitionSender.h"
#import "ActivityIndicatorView.h"
#import "ErrorTipButton.h"

@interface SuperMarketViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, CommCellDelegate>
/**  中间内容区域 */
@property (nonatomic, assign) CGRect middleframe;
/**  营业时间试图 */
@property (nonatomic, weak) UIButton *openTimeView;
/**  大分类 */
@property (nonatomic, weak) UITableView *category;
/**  子分类 */
@property (nonatomic, weak) UITableView *subCategory;
/**  商品展示 */
@property (nonatomic, weak) UICollectionView *commCV;
/**  菊花旋转视图 */
@property (nonatomic, weak) ActivityIndicatorView *activityView;
/**  重新加载按钮 */
@property (nonatomic, weak) UIButton *reacquireBtn;
/**  collectionViewCell边距 */
@property (nonatomic, assign) CGFloat margin;

/**  分类对象数组 */
@property (nonatomic, strong) NSMutableArray *categories;
/**  商品模型数组 */
@property (nonatomic, strong) NSMutableArray *comms;
/**  选择的主分类包含的商品数组 */
@property (nonatomic, strong) NSMutableArray *categoryComms;
/**  选择的子分类包含的商品数组 */
@property (nonatomic, strong) NSMutableArray *selectedCategoryComms;

/**  被选择的主分类 */
@property (nonatomic, strong) Categories *selectedCategory;
/**  被选择的子分类 */
@property (nonatomic, strong) SubCategories *selectedSubcategory;

@end

@implementation SuperMarketViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 商品数量改变通知
    [center addObserver:self selector:@selector(updateSMSelectedNum:) name:@"updateSelectedNum" object:nil];
    [center addObserver:self selector:@selector(reacquireCommodity) name:@"reacquireCommodity" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    // 发送网络请求获取分类信息
    [self getCategories];
    // 创建导航控制器Item
    [self BarButtonItem];
    
    CGFloat frameY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat frameW = self.view.bounds.size.width;
    CGFloat frameH = CGRectGetMinY(self.tabBarController.tabBar.frame) - frameY;
    // 创建营业时间条视图
    [self openTimeViewWithFrame:CGRectMake(0, frameY, frameW, frameH)];
    
    CGFloat otherFrameY = frameY + self.openTimeView.frame.size.height;
    CGFloat otherFrameH = frameH - self.openTimeView.frame.size.height;
    self.middleframe = CGRectMake(0, otherFrameY, frameW, otherFrameH);
    // 创建主分类视图
    [self categoryTableViewWithFrame:self.middleframe];
    // 创建子分类视图
    [self subCategoryTablelViewWithFrame:self.middleframe];
    // 创建商品视图
    [self commCollectionViewWithFrame:self.middleframe];
    // 创建菊花旋转视图
    [self activityView:self.middleframe];
}

#pragma mark - 懒加载
- (NSMutableArray *)comms {
    if (_comms == nil) {
        _comms = [NSMutableArray array];
    }
    return _comms;
}

/**  获取分类信息 */
- (NSMutableArray *)categories {
    if (_categories == nil) {
        _categories = [NSMutableArray array];
    }
    return _categories;
}

#pragma mark - 网络请求，刷新视图
/**  获取分类信息 */
- (void)getCategories {
    if (self.reacquireBtn != nil) {
        [self.reacquireBtn removeFromSuperview];
    }
    if (self.category != nil ) {
        [self activityView:self.middleframe];
    }
    // 获取分类数据的接口
    NSString *categoriesUrl = [NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/findAllClassify.jhtml"];
    // 请求网络数据
    [AFRequest getCategorier:categoriesUrl andParameter:nil andCategorierBlock:^(NSMutableArray * _Nonnull categories) {
        // 遍历分类数组，依次转换模型，并添加到临时数组中
        for (NSDictionary *dict in categories) {
            [self.categories addObject:[Categories categoriesWithDict:dict]];
        }
        // 刷新分类视图
        [self.category reloadData];
        
        // 设置选中第一个主分类
        [self setSelectedIndexPath:self.category];
        // 被点击的分类
        self.selectedCategory = [self.categories firstObject];
        // 开启多一条线程获取商品信息
        [NSThread detachNewThreadSelector:@selector(getComms:) toTarget:self withObject:self.selectedCategory];
        // 刷新子分类数据
        [self.subCategory reloadData];
        // 设置选中第一个子分类
        [self setSelectedIndexPath:self.subCategory];
    } andError:^(NSError * _Nullable error) {
        if (error) {
            // 弹出错误提示
            [self errorTip];
        }
    }];
}

/**  获取商品信息 */
- (void)getComms:(Categories *)category {
    if (self.reacquireBtn != nil) {
        [self.reacquireBtn removeFromSuperview];
    }
    if (self.activityView == nil) {
        [self activityView:self.middleframe];
    }
    // 获取商品数据的接口
    NSString *commUrl = [NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/findAllCommByMainId.jhtml"];
    // 参数（主分类id）
    NSDictionary *commParameter = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", category.mainclassId], @"mainclassId", nil];
    // 闭包回调
    [AFRequest getComm:commUrl andParameter:commParameter andCommBlock:^(NSMutableArray * _Nonnull comms) {
        // 获得数据
        self.categoryComms = comms;
        if (self.selectedCategoryComms.count == 0) {
            self.selectedCategoryComms = comms;
        }
        // 与购物车的商品进行对比
        [FMDBsql contrastShopcartAndModels:self.categoryComms];
        [FMDBsql contrastShopcartAndModels:self.selectedCategoryComms];
        // 将菊花转动视图移除
        [self.activityView removeFromSuperview];
        // 刷新商品视图
        [self.commCV reloadData];
        [self setSelectedIndexPath:self.subCategory];
    } andError:^(NSError * _Nullable error) {
        if (error) {
            // 弹出错误提示
            [self errorTip];
        }
    }];
}

/**  将原来获取的商品数据删除，并重新获取 */
- (void)reacquireCommodity {
    [self.selectedCategoryComms removeAllObjects];
    [self.comms removeAllObjects];
    [self getComms:self.selectedCategory];
}

/**  菊花旋转视图（正在加载数据） */
- (ActivityIndicatorView *)activityView:(CGRect)frame {
    if (self.activityView == nil) {
        ActivityIndicatorView *activityView = [[ActivityIndicatorView alloc] initWithFrame:frame];
        self.activityView = activityView;
        [self.view addSubview:self.activityView];
    }
    return self.activityView;
}

/**  错误提示 */
- (void)errorTip {
    [self.activityView removeFromSuperview];
    ErrorTipButton *errorBtn = [[ErrorTipButton alloc] init];
    errorBtn.center = self.view.center;
    [self.view addSubview:errorBtn];
    // 设置3秒后自动将错误提示从视图中移除
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(removeErrorTip:) userInfo:errorBtn repeats:NO];
}

/**  将错误提示从视图中移除 */
- (void)removeErrorTip:(NSTimer *)timer {
    ErrorTipButton *errorBtn = [timer userInfo];
    [errorBtn removeFromSuperview];
    if (self.reacquireBtn == nil) {
        UIButton *reacquireBtn = [[UIButton alloc] init];
        [reacquireBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [reacquireBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [reacquireBtn sizeToFit];
        CGRect frame = reacquireBtn.frame;
        frame.size.width *= 1.2;
        reacquireBtn.frame = frame;
        // 设置重新加载按钮边框
        reacquireBtn.layer.borderColor = [[UIColor colorWithWhite:0.0f alpha:1.0f] CGColor];
        reacquireBtn.layer.borderWidth = 0.6f;
        reacquireBtn.layer.cornerRadius = reacquireBtn.frame.size.height * 0.2;
        reacquireBtn.center = self.view.center;
        if (self.categories.count == 0) {
            // 如果分类数据没有获取，则调用请求分类数据的方法
            [reacquireBtn addTarget:self action:@selector(getCategories) forControlEvents:UIControlEventTouchUpInside];
        } else if (self.categoryComms.count == 0) {
            // 如果分类数据已经获取，则调用请求商品数据方法
            [reacquireBtn addTarget:self action:@selector(commError) forControlEvents:UIControlEventTouchUpInside];
        }
        self.reacquireBtn = reacquireBtn;
        [self.view addSubview:self.reacquireBtn];
    }
}

- (void)commError {
    [self getComms:self.selectedCategory];
}

#pragma mark - 创建导航控制器Item
/**  创建导航控制器Item */
- (void)BarButtonItem {
    // 设置定位
    UIButton *test = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [test setTitle:@"五邑大学" forState:UIControlStateNormal];
    test.frame = CGRectMake(0, 0, 60, 30);
    UIBarButtonItem *locationItem = [[UIBarButtonItem alloc] initWithCustomView:test];
    self.navigationItem.leftBarButtonItem = locationItem;
    
    // 设置消息
    UIButton *btnsearch = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btnsearch.frame = CGRectMake(0, 0, 30, 30);
    [btnsearch setImage:[UIImage imageNamed:@"home_search"] forState:(UIControlStateNormal)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:btnsearch];
    
    // 设置搜索
    UIButton *btnmessage = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btnmessage.frame = CGRectMake(0, 0, 30, 30);
    [btnmessage setImage:[UIImage imageNamed:@"home_message"] forState:(UIControlStateNormal)];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:btnmessage];
    
    self.navigationItem.rightBarButtonItems = @[searchItem, messageItem];
}

#pragma mark - 添加控件
/**  创建营业时间 */
- (UIButton *)openTimeViewWithFrame:(CGRect)frame {
    if (self.openTimeView == nil) {
        CGFloat openTimeViewW = frame.size.width;
        UIButton *openTimeView = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.origin.y, openTimeViewW, 20)];
        
        // 设置按钮颜色
        openTimeView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        
        // 设置按钮文字
        [openTimeView setTitle:@"超市营业时间：9:00 - 23:00" forState:UIControlStateNormal];
        [openTimeView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        openTimeView.titleLabel.font = [UIFont systemFontOfSize:14.0];
        // 设置文字偏移量
        openTimeView.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        
        // 设置按钮不可用
        openTimeView.enabled = NO;
        
        // 设置时钟图片
        UIImage *clock = [UIImage imageNamed:@"supermarket_time"];
        [openTimeView setImage:clock forState:(UIControlStateNormal)];
        
        [self.view addSubview:(self.openTimeView = openTimeView)];
    }
    return self.openTimeView;
}

#pragma mark - 分类
/**  创建大分类category */
- (UITableView *)categoryTableViewWithFrame:(CGRect)frame {
    if (self.category == nil) {
        CGFloat categoryY = frame.origin.y;
        CGFloat categoryW = frame.size.width * 0.3;
        CGFloat categoryH = frame.size.height;
        
        UITableView *category = [[UITableView alloc] initWithFrame:CGRectMake(0, categoryY, categoryW, categoryH) style:UITableViewStylePlain];
        category.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.06];
        category.delegate = self;
        category.dataSource = self;
        // 设置单元格分割线
        category.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.category = category;
        [self.view addSubview:self.category];
    }
    return self.category;
}

/**  创建小分类subCategory */
- (UITableView *)subCategoryTablelViewWithFrame:(CGRect)frame {
    if (self.subCategory == nil) {
        CGFloat subH = frame.size.width - CGRectGetWidth(self.category.frame);
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
        self.subCategory = subCategory;
        [self.view addSubview:self.subCategory];
    }
    return self.subCategory;
}

#pragma mark 数据源方法
/**  返回cell的数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.category) {
        // 如果是主分类TableView，则返回主分类的数量
        return self.categories.count;
    } else {
        // 如果是子分类TableView，则返回子分类的数量
        return self.selectedCategory.subClass.count;
    }
}

/**  设置tableViewCell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    UITableViewCell *cell = nil;
    if (tableView == self.category) {
        // 主分类
        cell = [CategoriesCell cellWithTableView:tableView];
        // 通过数据模型，设置Cell内容
        Categories *category = self.categories[indexPath.row];
        cell.textLabel.text = category.mainclassName;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // 子分类
        cell = [SubCategoriesCell cellWithTableView:tableView];
            SubCategories *subCategories = self.selectedCategory.subClass[indexPath.row];
            cell.textLabel.text = subCategories.subclassName;
            [cell.textLabel sizeToFit];
            cell.textLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        tableView.rowHeight = cell.textLabel.frame.size.height + 10;
    }
    return cell;
}

#pragma mark 代理方法
/**  tableViewCell被点击时调用 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.category) {
        // 被点击的分类
        self.selectedCategory = self.categories[indexPath.row];
        // 刷新子分类数据
        [self.subCategory reloadData];
        [self setSelectedIndexPath:self.subCategory];
        
        // 查询已经获取的数据中是否包含点击前的分类商品
        if (self.categoryComms.count != 0 && ![self.comms containsObject:self.categoryComms[0]]) {
            [self.comms addObjectsFromArray:self.categoryComms];
        }
        
        NSMutableArray *tempArray = [NSMutableArray array];
        // 遍历已经获取的商品数据中是否有当前选择的分类商品
        for (Commodity *comm in self.comms) {
            if (comm.mainclassId == self.selectedCategory.mainclassId) {
                [tempArray addObject:comm];
            }
        }
        // 如果没有找到当前选择的分类商品，则新建一条线程请求对应商品数据
        if (tempArray.count == 0) {
            [NSThread detachNewThreadSelector:@selector(getComms:) toTarget:self withObject:self.selectedCategory];
        }
        // 将临时数组赋给主分类和子分类数组
        self.categoryComms = tempArray;
        self.selectedCategoryComms = tempArray;
    } else if (tableView == self.subCategory) {
        // 被点击的子分类
        self.selectedSubcategory = self.selectedCategory.subClass[indexPath.row];
        
        if ([self.selectedSubcategory.subclassName isEqualToString:@"全部"]) {
            // 如果选择全部则将当前主分类数组中的数据赋给子分类数组
            self.selectedCategoryComms = self.categoryComms;
        } else {
            // 如果选择某个子分类，则从当前主分类数组中遍历出该子分类的商品
            NSMutableArray *tempArray = [NSMutableArray array];
            for (Commodity *comm in self.categoryComms) {
                if (comm.subclassId == self.selectedSubcategory.subclassId) {
                    [tempArray addObject:comm];
                }
            }
            self.selectedCategoryComms = tempArray;
        }
    }
    // 刷新UICollectionView
    [self.commCV reloadData];
    // 当即将展示的商品模型数组中不为空时，将UICollectionView置顶
    if (self.selectedCategoryComms.count != 0) {
        NSIndexPath *commIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.commCV selectItemAtIndexPath:commIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    }
}

/**  设置UITableView默认选中第一个cell并置顶 */
- (void)setSelectedIndexPath:(UITableView *)tableView {
    if (self.categories.count != 0) {
        NSInteger selectedIndex = 0;
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark - 商品视图
/**  创建商品展示collectionView */
- (UICollectionView *)commCollectionViewWithFrame:(CGRect)frame {
    if (self.commCV == nil) {
        CGFloat commCVX = self.subCategory.frame.origin.x;
        CGFloat commCVY = CGRectGetMaxY(self.subCategory.frame);
        CGFloat commCVW = frame.size.width - self.category.frame.size.width;
        CGFloat commCVH = frame.size.height - self.subCategory.frame.size.height;
        
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *commCV = [[UICollectionView alloc] initWithFrame:CGRectMake(commCVX, commCVY, commCVW, commCVH) collectionViewLayout:layout];
        commCV.backgroundColor = [UIColor whiteColor];
        commCV.dataSource = self;
        commCV.delegate = self;
        self.margin = commCV.frame.size.width * 0.05;
        
        [self.view addSubview:(self.commCV = commCV)];
        [self.commCV registerClass:[CommCell class] forCellWithReuseIdentifier:@"commcell"];
    }
    return self.commCV;
}

#pragma mark 数据源方法
/**  返回collectionViewCell数量 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectedCategoryComms.count;
}

/**  设置cell单元格 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"commcell";
    CommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 获取选中商品的模型，并设置商品cell的数据
    Commodity *comm = self.selectedCategoryComms[indexPath.row];
    [cell setCommCell:comm];

    return cell;
}

/**  商品单元格 添加按钮事件 （重用bug） */
- (void)commCellClickAdd:(UIButton *)button {
    // 获取button所在的cell
    CommCell *currentCell = (CommCell *)[button superview];
    // 找到对应的商品模型
    NSIndexPath *indexPath = [self.commCV indexPathForCell:currentCell];
    Commodity *currentComm = self.selectedCategoryComms[indexPath.row];
    // 判断库存
    if (currentComm.selectedNum == currentComm.stock.intValue) {
        NSLog(@"库存不足");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:nil message:@"库存不足" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [error show];
        return;
    }

    // 判断完成之后进行数据和视图的修改
    if (currentComm.selectedNum == 0) {
        // 显示减按钮和数量
        currentCell.btnMinus.hidden = NO;
        currentCell.lbNum.hidden = NO;
        // 隐藏商品价格
        currentCell.lbPrice.hidden = YES;
    }
    
    // 修改模型中选择的商品数量
    currentComm.selectedNum++;
    
    // 数据库操作
    if (currentComm.selectedNum == 1) {
        // 如果本来没有选择，则向数据库插入一条数据
        [FMDBsql insertShopcartComm:currentComm];
    } else {
        // 如果已经有选择，则更新对应的数据
        [FMDBsql updateShopcartComm:currentComm.commodityId andSelectedNum:currentComm.selectedNum];
    }
    
    // 更新购物车状态，跳转到购物车视图的时候验证
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setValue:@"true" forKey:@"shopCartIsUpdate"];
    
    // 发送通知
    [NotifitionSender updateSelectedNumNotification:currentComm];
}

/**  商品单元格 减少按钮事件 */
- (void)commCellClickMinus:(UIButton *)button {
    // 获取button所在的cell
    CommCell *currentCell = (CommCell *)[button superview];
    // 找到对应的商品模型
    NSIndexPath *indexPath = [self.commCV indexPathForCell:currentCell];
    Commodity *currentComm = self.selectedCategoryComms[indexPath.row];
    
    // 判断完成之后进行数据和视图的修改
    if (currentComm.selectedNum == 1) {
        // 显示减按钮和数量
        currentCell.btnMinus.hidden = YES;
        currentCell.lbNum.hidden = YES;
        // 隐藏商品价格
        currentCell.lbPrice.hidden = NO;
    }
    
    // 修改模型中选择的商品数量
    currentComm.selectedNum--;
    
    // 更新数据库对应数据
    [FMDBsql updateShopcartComm:currentComm.commodityId andSelectedNum:currentComm.selectedNum];

    // 更新购物车状态，跳转到购物车视图的时候验证
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setValue:@"true" forKey:@"shopCartIsUpdate"];
    
    // 发送通知
    [NotifitionSender updateSelectedNumNotification:currentComm];
}

#pragma mark 代理方法
/**  设置cell边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat margin = self.margin;
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}

/**  设置cell规格 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellW = (collectionView.frame.size.width - self.margin * 4) / 2;
    CGFloat cellH = cellW * 5 / 3;
    return CGSizeMake(cellW, cellH);
}

/**  商品cell被选中时执行此方法 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.commCV) {
        // 正向传值
        CommDetailViewController *commDetail = [[CommDetailViewController alloc] init];
        Commodity *comm = self.selectedCategoryComms[indexPath.row];
        commDetail.comm = comm;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commDetail animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - 通知方法
/**  更新某个选择的商品的数量 */
- (void)updateSMSelectedNum:(NSNotification *)notification {
    int commid = [notification.userInfo[@"commodityId"] intValue];
    [self changeCommCell:notification.userInfo commId:commid];
}

/**  更新所有已选择商品的数量 */
//- (void)updateAllSelectedNum:(NSNotification *)notification {
//    NSMutableArray *arrayM = notification.userInfo[@"comms"];
//    for (NSDictionary *dict in arrayM) {
//        int commid = [dict[@"commodityId"] intValue];
//        [self changeCommCell:dict commId:commid];
//        // 如果缓存下来的所有商品数组不为0的话，则将里面对应的商品模型进行数据修改
//        if (self.comms.count != 0) {
//            for (Commodity *comm in self.comms) {
//                if (commid == comm.commodityId) {
//                    [comm setValuesForKeysWithDictionary:dict];
//                    break;
//                }
//            }
//        }
//    }
//}

/**
 *  更改分类商品模型数据和商品Cell的显示
 *
 *  @param dict   商品模型字典
 *  @param commid 商品id
 */
- (void)changeCommCell:(NSDictionary *)dict commId:(int)commid {
    // 更改当前选择的子分类商品模型数据和商品Cell的显示
    for (int i = 0; i < self.selectedCategoryComms.count; i++) {
        Commodity *comm = self.selectedCategoryComms[i];
        if (commid == comm.commodityId) {
            NSIndexPath *commIndexPath = [NSIndexPath indexPathForItem:i inSection:0];
            CommCell *commCell = (CommCell *)[self.commCV cellForItemAtIndexPath:commIndexPath];
            [commCell setCommcellOfSelectedNum:dict[@"selectedNum"]];
            [comm setValuesForKeysWithDictionary:dict];
            break;
        }
    }
    // 更改当前选择的大分类商品模型数据
    for (Commodity *comm in self.categoryComms) {
        if (commid == comm.commodityId) {
            [comm setValuesForKeysWithDictionary:dict];
            return;
        }
    }
}
@end