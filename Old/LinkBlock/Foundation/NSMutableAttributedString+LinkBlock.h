//
//  NSMutableAttributedString+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef NSMutableAttributedStringNew
#define NSMutableAttributedStringNew ([NSMutableAttributedString new])
#endif
@interface NSObject(NSMutableAttributedStringLinkBlock)

@property LB_BK NSMutableAttributedString* (^m_attr_strAppendAttrStr)(NSAttributedString* attrStr);

@property LB_BK NSMutableAttributedString* (^m_attr_strAppendStr)(NSString* str);

@property LB_BK NSMutableAttributedString* (^m_attr_strAppendStrAndAttr)(NSString *str,NSString *attrName, id attrValue);

@property LB_BK NSMutableAttributedString* (^m_attr_strAppendStrWithAttrDict)(NSString* str, NSDictionary* attrDic);

@property LB_BK NSMutableAttributedString* (^m_attr_strInsertAttrStrAtIndex)(NSAttributedString* attrStr, NSUInteger index);

@property LB_BK NSMutableAttributedString* (^m_attr_strInsertStrAtIndex)(NSString* str , NSUInteger index);

@property LB_BK NSMutableAttributedString* (^m_attr_strInsertStrWithAttrAtIndex)(NSString *str,NSString *attrName, id attrValue,NSUInteger idx);

@property LB_BK NSMutableAttributedString* (^m_attr_strInsertStrWithAttrDict)(NSString* str, NSDictionary* attrDic, NSUInteger index);

/** Basic property */
@property LB_BK NSMutableAttributedString* (^m_attr_strAddAttrFont)(UIFont* font);
/** Basic property */
@property LB_BK NSMutableAttributedString* (^m_attr_strAddAttrTextColor)(UIColor* color);

@property LB_BK NSMutableAttributedString* (^m_attr_strAddAttrInRange)(NSString*attrName, id attrValue, NSRange range);

@property LB_BK NSMutableAttributedString* (^m_attr_strAddAttr)(NSString*attrName, id attrValue);

@property LB_BK NSMutableAttributedString* (^m_attr_strAddAttrDict)(NSDictionary* attrDict);

@property LB_BK NSMutableAttributedString* (^m_attr_strAddAttrBGColor)(UIColor* bgColor);

@property LB_BK NSMutableAttributedString* (^m_attr_strRemoveAttr)(NSString* attrName);

@property LB_BK NSMutableAttributedString* (^m_attr_strRemoveAttrInRange)(NSString* attrName, NSRange range);

@property LB_BK NSMutableAttributedString* (^m_attr_strDeleteStrInRange)(NSRange range);

@property LB_BK NSMutableAttributedString* (^m_attr_strReplaceStrWithStrInRange)(NSString *str,NSRange range);

@property LB_BK NSMutableAttributedString* (^m_attr_strSetAttrForStr)(NSString *tagStr,NSDictionary* attrDict);

@property LB_BK NSMutableAttributedString* (^m_attr_strSetAttrForStrInRange)(NSString *forStr,NSDictionary* attrDict, NSRange range);

@property LB_BK NSMutableAttributedString* (^m_attr_strSetAttrDictInRange)(NSDictionary *attrDict, NSRange range);

@property LB_BK NSMutableAttributedString* (^m_attr_strSetAttrDict)(NSDictionary* attrDict);
@property LB_BK UIView* (^m_attr_strSetToControlAsWhatSet)(UIView* ctrl);
@end
