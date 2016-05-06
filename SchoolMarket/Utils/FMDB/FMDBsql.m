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
        //data转字典
        NSDictionary *commdic = [NSKeyedUnarchiver unarchiveObjectWithData:commData];
        //字典转模型
        Commodity *comm = [[Commodity alloc] initWithCommDic:commdic];
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
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM t_shopcart WHERE commid = %d;",commid]];
    } else {
        //修改  (先从数据库拿出商品data 还原成dic 再存入数据库)
        //结果集
        FMResultSet *rs = [db executeQueryWithFormat:@"SELECT * FROM t_shopcart WHERE commid = %d",commid];
        NSData *commData = [[NSData alloc] init];
        if (rs.next) {
            commData = [rs objectForColumnName:@"shopcartComm"];
        }
        //DATA转字典
        NSDictionary *commdic = [NSKeyedUnarchiver unarchiveObjectWithData:commData];
        //修改数量
        [commdic setValue:[NSString stringWithFormat:@"%d",selectedNum] forKey:@"selectedNum"];
        
        //重新把字典转data并存进数据库
        commData = [NSKeyedArchiver archivedDataWithRootObject:commdic];
        [db executeUpdateWithFormat:@"UPDATE t_shopcart SET shopcartComm = %@ WHERE commid = %d",commData,commid];
        
    }
}
/**
 *  删除购物车商品数据（单条）
 *
 *  @param commid 商品id
 */
+ (void)deleteShopcartComm:(int)commid {
    //删除
    [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM t_shopcart WHERE commid = %d;",commid]];
}
/**
 *  删除所有购物车商品
 */
+ (void)deleteAllShopcartComms {
    //删除
    [db executeUpdate:@"DELETE FROM t_shopcart;"];
}
/**
 *  插入购物车商品
 *
 *  @param comm 商品内容
 */
+ (void)insertShopcartComm:(Commodity*)comm {
    
    //模型转字典
    NSDictionary *commdic = [comm commToDictionary:comm];
    //字典转data
    NSData *commData = [NSKeyedArchiver archivedDataWithRootObject:commdic];
    //插入数据库
    [db executeUpdateWithFormat:@"INSERT INTO t_shopcart(shopcartComm,commid,mainclassid,subclassid,type) VALUES (%@,%d,%d,%d,%@);",commData,comm.commodityId,comm.mainclassId,comm.subclassId,comm.type];
}
/**
 *  获取购物车中已选的商品数量总和
 *
 *  @return 数量总和
 */
+ (int)getShopcartAllSelectedNum {
    //总和
    int sum = 0;
    //结果集
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_shopcart;"];
    while (rs.next) {
        NSData *commdata = [rs objectForColumnName:@"shopcartComm"];
        //data转字典
        NSDictionary *commdic = [NSKeyedUnarchiver unarchiveObjectWithData:commdata];
        
        //把改商品的选择的数量加在总和上
        sum += [commdic[@"selectedNum"] intValue];
    }
    return sum;
}
/**
 *  对比 数据库中已存在的购物车商品 设置其数量
 *
 *  @param comms 需要对比的商品模型数组
 */
+ (void)contrastShopcartAndModels:(NSArray *)comms {
    //结果集
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_shopcart;"];
    //结果集数组
    NSMutableArray *commArr = [[NSMutableArray alloc] init];
    NSMutableArray *commidArr = [[NSMutableArray alloc] init];
    while (rs.next) {
        
        [commidArr addObject:[rs objectForColumnName:@"commid"]];
        [commArr addObject:[rs objectForColumnName:@"shopcartComm"]];
    }
    for (Commodity *comm in comms) {
        //遍历数据库 查找存在的id
        for (int i = 0; i < commidArr.count; i++) {
            NSString* str = commidArr[i];
            if (comm.commodityId == [str intValue]) {
                //提取商品模型字典
                NSDictionary *commdic = [NSKeyedUnarchiver unarchiveObjectWithData:commArr[i]];
                //修改商品模型的数量
                comm.selectedNum = [commdic[@"selectedNum"] intValue];
                //把该结果移除
                [commArr removeObjectAtIndex:i];
                [commidArr removeObjectAtIndex:i];
            }
        }
        //若商品id数组为空 则退出循环
        if (!commidArr.count) {
            break;
        }
    }
}

#pragma mark 用户信息
/**
 *  保存个人信息
 *
 *  @param user 用户信息
 */
+ (void)savePersonalMsg:(User*)user {
    //模型转字典
    NSDictionary *userdic = [user userToDictionary:user];
    //模型转data
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userdic];
    //插入数据库
    [db executeUpdateWithFormat:@"INSERT INTO t_user(user,userid,userphone) VALUES (%@,%d,%@);",userData,user.userId,user.userPhone];
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
    FMResultSet *rs = [db executeQueryWithFormat:@"SELECT * FROM t_user WHERE userid = %d;",userid];
    User *user = [[User alloc] init];
    while (rs.next) {
        NSData *userData = [rs objectForColumnName:@"user"];
        //data转字典
        NSDictionary *userdic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        //字典转模型
        user = [[User alloc] initWithUserDic:userdic];
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
    //模型转字典
    NSDictionary *userdic = [user userToDictionary:user];
    //字典转data
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userdic];
    //修改数据库
    [db executeUpdateWithFormat:@"UPDATE t_user SET user = %@ WHERE userid = %d;",userData,user.userId];
}

@end
