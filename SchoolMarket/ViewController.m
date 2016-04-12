/*
 这个页面是用来测试的
 */

#import "ViewController.h"
#import "CommCell.h"
#import "AFRequest.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic) UICollectionView *cv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    //设layout
//    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    //创建
//    self.cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 300) collectionViewLayout:layout];
//    self.cv.backgroundColor = [UIColor grayColor];
//    //注册cell   用哪个cell写哪个
//    [self.cv registerClass:[CommCell class] forCellWithReuseIdentifier:@"cellid"];
//    //代理 数据源
//    self.cv.delegate = self;
//    self.cv.dataSource = self;
//    [self.view addSubview:self.cv];
    
//    NSError *error;
//    NSString *pathfile = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
//    NSData *jdata = [[NSData alloc]initWithContentsOfFile:pathfile];
//    id jsonobj = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
//    NSDictionary *dic = jsonobj;
//    NSLog(@"%@",pathfile);

    
}

//个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"cellid";
    CommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];

    //数据
    cell.lbName.text = @"comm";
    cell.lbSpecification.text = @"500ml";
    cell.lbPrice.text = @"price";
    //添加事件
    [cell.btnAdd addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.btnAdd.tag = indexPath.row;
    
    return cell;
}
//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.cv.frame.size.width / 4, self.cv.frame.size.width / 12 * 5);
}
//边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.1, 20, 10, 15);
}
//点击事件 （重用bug）
- (void)click:(UIButton *)button {
    NSLog(@"%ld",(long)button.tag);
    
    //获取button所在的cell
    CommCell *cell = (CommCell *)[button superview];
    
    //操作
    [cell addNum];
    int num = [cell commNum];
    if (num > 0) {
        cell.btnMinus.hidden = false;
        cell.lbNum.hidden = false;
        cell.lbNum.text = [NSString stringWithFormat:@"%d",num];
        cell.lbPrice.hidden = true;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
