/*
 修改姓名
 */

#import "PersonalNameController.h"

@interface PersonalNameController ()

@end

@implementation PersonalNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"姓名";
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    
    //文本输入框
    UITextField *tempname = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    self.tfName = tempname;
    self.tfName.placeholder = @"姓名";
    self.tfName.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tfName];
    
    //确定修改按钮
    UIButton *tempchange = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btnChange = tempchange;
    self.btnChange.frame = CGRectMake(25, 140, self.view.frame.size.width - 50, 33);
    [self.btnChange setTitle:@"确定修改" forState:(UIControlStateNormal)];
    self.btnChange.tintColor = [UIColor whiteColor];
    self.btnChange.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
    self.btnChange.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.btnChange];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
