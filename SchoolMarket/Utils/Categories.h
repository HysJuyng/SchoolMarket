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

/**  类别名称 */
@property (nonatomic, copy) NSString *name;
/**  子类别名称 */
@property (nonatomic, strong) NSArray *subCategories;


/** 使用字典实例化模型 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
/** 类方法快速实例化一个对象 */
+ (instancetype)categoriesWithDict:(NSDictionary *)dict;

+ (NSArray *)categoriesList;

@end
