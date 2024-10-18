//
//  NSMutableDictionary+Linkm_dict.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef NSMutableDictionaryNew
#define NSMutableDictionaryNew ([NSMutableDictionary new])
#endif

@interface NSObject(NSMutableDictionaryLinkBlock)
#pragma mark - Foundation Speed/速度
#pragma  mark - NSAttributeString
/** ********************For NSAttributeString******************** */

#ifndef AttrDictNew
#define AttrDictNew NSMutableDictionaryNew
#endif

#ifndef AttrDictNewWithSize
#define AttrDictNewWithSize(size) (NSMutableDictionaryNew.makeAttrDictFontSizeAndTextColor(size, [UIColor blackColor]))
#endif


@property LB_BK NSMutableDictionary* (^makeAttrDictFontSizeAndTextColor)(CGFloat fontSize , UIColor* titleColor);
@property LB_BK NSMutableDictionary* (^makeAttrDictFont)(UIFont* font);
@property LB_BK NSMutableDictionary* (^makeAttrDictTextColor)(UIColor* textColor);
@property LB_BK NSMutableDictionary* (^makeAttrDictBGColor)(UIColor* bgColor);
@property LB_BK NSMutableDictionary* (^makeAttrDictAttachment)(NSTextAttachment* attachment);
@property LB_BK NSMutableDictionary* (^makeAttrDictParagraphStyle)(NSParagraphStyle* paragraphStyle);
@property LB_BK NSMutableDictionary* (^makeAttrDictLigature)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictKern)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictStrikethroughStyle)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictUnderlineStyle)(NSUnderlineStyle underlineStyle);
@property LB_BK NSMutableDictionary* (^makeAttrDictStrokeColor)(UIColor* bgColor);
@property LB_BK NSMutableDictionary* (^makeAttrDictStrokeWidth)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictShadow)(NSShadow* shadown);
@property LB_BK NSMutableDictionary* (^makeAttrDictTextEffect)(NSString* textEffect);
@property LB_BK NSMutableDictionary* (^makeAttrDictLink)(NSURL* linkURL);
@property LB_BK NSMutableDictionary* (^makeAttrDictBaselineOffset)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictUnderlineColor)(UIColor* underlineColor);
@property LB_BK NSMutableDictionary* (^makeAttrDictStrikethroughColor)(UIColor* bgColor);
@property LB_BK NSMutableDictionary* (^makeAttrDictObliquenes)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictExpansion)(NSNumber *num);
@property LB_BK NSMutableDictionary* (^makeAttrDictWritingDirection)(NSArray* writingDirection);
@property LB_BK NSMutableDictionary* (^makeAttrDictVerticalGlyphForm)(NSNumber *num);
@end

