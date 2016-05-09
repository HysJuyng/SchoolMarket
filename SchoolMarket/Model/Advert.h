/*
 广告model
 */

#import <Foundation/Foundation.h>

@interface Advert : NSObject


/**
 *  广告id
 */
@property (nonatomic,assign) int advertiseId;
/**
 *  超市id
 */
@property (nonatomic,assign) int supermarket;
/**
 *  广告图片
 */
@property (nonatomic,copy) NSString *advertisePic;
/**
 *  链接
 */
@property (nonatomic,copy) NSString *linkContent;

//初始化
- (instancetype)initWitDic:(NSDictionary*)dic;

@end
