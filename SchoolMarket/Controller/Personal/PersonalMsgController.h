/*
 个人信息 修改
 tableview
 头像 用户名 性别
 */

#import <UIKit/UIKit.h>
#import "PersonalHeader.h"
#import "PersonalNameController.h"

@interface PersonalMsgController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,weak) UIBarButtonItem *btnBack;  //导航栏左侧返回按钮




//打开图库
- (void)openGallery;
//跳转修改姓名
- (void)goToChangeName;
//选择性别
- (void)selectSex;
@end
