//
//  NSMutableAttributedString+LinkBlock.m

//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSMutableAttributedStringLinkBlock)
- (NSMutableAttributedString *(^)(NSAttributedString *))m_attr_strAppendAttrStr
{
    return ^id(NSAttributedString* attrStr){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAppendAttrStr,attrStr)
        if([attrStr isKindOfClass:[NSAttributedString class]])
            [_self appendAttributedString:attrStr];
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))m_attr_strAppendStr
{
    return ^id(NSString *str){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAppendStr,str)
        if(([str isKindOfClass:[NSString class]])){
            NSAttributedString *attStr= [[NSAttributedString alloc] initWithString:str];
            [_self appendAttributedString:attStr];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSString *, id))m_attr_strAppendStrAndAttr
{
    return ^id(NSString *str, NSString* attrName, id attrValue){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAppendStrAndAttr,str,attrName,attrValue)
        if([str isKindOfClass:[NSString class]] && [attrName isKindOfClass:[NSString class]] && attrValue){
            NSAttributedString *tNewAttrStr= [[NSAttributedString alloc] initWithString:str attributes:@{attrName:attrValue}];
            [_self appendAttributedString:tNewAttrStr];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSDictionary *))m_attr_strAppendStrWithAttrDict
{
    return ^id(NSString *str, NSDictionary *attrDic){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAppendStrWithAttrDict,str,attrDic)
        if([str isKindOfClass:[NSString class]] && [attrDic isKindOfClass:[NSDictionary class]]){
            NSAttributedString *tNewAttrStr= [[NSAttributedString alloc] initWithString:str attributes:attrDic];
            [_self appendAttributedString:tNewAttrStr];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSAttributedString *, NSUInteger))m_attr_strInsertAttrStrAtIndex
{
    return ^id(NSAttributedString* attrStr, NSUInteger index){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strInsertAttrStrAtIndex,attrStr,index)
        if([attrStr isKindOfClass:[NSAttributedString class]]){
            [_self insertAttributedString:attrStr atIndex:index];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSUInteger))m_attr_strInsertStrAtIndex
{
    return ^id(NSString* str , NSUInteger index){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strInsertStrAtIndex,str,index)
        if([str isKindOfClass:[NSString class]]){
            NSAttributedString *tNewAttrStr= [[NSAttributedString alloc] initWithString:str];
            [_self insertAttributedString:tNewAttrStr atIndex:index];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSString *, id, NSUInteger idx))m_attr_strInsertStrWithAttrAtIndex
{
    return ^id(NSString *str,NSString *attrName, id attrValue, NSUInteger idx){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strInsertStrWithAttrAtIndex,str,attrName,attrValue,idx)
        if([str isKindOfClass:[NSString class]] &&
           [attrName isKindOfClass:[NSString class]]&&
           attrValue){
            NSAttributedString *attrStr= [[NSAttributedString alloc] initWithString:str attributes:@{attrName:attrValue}];
            
            [_self insertAttributedString:attrStr atIndex:idx];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSDictionary *, NSUInteger))m_attr_strInsertStrWithAttrDict
{
    return ^id(NSString *str, NSDictionary *attrDic, NSUInteger index){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strInsertStrWithAttrDict,str,attrDic,index)
        if([str isKindOfClass:[NSString class]] && [attrDic isKindOfClass:[NSDictionary class]]){
            NSAttributedString *tNewAttrStr= [[NSAttributedString alloc] initWithString:str attributes:attrDic];
            [_self insertAttributedString:tNewAttrStr atIndex:index];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, id, NSRange))m_attr_strAddAttrInRange
{
    return ^id(NSString *attrName, id attrValue, NSRange range){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAddAttrInRange,attrName,attrValue,range)
        if([attrName isKindOfClass:[NSString class]]&& attrValue)
            [_self addAttribute:attrName value:attrValue range:range];
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, id))m_attr_strAddAttr
{
    return ^id(NSString *attrName, id attrValue){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAddAttr,attrName,attrValue)
        if([attrName isKindOfClass:[NSString class]]&& attrValue)
            [_self addAttribute:attrName value:attrValue range:NSMakeRange(0, _self.length)];
        return _self;
    };
}

