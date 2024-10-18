//
//  NSMutableString+LinkBlock.h

//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define NSMutableStringNew ([NSMutableString new])

@interface NSObject(NSMutableStringLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK NSMutableString*     (^m_strInsertStrAt)(NSString* str, NSUInteger idx);
@property LB_BK NSMutableString*     (^m_strAppend)(id obj);
@property LB_BK NSMutableString*     (^m_strReplace)(NSString* replaceStr, NSString* withStr);
@property LB_BK NSMutableString*     (^m_strDeleteInRange)(NSRange range);

#pragma mark - Foundation Speed/速度
/** @"" */
@property LB_BK NSMutableString*     (^m_strClear)(void);

@end


@interface NSMutableString (NSMutableStringLinkBlock)
/** Enumerate string by composed and modify. */
- (void)m_strEnumerateComposedModifiedUsingBlock:(void(^)(NSString** string,NSRange range,BOOL *stop))block;
@end
