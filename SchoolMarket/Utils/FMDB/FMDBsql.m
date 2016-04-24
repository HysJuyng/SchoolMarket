/*
 FMDB
 */

#import "FMDBsql.h"
#import "FMDB.h"
#import "Commodity.h"
#import "User.h"

static FMDatabase *db;

@implementation FMDBsql

/**
 *  初始化
 */
+ (void)initialize {
    //打开数据库 若不存在则创建
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SchoolMarket.sqlite"];
    if (!db) {
        db = [FMDatabase databaseWithPath:path];
    }
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
     *  @param type         商品类型
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shopcart (id integer PRIMARY KEY,shopcartComm blob NOT NULL,commid integer NOT NULL,mainclassid integer NOT NULL,subclassid integer NOT NULL,type text NOT NULL);"];
    
    /**
     *  用户信息表
     *
     *  @param KEY id     主键
     *  @param user       用户信息
     *  @param userid     用户id
     *  @param userphone  用户手机
     */
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY,user blob NOT NULL,userid integer NOT NULL,userphone text NOT NULL);"];
}


#pragma mark 购物车
/**
 *  获取购物车商品数据
 *
 *  @return 购物车商品(字典)数组
 */
+ (NSArray *)getShopcartComms {
    //结果集
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_shopcart;"];
    NSMutableArray *comms = [NSMutableArray array];
    while (rs.next) {
        NSData *commData = [rs objectForColumnName:@"shopcartComm"];
        Commodity *comm = [NSKeyedUnarchiver unarchiveObjectWithData:commData];
        [comms addObject:comm];
    }
    return comms;
}

/**
 *  修改购物车商品数据(数量)
 *
 *  @param commid 修改的商品id
 *  @param selectedNum 选择的数量   （两种情况 数量0的时候：删除   非0的时候：修改）
 */
+ (void)updateShopcartComm:(int)commid andSelectedNum:(int)selectedNum {
    if (selectedNum == 0) {
        //删除
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM t_shopcart WHERE commid = %d",commid]];
    } else {
        //修改  (先从数据库拿出商品data 还原成dic 再存入数据库)
        //结果集
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_shopcart WHERE commid = %d",commid]];
        NSData *commData = [rs objectForColumnName:@"shopcartComm"];
        //DATA转模型
        Commodity *comm = [NSKeyedUnarchiver unarchiveObjectWithData:commData];
        
        //修改数量
        comm.selectedNum = selectedNum;
        
        //重新把模型转data并存进数据库
        commData = [NSKeyedArchiver archivedDataWithRootObject:comm];
        [db executeUpdateWithFormat:@"UPDATE t_shopcart SET shopcartComm = %@",commData];
        
    }
}
/**
 *  插入购物车商品
 *
 *  @param comm 商品内容
 */
+ (void)insertShopcartComm:(Commodity*)comm {
    
    //模型转data
    NSData *commData = [NSKeyedArchiver archivedDataWithRootObject:comm];
    //插入数据库
    [db executeUpdateWithFormat:@"INSTER INTO t_shopcart(shopcartComm,commid,mainclassid,subclassid,type) VALUES (%@,%d,%d,%d,%@)",commData,comm.commodityId,comm.mainclassId,comm.subclassId,comm.type];
}

#pragma mark 用户信息
/**
 *  保存个人信息
 *
 *  @param user 用户信息
 */
+ (void)savePersonalMsg:(User*)user {
    //模型转data
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    //插入数据库
    [db executeUpdateWithFormat:@"INSERT INTO t_user(user,userid,userphone) VALUES (%@,%d,%@)",userData,user.userId,user.userPhone];
}
/**
 *  获取用户信息
 *
 *  @param userid 用户id
 *
 *  @return 用户信息
 */
+ (User*)getUserMsg:(int)userid {
    //结果集
    FMResultSet *rs = [db executeQueryWithFormat:@"SELECT * FROM t_user WHERE userid = %d",userid];
    User *user = [[User alloc] init];
    while (rs.next) {
        NSData *userData = [rs objectForColumnName:@"user"];
        user = (User*)[NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    return user;
}
/**
 *  修改用户信息
 *
 *  @param user 用户信息
 */
+ (void)updateUserMsg:(User*)user {
    //直接把新的用户数据 覆盖到原来的
    //模型转data
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    //修改数据库
    [db executeUpdateWithFormat:@"UPDATE t_user SET user = %@ WHERE userid = %d",userData,user.userId];
}


@end
