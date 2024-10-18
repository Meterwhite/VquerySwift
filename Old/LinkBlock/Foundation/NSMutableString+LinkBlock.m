//
//  NSMutableString+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSMutableStringLinkBlock)
- (NSMutableString *(^)(NSString *, NSString *))m_strReplace
{
    return ^id(NSString* replace, NSString* with){
        LinkHandle_REF(NSMutableString)
        LinkGroupHandle_REF(m_strReplace,replace,with)
        
        if([replace isKindOfClass:[NSString class]] &&
           [with isKindOfClass:[NSString class]] ){
            
            return [[_self stringByReplacingOccurrencesOfString:replace withString:with] mutableCopy];
        }
        return _self;
    };
}

- (NSMutableString *(^)(NSString *, NSUInteger))m_strInsertStrAt
{
    return ^id(NSString* str, NSUInteger idx){
        LinkHandle_REF(NSMutableString)
        LinkGroupHandle_REF(m_strInsertStrAt,str,idx)
        [_self insertString:str atIndex:idx];
        return _self;
    };
}

- (NSMutableString *(^)(id))m_strAppend
{
    return ^id(id obj){
        LinkHandle_REF(NSMutableString)
        LinkGroupHandle_REF(m_strAppend,obj)
        
        if(!_self.objIsMutable()){
            
            _self = (id)_self.objNeedMutable();
            if(!_self.objIsMutable()){
                [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@ cant convert to mutable type!",_self]] logError];
                return _self;
            }
        }
        
        if(![obj isKindOfClass:[NSString class]]){
            obj = [obj description];
        }
        
        if(![obj isKindOfClass:[NSString class]]) return _self;
        
        [_self appendString:obj];
        return _self;
    };
}

- (NSMutableString *(^)(void))m_strClear
{
    return ^id(){
        LinkHandle_REF(NSMutableString)
        LinkGroupHandle_REF(m_strClear)
        [_self setString:@""];
        return _self;
    };
}

- (NSMutableString *(^)(NSRange))m_strDeleteInRange
{
    return ^id(NSRange range){
        LinkHandle_REF(NSMutableString)
        LinkGroupHandle_REF(m_strDeleteInRange,range)
        [_self deleteCharactersInRange:range];
        return _self;
    };
}
@end


@implementation NSMutableString(NSMutableStringLinkBlock)

- (void)m_strEnumerateComposedModifiedUsingBlock:(void (^)(NSString *__autoreleasing *, NSRange, BOOL *))block
{
    if(block){
        
        NSMutableString* newStr = [NSMutableString new];
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                  
            block(&substring,enclosingRange,stop);
            [newStr appendString:substring];
        }];
        [self setString:newStr];
    }
}
@end
