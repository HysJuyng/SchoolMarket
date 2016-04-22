/*
 FMDB
 */

#import "FMDBsql.h"
#import "FMDB.h"

static FMDatabase *db;

@implementation FMDBsql

/**
 *  初始化
 */
+ (void)initialize {
    //打开数据库 若不存在则创建
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SchoolMarket.sqlite"];
    db = [FMDatabase databaseWithPath:path];
    [db open];
    
    //建表
    /**
     *  购物车表
     *
     *  @param KEY id       主键
     *  @param shopcartComm 商品内容
     *  @param commid       商品id
     *  @param mainclassid  主分类id
     *  @param subclassid   次分类id
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shopcart (id integer PRIMARY KEY,shopcartComm blob NOT NULL,commid integer NOT NULL,mainclassid integer NOT NULL,subclassid integer NOT NULL);"];
    
    /**
     *  用户信息表
     *
     *  @param KEY id     主键
     *  @param user       用户信息
     *  @param userphone  用户手机
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY,user blob NOT NULL,userphone integer NOT NULL);"];
}

/**
 *  获取购物车商品数据
 *
 *  @return 购物车商品(字典)数组
 */
- (NSArray *)getShopcartComms {
    //结果集
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_shopcart;"];
    NSMutableArray *comms = [NSMutableArray array];
    while (rs.next) {
        Commodity *comm = [rs objectForColumnName:@"shopcartComm"];
        [comms addObject:comm];
    }
    return comms;
}

@end
