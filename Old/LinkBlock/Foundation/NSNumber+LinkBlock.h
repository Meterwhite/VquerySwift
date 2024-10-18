//
//  NSNumber+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/4.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(NSNumberLinkBlock)

#pragma mark - Foundation Speed/速度
/**
 use the same name macros of this is better
 */
@property LB_BK BOOL         (^numIsGreatThanNum)(NSNumber* num);
@property LB_BK NSNumber*    (^numIsGreatThanNumAs)(NSNumber* num);
@property LB_BK BOOL         (^numIsGreatEqualNum)(NSNumber* num);
@property LB_BK NSNumber*    (^numIsGreatEqualNumAs)(NSNumber* num);
@property LB_BK BOOL         (^numIsLessThanNum)(NSNumber* num);
@property LB_BK NSNumber*    (^numIsLessThanNumAs)(NSNumber* num);
@property LB_BK BOOL         (^numIsLessEqualNum)(NSNumber* num);
@property LB_BK NSNumber*    (^numIsLessEqualNumAs)(NSNumber* num);
/** Determine Integer type/是否是整数类型 */
@property LB_BK BOOL         (^numIsIntegerType)(void);
/** Determine Floating type/是否是浮点数类型 */
@property LB_BK BOOL         (^numIsFloatingType)(void);
/** Determine c char/是否是c字符类型 */
@property LB_BK BOOL         (^numIsCharType)(void);
@property LB_BK BOOL         (^numIsBOOL)(void);
@property LB_BK BOOL         (^numIsChar)(void);
@property LB_BK BOOL         (^numIsShort)(void);
@property LB_BK BOOL         (^numIsInt)(void);
@property LB_BK BOOL         (^numIsLong)(void);
@property LB_BK BOOL         (^numIsLongLong)(void);
@property LB_BK BOOL         (^numIsUnsignedChar)(void);
@property LB_BK BOOL         (^numIsUnsignedShort)(void);
@property LB_BK BOOL         (^numIsUnsignedInt)(void);
@property LB_BK BOOL         (^numIsUnsignedLong)(void);
@property LB_BK BOOL         (^numIsUnsignedLongLong)(void);
@property LB_BK BOOL         (^numIsFloat)(void);
@property LB_BK BOOL         (^numIsDouble)(void);
/** Determine 0(NSDecimalNumber.zero) */
@property LB_BK BOOL         (^numIsZero)(void);
@property LB_BK NSNumber*    (^numIsZeroAs)(void);


#pragma mark - Foundation Extend/补充
/** Determine if include the value of decimal places:1.00=YES/包含小数位 */
@property LB_BK BOOL         (^numHasDecimalValue)(void);
@property LB_BK NSNumber*    (^numHasDecimalValueAs)(void);
/** 判断奇数 */
@property LB_BK BOOL         (^numIsOdd)(void);
@property LB_BK NSNumber*    (^numIsOddAs)(void);
/** 判断偶数 */
@property LB_BK BOOL         (^numIsEven)(void);
@property LB_BK NSNumber*    (^numIsEvenAs)(void);
/** 判断负数 */
@property LB_BK BOOL         (^numIsNegative)(void);
@property LB_BK NSNumber*    (^numIsNegativeAs)(void);
/** 判断NaN(notANumber) */
@property LB_BK BOOL         (^numIsNaN)(void);
/** 取相反数 (YES.NO),(123,-123) */
@property LB_BK NSNumber*    (^numReverse)(void);


#pragma mark - Weak coding/弱类型编码
@property LB_BK NSDate*      (^numToNSDateSince1970)(void);
@property LB_BK UIFont*      (^numToUIFontSystemSize)(void);
/** @(0x969696) */
@property LB_BK UIColor*     (^numToUIColorFromHex)(void);
/**
 @(3.1415926)=>@"3.14" by digit==2
 digit==0 means integer
 */
@property LB_BK NSString*           (^numToStrFloating)(NSUInteger digit);
/** @(0.231) => @"23.1%",digit==1 */
@property LB_BK NSMutableString*    (^numToStrPercent)(NSUInteger digit);
@property LB_BK NSString*    (^numToStrByMaxDecimalWidth)(NSUInteger maxDigit);
/**
 *  作为索引取值
 *  objs.class∈{respondsToSelector(objectAtIndex:),UIView,CALayer,NSString,NSAttributeString }
 */
@property LB_BK NSObject*    (^numAsIndexToGetValueFromObj)(id obj);

@end

@interface NSNumber (NSNumberLinkBlock)

/** for循环，正序遍历 [0,idx) */
- (void)numForLoopASC:(void(^)(int idx))forBlock;
/** for循环，倒序遍历 (idx,0] */
- (void)numForLoopDESC:(void(^)(int idx))forBlock;
@end
