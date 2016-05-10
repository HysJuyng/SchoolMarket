/*
 FMDB
 */

#import <Foundation/Foundation.h>

@class Commodity;
@class User;

typedef void(^spComplete)(NSArray* comms);

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
 *  获取购物车中已选的商品数量总和
 *
 *  @return 数量总和
 */
+ (int)getShopcartAllSelectedNum;
/**
 *  对比 数据库中已存在的购物车商品 设置其数量
 *
 *  @param comms 需要对比的商品模型数组
 */
+ (void)contrastShopcartAndModels:(NSArray*)comms;
/**
 *  删除购物车商品数据（单条）
 *
 *  @param commid 商品id
 */
+ (void)deleteShopcartComm:(int)commid;
/**
 *  删除所有购物车商品
 */
+ (void)deleteAllShopcartComms;


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
/**
 *  删除用户信息
 *
 *  @param userid 用户id
 */
+ (void)deleteUser:(int)userid;

@end