- (NSMutableAttributedString *(^)(UIFont *))m_attr_strAddAttrFont
{
    return ^id(UIFont *font){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAddAttrFont,font)
        if([font isKindOfClass:[UIFont class]]){
            [_self addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _self.length)];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))m_attr_strAddAttrTextColor
{
    return ^id(UIColor *textColor){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAddAttrTextColor,textColor)
        if([textColor isKindOfClass:[UIColor class]]){
            [_self addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, _self.length)];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))m_attr_strAddAttrBGColor
{
    return ^id(UIColor *bgColor){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAddAttrBGColor,bgColor)
        if([bgColor isKindOfClass:[UIColor class]]){
            [_self addAttribute:NSBackgroundColorAttributeName value:bgColor range:NSMakeRange(0, _self.length)];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSDictionary *))m_attr_strSetAttrForStr
{
    return ^id(NSString *forStr,NSDictionary* attrDict){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strSetAttrForStr,forStr,attrDict)
        if([forStr isKindOfClass:[NSString class]] &&
           [attrDict isKindOfClass:[NSDictionary class]]){
            NSUInteger tCurrentIndex= 0;
            for(;;){
                NSRange range= [_self.string rangeOfString:forStr options:NSLiteralSearch range:NSMakeRange(tCurrentIndex, _self.string.length- tCurrentIndex)];
                if(range.location!= NSNotFound){
                    [_self setAttributes:attrDict range:range];
                    tCurrentIndex= range.location + range.length;
                }else{
                    break;
                }
            }
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSDictionary *, NSRange))m_attr_strSetAttrForStrInRange
{
    return ^id(NSString *forStr,NSDictionary* attrDict, NSRange range){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strSetAttrForStrInRange,forStr,attrDict,range)
        if([forStr isKindOfClass:[NSString class]]&&
           [attrDict isKindOfClass:[NSDictionary class]]){
            NSUInteger tCurrentIndex= range.location;
            for(;;){
                NSRange range2= [_self.string rangeOfString:forStr
                                                   options:NSLiteralSearch
                                                     range:NSMakeRange(tCurrentIndex, (range.location + range.length) - tCurrentIndex)];
                if(range2.location!= NSNotFound){
                    [_self setAttributes:attrDict range:range2];
                    tCurrentIndex= range.location + range2.length;
                }else{
                    break;
                }
            }
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))m_attr_strRemoveAttr
{
    return ^id(NSString* attrName){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strRemoveAttr,attrName)
        if([attrName isKindOfClass:[NSString class]]){
            [_self removeAttribute:attrName range:NSMakeRange(0, _self.length)];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSRange))m_attr_strRemoveAttrInRange
{
    return ^id(NSString* attrName,NSRange range){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strRemoveAttrInRange,attrName,range)
        if([attrName isKindOfClass:[NSString class]]){
            [_self removeAttribute:attrName range:range];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSRange))m_attr_strDeleteStrInRange
{
    return ^id(NSRange range){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strDeleteStrInRange,range)
        [_self deleteCharactersInRange:range];
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSRange))m_attr_strReplaceStrWithStrInRange
{
    return ^id(NSString *str,NSRange range){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strReplaceStrWithStrInRange,str,range)
        if([str isKindOfClass:[NSString class]]){
            [_self replaceCharactersInRange:range withString:str];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSDictionary *))m_attr_strAddAttrDict
{
    return ^id(NSDictionary* attrDict){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strAddAttrDict,attrDict)
        if([attrDict isKindOfClass:[NSDictionary class]]){
            [_self addAttributes:attrDict range:NSMakeRange(0, _self.length)];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSDictionary *))m_attr_strSetAttrDict
{
    return ^id(NSDictionary *attrDict){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strSetAttrDict,attrDict)
        if([attrDict isKindOfClass:[NSDictionary class]]){
            [_self setAttributes:attrDict range:NSMakeRange(0, _self.length)];
        }
        return _self;
    };
}

- (NSMutableAttributedString *(^)(NSDictionary *, NSRange))m_attr_strSetAttrDictInRange
{
    return ^id(NSDictionary *attrDict, NSRange range){
        LinkHandle_REF(NSMutableAttributedString)
        LinkGroupHandle_REF(m_attr_strSetAttrDictInRange,attrDict,range)
        if([attrDict isKindOfClass:[NSDictionary class]]){
            [_self setAttributes:attrDict range: range];
        }
        return _self;
    };
}

- (UIView *(^)(UIView *))m_attr_strSetToControlAsWhatSet
{
    return self.attr_strSetToControlAsWhatSet;
}

@end
