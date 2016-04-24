/*
 FMDB
 */

#import <Foundation/Foundation.h>

@class Commodity;
@class User;

@interface FMDBsql : NSObject


/**
 *  获取购物车商品数据
 *
 *  @return 购物车商品(字典)数组
 */
+ (NSArray *)getShopcartComms;
/**
 *  修改购物车商品数据(数量)
 *
 *  @param commid 修改的商品id
 *  @param selectedNum 选择的数量   （两种情况 数量0的时候：删除   非0的时候：修改）
 */
+ (void)updateShopcartComm:(int)commid andSelectedNum:(int)selectedNum;

/**
 *  插入购物车商品
 *
 *  @param comm 商品内容
 */
+ (void)insertShopcartComm:(Commodity*)comm;



/**
 *  保存个人信息
 *
 *  @param user 用户信息
 */
+ (void)savePersonalMsg:(User*)user;
/**
 *  获取用户信息
 *
 *  @param userid 用户id
 *
 *  @return 用户信息
 */
+ (User*)getUserMsg:(int)userid;
/**
 *  修改用户信息
 *
 *  @param user 用户信息
 */
+ (void)updateUserMsg:(User*)user;

@end
