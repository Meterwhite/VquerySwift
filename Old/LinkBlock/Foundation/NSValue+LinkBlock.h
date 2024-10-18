//
//  NSValue+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/7.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef NSValueNew
#define NSValueNew(...) ((NSValue*)(LBBoxValue((__VA_ARGS__))))
#endif


@interface NSObject(NSValueLinkBlock)
#pragma mark - Foundation Speed/速度
@property LB_BK CGFloat          (^valueCGRectX)(void);
@property LB_BK CGFloat          (^valueCGRectY)(void);
@property LB_BK CGPoint          (^valueCGRectOrigin)(void);
@property LB_BK CGSize           (^valueCGRectSize)(void);
@property LB_BK CGFloat          (^valueCGRectMinX)(void);
@property LB_BK CGFloat          (^valueCGRectMidX)(void);
@property LB_BK CGFloat          (^valueCGRectMaxX)(void);
@property LB_BK CGFloat          (^valueCGRectMinY)(void);
@property LB_BK CGFloat          (^valueCGRectMidY)(void);
@property LB_BK CGFloat          (^valueCGRectMaxY)(void);
@property LB_BK CGFloat          (^valueCGRectWidth)(void);
@property LB_BK CGFloat          (^valueCGRectHeight)(void);
@property LB_BK NSNumber*        (^valueCGRectContainsRect)(CGRect rect);
@property LB_BK NSNumber*        (^valueCGRectContainsPoint)(CGPoint rect);
@property LB_BK CGFloat          (^valueCGSizeWidth)(void);
@property LB_BK CGFloat          (^valueCGSizeHeight)(void);
@property LB_BK CGFloat          (^valueCGPointX)(void);
@property LB_BK CGFloat          (^valueCGPointY)(void);
@property LB_BK CGFloat          (^valueCGVectorX)(void);
@property LB_BK CGFloat          (^valueCGVectorY)(void);
@property LB_BK NSUInteger       (^valueNSRangeLength)(void);
@property LB_BK NSUInteger       (^valueNSRangeLocation)(void);


#pragma mark - Foundation Extend/补充
/** 数字或结构体是否是初始值 */
@property LB_BK BOOL             (^valueIsBlank)(void);
/** NSNumber,c number */
@property LB_BK NSNumber *       (^valueIsNumberAs)(void);
/** struc and Class */
@property LB_BK NSNumber *       (^valueIsStructAs)(void);

#pragma mark - LinkBlock
/**
 *  Get value by keyPath from struct of NSValue.
 *  keyPath is liked @"size.width".
 *  structValue.valueStructValueForKeyPath( @1 , @"size.width" );
 */
@property LB_BK NSValue*         (^valueStructValueForKeyPath)(NSString* keyPath);
/**
 *  Refer to : valueStructValueForKeyPath
 *  note: New value will be returnd.Use new point to receive it.
 */
@property LB_BK NSValue*         (^valueStructSetValueForKeyPath)(id value,NSString* keyPath);

@end
