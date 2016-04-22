/*
 FMDB
 */

#import <Foundation/Foundation.h>

@class Commodity;

@interface FMDBsql : NSObject


/**
 *  获取购物车商品数据
 *
 *  @return 购物车商品(字典)数组
 */
- (NSArray *)getShopcartComms;
/**
 *  修改购物车商品数据(数量)
 *
 *  @param commid 修改的商品id
 *  @param selectedNum 选择的数量   （两种情况 数量0的时候：删除   非0的时候：修改）
 */
- (void)updateShopcartComm:(int)commid andSelectedNum:(int)selectedNum;
- (void)insertShopcartComm:(Commodity*)comm;

@end
