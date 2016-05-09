/*
 修改姓名
 */

#import "PersonalNameController.h"
#import "ChangeNameView.h"
#import "NotifitionSender.h"

@interface PersonalNameController () <ChangeNameViewDelegate>

@property (nonatomic,weak) ChangeNameView *changeNameView;
@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation PersonalNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"姓名";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //创建视图
    ChangeNameView *tempview = [[ChangeNameView alloc] initWithFrame:self.view.bounds andUserName:self.userName];
    self.changeNameView = tempview;
    [self.view addSubview:self.changeNameView];
}

/**
 *  懒加载 alertController
 */
- (UIAlertController *)alertController {
    if (! _alertController) {
        
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        
        //取消按钮
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        [_alertController addAction:cancel];
    }
    
    return _alertController;
}

#pragma mark 自定义方法
/** 确定修改按钮方法*/
- (void)changeNameClick {
    //如果为空
    if ([self.changeNameView.tfName.text isEqualToString:@""]) {
        //推出alert
        self.alertController.message = @"名字不能为空!";
        [self presentViewController:self.alertController animated:YES completion:nil];
    } else if (self.changeNameView.tfName.text.length > 8) {
        //推出alert
        self.alertController.message = @"名字长度不能超过8位!";
        [self presentViewController:self.alertController animated:YES completion:nil];
    }
    else {
        //发送通知
        [NotifitionSender changeUserName:self.changeNameView.tfName.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
