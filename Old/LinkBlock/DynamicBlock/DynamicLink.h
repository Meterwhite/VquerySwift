//
//  DynamicLink.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/15.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicLinkAction;
@class DynamicLinkArgument;


/**
 Declare dynamic link/动态链条的定义
 */
@interface DynamicLink : NSObject

+ (instancetype)dynamicLinkWithCode:(NSString*)code;

/**
 script
 */
@property (nonatomic,readonly) NSString* code;

/**
 number of callee
 */
@property (nonatomic,assign,readonly) NSUInteger countOfItems;

/**
 Get the dynamic call object at indexPath/获取indexPath处的动态调用对象

 @param indexPath At least a path of length 1 is required/至少需要长度为1的路径
 */
- (DynamicLinkAction*)blockAtIndexPath:(NSIndexPath*)indexPath;

/**
 Get the parameters on the dynamic chain at indexPath/获取indexPath处的动态链条上的参数

 @param indexPath At least a path of length 2 is required/至少需要长度为2的路径
 */
- (DynamicLinkArgument*)argumentAtIndexPath:(NSIndexPath*)indexPath;

/**
 Execute a dynamic chain and return execution results/执行动态链条并返回执行结果

 @param origin Object of the execution chain/执行链条的对象
 @param list Input parameter list/输入参数的参数列表
 @return Return value (boxed), if the void return type will return nil or otherwise NSNull form packing result/返回值（装箱的,如果void返回类型才会返回nil否则是NSNull形式的装箱结果.
 */
- (id)invoke:(id)origin args:(va_list*)list;
@end
