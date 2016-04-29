//
//  Categories.h
//  SchoolMarket
//
//  Created by tb on 16/4/2.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Categories : NSObject
/**  主分类id */
@property (nonatomic, assign) int mainclassId;
/**  主分类名称 */
@property (nonatomic, copy) NSString *mainclassName;
/**  子分类模型数组 */
@property (nonatomic, strong) NSArray *subClass;


/** 使用字典实例化模型 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
/** 类方法快速实例化一个对象 */
+ (instancetype)categoriesWithDict:(NSDictionary *)dict;
@end
