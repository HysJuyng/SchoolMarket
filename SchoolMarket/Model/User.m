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
        int sex = [userDic[@"sex"] intValue];
        if (sex == 0) {
            self.sex = @"男";
        } else if (sex == 1) {
            self.sex = @"女";
        } else {
            self.sex = @"未设定";
        }
        
    }
    return self;
}
/** 模型转字典*/
- (NSDictionary*)userToDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[NSString stringWithFormat:@"%d",self.userId] forKey:@"userId"];
    [dic setObject:self.userName forKey:@"userName"];
    [dic setObject:self.userPhone forKey:@"userPhone"];
    [dic setObject:self.portrait forKey:@"portrait"];
    
    if ([self.sex isEqualToString:@"男"]) {
        [dic setObject:@"0" forKey:@"sex"];
    } else if ([self.sex isEqualToString:@"女"]) {
        [dic setObject:@"1" forKey:@"sex"];
    } else {
        [dic setObject:@"3" forKey:@"sex"];
    }
    
    return dic;
}

@end
