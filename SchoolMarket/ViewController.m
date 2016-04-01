/*
 这个页面是用来测试的
 */

#import "ViewController.h"
#import "GoodsCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic) UICollectionView *cv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设layout
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //创建
    self.cv = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 80, 335, 300) collectionViewLayout:layout];
    self.cv.backgroundColor = [UIColor grayColor];
    //注册cell   用哪个cell写哪个
    [self.cv registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"cellid"];
    //代理 数据源
    self.cv.delegate = self;
    self.cv.dataSource = self;
    [self.view addSubview:self.cv];
    
}

//个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"cellid";
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];

    
    cell.lbValue.text = @"12das";
    //添加事件
    [cell.btnAdd addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.btnAdd.tag = indexPath.row;
    
    return cell;
}
//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(120, 120);
}
//边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
}
//点击事件 （重用bug）
- (void)click:(UIButton *)button {
    NSLog(@"%d",button.tag);
    
    //获取button所在的cell
    GoodsCell *cell = (GoodsCell *)[button superview];
    
    //操作
    [cell setNum];
    int num = [cell getNum];
    if (num > 0) {
        cell.btnMinus.hidden = false;
        cell.lbNum.hidden = false;
        cell.lbNum.text = [NSString stringWithFormat:@"%d",num];
        cell.lbValue.hidden = true;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
