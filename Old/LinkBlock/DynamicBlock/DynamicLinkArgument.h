//
//  DynamicLinkArgument.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/15.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DynamicLinkArgument;

/**
 DynamicLink Literal/字面量
 "actionName(*0,*1,LiteralAt2,*3)".linkCodeEval(target , arg0 , arg1 ,arg3)
 The parameter position that does not pass the literal value leaves the corresponding comma! In the above example, the 'literal quantity' is used as the third parameter by the block instead of using the first incoming parameter arg1 as the first input parameter. value.
 不通过字面量传值的参数位置则留下对应的逗号!上方样例中'字面量'作为第3个参数被block使用而不是使用第1个传入的参数arg1作为第一个入参的值。
 
 Literal form/字面量的形式
 ********************************
 Number, Hex number：       -123.456"，0xdcdcdc；
 Integer type to long , floating type to double
 Supports complex math expressions such as '1+Math.sin(-1)', which support javascript's Math library functions/支持形如 1+Math.sin(-1) 这样的复杂算术表达式，数学函数支持javascript的Math库函数
 ********************************
 String：                    @\"短空长多\"
 ********************************
 Boolean：                   YES,true
 ********************************
 c string：                   "短空长多"
 ********************************
 char：                      'A'
 ********************************
 NSNumber：                  @(123.456),@123.456,@YES,@true
 ********************************
 SEL：                       @selector(viewDidLoad)
 ********************************
 struct：                    STRUCTMake(...);(CGSizeMake(0,0))
 ********************************
 Class：                     NSString
 ********************************
 DynamicLinkCode:           Parameters can be in the form of code, but cannot be passed/参数可以是代码的形式，但是不能接受传参
 */
@interface DynamicLinkArgument : NSObject

/**
 Returns DynamicLinkArgument based on the user script code; the wrong script code will generate an unverified parameter object, which will return nil
 根据用户脚本代码返回DynamicLinkArgument；错误的脚本代码会生成未验证的参数对象，在这里会返回nil
 */
+ (instancetype)dynamicLinkArgumentFromVlueCode:(NSString*)code;
/**
 Verify status, unverified parameters are not recognized
 验证状态，未验证的参数是不能识别的
 */
@property (nonatomic,assign,readonly) BOOL validate;
/**
 The path of the current parameter in the entire chain, the length is at least 2, and the index is 1
 当前参数在整个链条中的的路径，长度至少为2，索引是1处
 Exp: "block0().block1()...blockN(0,1,x)", x = NSIndexPath*(N,2);
 */
@property (nonatomic,strong,readonly) NSIndexPath* indexPath;
/**
 The position of the current dynamic block in the entire chain, equivalent to the index 1 of self.indexPath
 当前动态block在整个链条中的的位置，等同于self.indexPath的索引1处
 */
@property (nonatomic,assign,readonly) NSUInteger index;
/**
 The script code of the parameter specified by the user in the block/用户在block
 指定的参数的脚本代码
 */
@property (nonatomic,copy,readonly) NSString* stringValue;
@property (nonatomic,assign,readonly) const char* objcType;
@property (nonatomic,strong,readonly) NSValue* objcValue;
@end
