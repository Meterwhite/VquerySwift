//
//  DynamicLinkAction.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/15.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicLinkArgument;


/**
 One call on the dynamic chain/动态链条上的一次调用
 */
@interface DynamicLinkAction : NSObject

/**
 Create dynamic blocks using block script code/使用block脚本代码创建动态block
 @return And the wrong script code will return nil/而错误的脚本代码会返回nil
 */
+ (instancetype)dynamicLinkBlockWithCode:(NSString*)code index:(NSUInteger)index;


/**
 Each parameter type of block is in this array/block的每个参数类型在这个数组中
 */
@property (nonatomic,strong,readonly) NSArray<NSString*>* objcTypeOfArguments;

/**
 Block return value type/block的返回值类型
 */
@property (nonatomic,assign,readonly) const char* objcTypeOfActionReturn;

/**
 The total number of parameters of the block (different from the counting method of NSInvocation)/block的参数总数（区别于NSInvocation的计数方式）
 */
@property (nonatomic,assign,readonly) NSUInteger numberOfArguments;

/**
 The memory size of the block return value/block返回值的内存大小
 */
@property (nonatomic,assign,readonly) NSUInteger lengthOfActionReturn;


/**
 Execute the current block and return the execution result/执行当前block并返回执行结果

 @param origin Object of the execution chain/执行链条的对象
 @param vlist Input parameter list/输入参数的参数列表
 @param end Parameter list traversal status pointer/参数列表遍历状态的指针
 @return Return value (boxed), if the void return type will return nil or otherwise NSCull form packing result/返回值（装箱的），如果void返回类型才会返回nil否则是NSNull形式的装箱结果
 */
- (id)invoke:(id)origin args:(va_list*)vlist end:(BOOL*)end;


/**
 Verify status, unverified blocks are not callable, causing the program to crash/验证状态，未验证的block是不可调用的，会导致程序崩溃
 */
@property (nonatomic,assign,readonly) BOOL validate;

/**
 User's script code/用户的脚本代码
 */
@property (nonatomic,copy,readonly) NSString* stringValue;

/**
 Call name/调用名
 */
@property (nonatomic,copy,readonly) NSString* actionName;

/**
 The path of the current dynamic block in the entire chain, the length is at least 1, and the index is 0./当前动态block在整个链条中的的路径，长度至少为1，索引是0
 */
@property (nonatomic,strong,readonly) NSIndexPath* indexPath;
/**
 The position of the current dynamic block in the entire chain/
 当前动态block在整个链条中的的位置，等同于self.indexPath的索引0处
 Exp："block0().block1()...blockN(0,1,x)"
 */
@property (nonatomic,assign,readonly) NSUInteger index;

/**
 Number of parameters on the dynamic chain/动态链条上参数的个数
 */
@property (nonatomic,assign,readonly) NSUInteger countOfItems;


/**
 Whether there is a child of the path in the block/block中是否有该路径的子节点
 */
- (BOOL)containsIndexPathOfItem:(NSIndexPath*)indexPath;

/**
 Try to get a child node under a path, return nil if there is no match/尝试获取一个路径下的子节点，没有匹配时返回nil
 */
- (DynamicLinkArgument*)argumentAtIndexPath:(NSIndexPath*)indexPath;
@end
