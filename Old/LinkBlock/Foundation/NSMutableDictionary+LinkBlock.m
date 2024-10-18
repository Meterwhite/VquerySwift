//
//  NSMutableDictionary+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSMutableDictionaryLinkBlock)
/** ********************NSAttributeString部分******************** */
#pragma mark - NSAttributeString部分

- (NSMutableDictionary *(^)(CGFloat, UIColor *))makeAttrDictFontSizeAndTextColor
{
    return ^id(CGFloat fontSize , UIColor* titleColor){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictFontSizeAndTextColor,fontSize,titleColor)
        if([titleColor isKindOfClass:[UIColor class]]){
            _self[NSForegroundColorAttributeName]= titleColor;
        }
        _self[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
        return _self;
    };
}

- (NSMutableDictionary *(^)(UIFont *))makeAttrDictFont
{
    return ^id(UIFont *font){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictFont,font)
        if([font isKindOfClass:[UIFont class]]){
            _self[NSFontAttributeName]= font;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(UIColor *))makeAttrDictTextColor
{
    return ^id(UIColor *color){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictTextColor,color)
        if([color isKindOfClass:[UIColor class]]){
            _self[NSForegroundColorAttributeName]= color;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(UIColor *))makeAttrDictBGColor
{
    return ^id(UIColor *color){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictBGColor,color)
        if([color isKindOfClass:[UIColor class]]){
            _self[NSBackgroundColorAttributeName]= color;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSTextAttachment *))makeAttrDictAttachment
{
    return ^id(NSTextAttachment* attachment){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictAttachment,attachment)
        if([attachment isKindOfClass:[NSTextAttachment class]]){
            _self[NSAttachmentAttributeName]= attachment;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSParagraphStyle* paragraphStyle))makeAttrDictParagraphStyle
{
    return ^id(NSParagraphStyle* paragraphStyle){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictParagraphStyle,paragraphStyle)
        if([paragraphStyle isKindOfClass:[NSParagraphStyle class]]){
            _self[NSParagraphStyleAttributeName]= paragraphStyle;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber*))makeAttrDictLigature
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictLigature,num)
        if([num isKindOfClass:[NSNumber class]])
            _self[NSLigatureAttributeName]= num;
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber*))makeAttrDictKern
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictKern,num)
        if([num isKindOfClass:[NSNumber class]])
            _self[NSKernAttributeName]= num;
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber*))makeAttrDictStrikethroughStyle
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictStrikethroughStyle,num)
        if([num isKindOfClass:[NSNumber class]])
            _self[NSStrikethroughStyleAttributeName]= num;
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSUnderlineStyle))makeAttrDictUnderlineStyle
{
    return ^id(NSUnderlineStyle underlineStyle){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictUnderlineStyle,underlineStyle)
        _self[NSUnderlineStyleAttributeName]= @(underlineStyle);
        return _self;
    };
}

- (NSMutableDictionary *(^)(UIColor*))makeAttrDictStrokeColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictStrokeColor,color)
        if([color isKindOfClass:[UIColor class]]){
            _self[NSStrokeColorAttributeName]= color;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber *))makeAttrDictStrokeWidth
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictStrokeWidth,num)
        if([num isKindOfClass:[NSNumber class]]){
            _self[NSStrokeWidthAttributeName]= num;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSShadow*))makeAttrDictShadow
{
    return ^id(NSShadow* shadown){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictShadow,shadown)
        if([shadown isKindOfClass:[NSShadow class]]){
            _self[NSShadowAttributeName]= shadown;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSString*))makeAttrDictTextEffect
{
    return ^id(NSString* textEffect){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictTextEffect,textEffect)
        if([textEffect isKindOfClass:[NSString class]]){
            _self[NSTextEffectAttributeName]= textEffect;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSURL*))makeAttrDictLink
{
    return ^id(NSURL* linkURL){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictLink,linkURL)
        if([linkURL isKindOfClass:[NSURL class]]){
            _self[NSLinkAttributeName]= linkURL;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber *))makeAttrDictBaselineOffset
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictBaselineOffset,num)
        if([num isKindOfClass:[NSNumber class]]){
            _self[NSBaselineOffsetAttributeName]= num;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(UIColor*))makeAttrDictUnderlineColor
{
    return ^id(UIColor* underlineColor){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictUnderlineColor,underlineColor)
        if([underlineColor isKindOfClass:[UIColor class]]){
            _self[NSUnderlineColorAttributeName]= underlineColor;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(UIColor*))makeAttrDictStrikethroughColor
{
    return ^id(UIColor* bgColor){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictStrikethroughColor,bgColor)
        if([bgColor isKindOfClass:[UIColor class]]){
            _self[NSStrikethroughColorAttributeName]= bgColor;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber *))makeAttrDictObliquenes
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictObliquenes,num)
        if([num isKindOfClass:[NSNumber class]]){
            _self[NSObliquenessAttributeName]= num;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber *n))makeAttrDictExpansion
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictExpansion,num)
        if([num isKindOfClass:[NSNumber class]]){
            _self[NSExpansionAttributeName]= num;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSArray*))makeAttrDictWritingDirection
{
    return ^id(NSArray* writingDirection){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictWritingDirection,writingDirection)
        if([writingDirection isKindOfClass:[NSArray class]]){
            _self[NSWritingDirectionAttributeName]= writingDirection;
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSNumber *))makeAttrDictVerticalGlyphForm
{
    return ^id(NSNumber *num){
        LinkHandle_REF(NSMutableDictionary)
        LinkGroupHandle_REF(makeAttrDictVerticalGlyphForm,num)
        if([num isKindOfClass:[NSNumber class]]){
            _self[NSVerticalGlyphFormAttributeName]= num;
        }
        return _self;
    };
}

@end
