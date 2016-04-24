/*
 个人信息model
 */

#import "User.h"

@implementation User

/**
 *  通过字典初始化模型
 *
 *  @param userDic 用户字典
 */
- (instancetype)initWithUserDic:(NSDictionary*)userDic {
    self = [super init];
    if (self) {
        
        self.userId = [userDic[@"userId"] intValue];
        self.userName = userDic[@"userName"];
        self.userPhone = userDic[@"userPhone"];
        self.portrait = userDic[@"portrait"];
        
        //判断性别
        if (userDic[@"sex"] == 0) {
            self.sex = @"男";
        } else {
            self.sex = @"女";
        }
        
    }
    return self;
}


@end
