/*
 个人信息model
 */

#import <Foundation/Foundation.h>

@interface User : NSObject  <NSSecureCoding>

/**
 *  用户id
 */
@property (nonatomic,assign) int userId;
/**
 *  用户名
 */
@property (nonatomic,copy) NSString *userName;
/**
 *  用户手机
 */
@property (nonatomic,copy) NSString *userPhone;
/**
 *  性别
 */
@property (nonatomic,copy) NSString *sex;
/**
 *  头像
 */
@property (nonatomic,copy) NSString *portrait;



//初始化
/**
 *  通过字典初始化模型
 *
 *  @param userDic 用户字典
 */
- (instancetype)initWithUserDic:(NSDictionary*)userDic;

@end
