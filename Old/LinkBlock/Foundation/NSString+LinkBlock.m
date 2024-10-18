//
//  NSString+LinkBlock.m

//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import "LinkHelper.h"
#import <AVFoundation/AVFoundation.h>
#import "DynamicLink.h"

@implementation NSObject(NSStringLinkBlock)

- (NSMutableString *(^)(void))strMutableCopy
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strMutableCopy)
        return _self.mutableCopy;
    };
}

- (BOOL (^)(NSString *))strIsEqualStr
{
    return ^(NSString* str){
        LinkHandle_VAL_IFNOT(NSString){
            return NO;
        }
        LinkGroupHandle_VAL(strIsEqualStr,str)
        return [_self isEqualToString:str];
    };
}

- (NSNumber* (^)(NSString *))strIsEqualStrAs
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strIsEqualStrAs,str)
        return @([_self isEqualToString:str]);
    };
}

- (NSString *(^)(NSString*))strAppend
{
    return ^id(NSString* string){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strAppend,string)
        
        if(!LB_IsKindOfClass(string, NSString)) return _self;
        return [_self stringByAppendingString:string];
    };
}
- (NSMutableString *(^)(id))strAppendObj
{
    return ^id(id obj){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strAppend,obj)
        
        if(!obj) return _self;
        if(!LB_IsKindOfClass(obj, NSString)) obj = [obj description];
        if(!LB_IsKindOfClass(obj, NSString)) return _self;
        
        ///Determine if immutable string
        if(_self.copy == _self){
            LB_MCopy_VAR(_self);
        }
        
        [_self appendString:obj];
        return _self;
    };
}

- (NSString *(^)(NSString *))strAppendTo
{
    return ^id(NSString *str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strAppendTo,str)
        if([str isKindOfClass:[NSString class]]){
            return [str stringByAppendingString:_self];
        }else{
            return _self;
        }
    };
}

- (NSString *(^)(NSString *, NSString *))strReplace
{
    return ^id(NSString* replaceStr, NSString* withStr){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strReplace,replaceStr,withStr)
        
        if([replaceStr isKindOfClass:[NSString class]] &&
           [withStr isKindOfClass:[NSString class]] ){
            return [_self stringByReplacingOccurrencesOfString:replaceStr withString:withStr];
        }
        
        return _self;
    };
}

- (NSMutableString *(^)(NSString *, NSUInteger))strInsertStrAt
{
    if([self copy] == self){
        return [[self mutableCopy] m_strInsertStrAt];
    }
    return self.m_strInsertStrAt;
}

- (NSMutableString *(^)(NSRange))strDeleteInRange
{
    if([self copy] == self){
        return [[self mutableCopy] m_strDeleteInRange];
    }
    return self.m_strDeleteInRange;
}

- (NSString *(^)(NSUInteger))strAt
{
    return ^id(NSUInteger index){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strAt,index)
        if(index > _self.length - 1) return @"";
        unichar ch = [_self characterAtIndex:index];
        return [NSString stringWithCharacters:&ch length:1];
    };
}

- (NSString *(^)(NSUInteger))strComposeAt
{
    return ^id(NSUInteger index){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strComposeAt,index)
        
        NSUInteger composeCurrentIdx=0; NSRange range = NSMakeRange(NSNotFound, 0);
        for(int i=0; i<_self.length; i+=range.length){
            range = [_self rangeOfComposedCharacterSequenceAtIndex:i];
            if(composeCurrentIdx == index) break;
            if( i+range.length < _self.length) composeCurrentIdx++;
        }
        if(index > composeCurrentIdx) return @"";
        return [_self substringWithRange:range];
    };
}

- (NSString *(^)(NSString *, NSRange))strReplaceInRange
{
    return ^id(NSString* str, NSRange range){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strReplaceInRange,str,range)
        if([str isKindOfClass:[NSString class]]){
            return [_self stringByReplacingCharactersInRange:range withString:str];
        }else{
            return _self;
        }
    };
}

- (NSString *(^)(NSString *))strDeleteStr
{
    return ^id(NSString *str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strDeleteStr,str)
        if([str isKindOfClass:[NSString class]]){
            return [_self stringByReplacingOccurrencesOfString:str withString:@""];
        }
        
        return _self;
    };
}

- (NSNumber *(^)(void))strIsMutableAs
{
    if([self isKindOfClass:NSMutableString.class]){
        return self.objIsMutableAs;
    }
    return ^id(){return @NO;};
}

- (BOOL (^)(id))strContains
{
    return ^(id obj){
        return self.strContainsAs(obj).boolValue;
    };
}

- (NSNumber* (^)(id))strContainsAs
{
    return ^id(id obj){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strContainsAs,obj)
        
        if(obj && [obj isKindOfClass:NSString.class]==NO)
            obj = [obj description];
        else if (!obj)
            return @NO;
        
        return @([_self containsString:obj]);
    };
}

- (NSInteger (^)(NSString *))strIndexOfStr
{
    return ^NSInteger(NSString* str){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strIndexOfStr,str)
        if([str isKindOfClass:[NSString class]]){
            
            return [_self rangeOfString:str].location;
        }else{
            return NSNotFound;
        }
    };
}

- (BOOL (^)(void))strContainszh_CN
{
    return ^(){
        return self.strContainszh_CNAs().boolValue;
    };
}

- (NSNumber* (^)(void))strContainszh_CNAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strContainszh_CNAs)
        for(int i=0; i<_self.length; i++){
            int charS = [_self characterAtIndex:i];
            if(charS >= 0x4e00 && charS <= 0x9fff){
                return @YES;
            }
        }
        return @NO;
    };
}

- (BOOL (^)(NSRange))strIszh_CNInRange
{
    return ^(NSRange range){
        return self.strIszh_CNInRangeAs(range).boolValue;
    };
}

- (NSNumber* (^)(NSRange))strIszh_CNInRangeAs
{
    return ^id(NSRange range){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strIszh_CNInRangeAs,range)
        if( range.location>_self.length-1 || range.location+range.length>_self.length )
            return @NO;
        
        for(NSUInteger i=range.location; i<range.location+range.length; i++){
            int charS = [_self characterAtIndex:i];
            if(charS < 0x4e00 || charS > 0x9fff){//不是汉字
                return @NO;
            }
        }
        return @YES;
    };
}

//转大端
void convertToBigEndian(char* src ,NSInteger len)
{
    if(len%2 !=0)
    {
        return ;
    }
    char tmp;
    for (int i=0; i<len; i+=2)
    {
        tmp      = src [i];
        src[i]   = src[i+1];
        src[i+1] = tmp;
    }
}
NSString* httpUrlEncode(char* srcUrl , NSInteger len)
{
    if (len == 0)
    {
        return @"";
    }
    NSString* buf = @"";
    // Parse a the chars in the url
    for (int i=0; i<len; i++)
    {
        char oneChar = srcUrl[i];
        buf = [buf stringByAppendingString:urlEncodeFormat(oneChar)];
        if(i!= len-1)
        {
            buf = [buf stringByAppendingString:@""];
        }
    }
    return buf;
}
NSString* urlEncodeFormat(u_char cValue)
{
    NSString* buf=@"";

    uint nDiv = cValue/16;
    uint nMod = cValue%16;
    
    buf = [buf stringByAppendingString:decimalToHexString(nDiv)];
    buf = [buf stringByAppendingString:decimalToHexString(nMod)];
    return buf;
}
NSString* decimalToHexString(u_char nValue)
{
    NSString* tmp = @"";
    switch(nValue)
    {
        case 0:tmp = @"0";break;
        case 1:tmp = @"1";break;
        case 2:tmp = @"2";break;
        case 3:tmp = @"3";break;
        case 4:tmp = @"4";break;
        case 5:tmp = @"5";break;
        case 6:tmp = @"6";break;
        case 7:tmp = @"7";break;
        case 8:tmp = @"8";break;
        case 9:tmp = @"9";break;
        case 10:tmp = @"a";break;
        case 11:tmp = @"b";break;
        case 12:tmp = @"c";break;
        case 13:tmp = @"d";break;
        case 14:tmp = @"e";break;
        case 15:tmp = @"f";break;
        default:tmp = @"x";
            break;
    }
    return tmp;
}
- (NSString* (^)(void))strToUnicoding
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToUnicoding)
        
        NSData *data = [_self dataUsingEncoding:NSUnicodeStringEncoding];
        char *unicodeChar = (char *)[data bytes];
        //跳过unicode前面的FF-FE两个字节。
        unicodeChar +=2;
        convertToBigEndian(unicodeChar,data.length-2);
        NSMutableString *tempUnicodeStr = [NSMutableString stringWithString: httpUrlEncode(unicodeChar , data.length-2)];
        
        //计算有多少个Unicode（\uxxxx这种格式是Unicode写法,表示一个字符,其中xxxx表示一个16进制数字）
        NSUInteger lenge = tempUnicodeStr.length/4;
        //存储所有Unicode
        NSMutableArray *arr = [NSMutableArray array];
        //拆分
        for (int i = 0; i < lenge; i++) {
            NSRange rang;
            rang.length = 4;
            rang.location = i*4;
            [arr addObject:[tempUnicodeStr substringWithRange:rang]];
        }
        //在拆分好的Unicode前面插入"\u"字符
        __block NSString *unicodeStr = @"";
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *tempStr = @"";
            NSString *str = obj;
            tempStr = [@"\\u" stringByAppendingString:str];
            unicodeStr = [unicodeStr stringByAppendingString:tempStr];
        }];
        return unicodeStr;
    };
}

- (NSString *(^)(void))strFromUnicoding
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strFromUnicoding)
        
        NSMutableString *convertedString = [_self mutableCopy];
        [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
        CFStringRef transform = CFSTR("Any-Hex/Java");
        CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
        return convertedString;
    };
}

- (NSInteger (^)(NSString *, NSUInteger))strIndexOfStrStartAt
{
    return ^NSInteger(NSString* str, NSUInteger startIndex){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strIndexOfStrStartAt,str,startIndex)
        if([str isKindOfClass:[NSString class]]){
            return [_self rangeOfString:str options:NSCaseInsensitiveSearch range:NSMakeRange(startIndex, _self.length- startIndex)].location;
        }else{
            return NSNotFound;
        }
    };
}

- (NSRange (^)(NSString *))strRangeOfStr
{
    return ^(NSString* str){
        LinkHandle_VAL_IFNOT(NSString){
            return NSMakeRange(NSNotFound, 0);
        }
        LinkGroupHandle_VAL(strRangeOfStr,str)
        
        if([str isKindOfClass:[NSString class]]){
            return [_self rangeOfString:str];
        }else{
            return NSMakeRange(NSNotFound, 0);
        }
    };
}

- (NSRange (^)(void))strRange
{
    return ^(){
        NSRange range = NSMakeRange(NSNotFound, 0);
        LinkHandle_VAL_IFNOT(NSString){
            return range;
        }
        LinkGroupHandle_VAL(strRange)
        range.location = 0;
        range.length = _self.length;
        return range;
    };
}

- (NSString *(^)(NSString *, ...))strAppendFormat
{
    return ^id(NSString *formatStr, ...){
        LinkHandle_REF(NSString)
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            va_list args;
            va_start(args, formatStr);
            for (int i=0; i<group.linkObjects.count; i++) {
                id re = group.linkObjects[i].strAppend([[NSString alloc] initWithFormat:formatStr arguments:args]);
                [returnObjs addObject:re];
            }
            va_end(args);
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        if([formatStr isKindOfClass:[NSString class]]){
            va_list args;
            va_start(args, formatStr);
            NSString *re= [_self stringByAppendingString:[[NSString alloc] initWithFormat:formatStr arguments:args]];
            va_end(args);
            return re;
        }
        return _self;
    };
}

- (NSString *(^)(NSString *))strAppendLine
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strAppendLine,str)
        return [_self stringByAppendingFormat:@"%@%@", @"\n", str];
    };
}

- (BOOL (^)(void))strIsEmoji
{
    return ^(){
        return self.strIsEmojiAs().boolValue;
    };
}

- (NSNumber* (^)(void))strIsEmojiAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strIsEmojiAs)
        NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSRange range = [expression matchesInString:_self options:0 range:NSMakeRange(0, _self.length)].firstObject.range;
        return [NSNumber numberWithBool:range.location == 0 && range.length == _self.length];
    };
}

- (CGSize (^)(UIFont *))strSizeWithFont
{
    return ^(UIFont* font){
        LinkHandle_VAL_IFNOT(NSString){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(strSizeWithFont,font)
        return _self.strSizeWithFontAndMaxWidth(font , CGFLOAT_MAX);
    };
}

- (NSValue* (^)(UIFont *))strSizeWithFontAs
{
    return ^id(UIFont* font){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSizeWithFontAs,font)
        return [NSValue valueWithCGSize:_self.strSizeWithFontAndMaxWidth(font , CGFLOAT_MAX)];
    };
}

- (CGSize (^)(UIFont *, CGFloat))strSizeWithFontAndMaxWidth
{
    return ^(UIFont* font, CGFloat maxWidth){
        LinkHandle_VAL_IFNOT(NSString){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(strSizeWithFontAndMaxWidth,font,maxWidth)
        return _self.strSizeWithFontAndMaxSize(font , CGSizeMake(maxWidth, CGFLOAT_MAX));
    };
}

- (NSValue* (^)(UIFont *, CGFloat))strSizeWithFontAndMaxWidthAs
{
    return ^id(UIFont* font, CGFloat maxWidth){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSizeWithFontAndMaxWidthAs,font,maxWidth)
        return [NSValue valueWithCGSize:_self.strSizeWithFontAndMaxSize(font , CGSizeMake(maxWidth, CGFLOAT_MAX))];
    };
}

- (CGSize (^)(UIFont *, CGSize))strSizeWithFontAndMaxSize
{
    return ^(UIFont* font, CGSize maxSize){
        LinkHandle_VAL_IFNOT(NSString){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(strSizeWithFontAndMaxSize,font,maxSize)
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = font;
        
        return [_self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    };
}

- (NSValue* (^)(UIFont *, CGSize))strSizeWithFontAndMaxSizeAs
{
    return ^id(UIFont* font, CGSize maxSize){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSizeWithFontAndMaxSizeAs,font,maxSize)
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = font;
        return [NSValue valueWithCGSize:[_self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size];
    };
}

- (CGFloat (^)(NSDictionary<NSAttributedStringKey,id> *))strHeight
{
    return ^CGFloat(NSDictionary<NSAttributedStringKey,id>* attrDict){
        
        LinkHandle_VAL_IFNOT(NSString){
            return 0.0;
        }
        LinkGroupHandle_VAL(strHeight,attrDict)
        if([[attrDict allKeys] containsObject:NSAttachmentAttributeName]){
            NSLog(@"LinkBlock：The calculation of NSAttachment does not support");
            return 0.0;
        }
        CGRect rect = [_self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesDeviceMetrics
                                       attributes:attrDict
                                          context:nil];
        return rect.size.height;
    };
}

- (CGFloat (^)(NSDictionary<NSAttributedStringKey,id> *))strLineHeight
{
    return ^CGFloat(NSDictionary<NSAttributedStringKey,id>* attrDict){
        
        LinkHandle_VAL_IFNOT(NSString){
            return 0.0;
        }
        if([[attrDict allKeys] containsObject:NSAttachmentAttributeName]){
            NSLog(@"LinkBlock：The calculation of NSAttachment does not support");
            return 0.0;
        }
        LinkGroupHandle_VAL(strLineHeight,attrDict)
        CGRect rect = [_self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:attrDict
                                          context:nil];
        return rect.size.height;
    };
}

- (NSInteger (^)(CGFloat, NSDictionary<NSAttributedStringKey,id> *))strUILinesCount
{
    return ^NSInteger(CGFloat maxWidth,NSDictionary<NSAttributedStringKey,id>* attrDict){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strUILinesCount,maxWidth,attrDict)
        
        if([[attrDict allKeys] containsObject:NSAttachmentAttributeName]){
            NSLog(@"LinkBlock：The calculation of NSAttachment does not support");
            return 0;
        }
        
        NSString* originStr= _self;
        
        NSInteger enterCount=0;
        for(int i=0;i<originStr.length;i++)
            if([originStr characterAtIndex:i] == '\n')
                enterCount++;
        
        originStr = [originStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];//去换行符
        originStr = [originStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        CGFloat lineHeight = [originStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                  attributes:attrDict
                                                     context:nil].size.height;
        //无换行符
        CGFloat allHeight = [originStr boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                 attributes:attrDict
                                                    context:nil].size.height;
        
        return allHeight/lineHeight + enterCount;
    };
}

- (NSString* (^)(NSInteger, CGFloat,NSDictionary<NSAttributedStringKey,id>*))strSubToUILine
{
    return ^id(NSInteger toLine, CGFloat maxWidth,NSDictionary<NSAttributedStringKey,id>* attrDict){
        
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubToUILine,toLine,maxWidth,attrDict)
        
        if([[attrDict allKeys] containsObject:NSAttachmentAttributeName]){
            NSLog(@"LinkBlock：The calculation of NSAttachment does not support");
            return @"";
        }
        //折半查找
        NSRange forRange = NSMakeRange(0 , _self.length);
        NSInteger start,mid,end,midLineCount;
        
        if(!forRange.length||toLine<1){
            
            return @"";
        }else if (forRange.length==1){
            
            return _self;
        }else{
            
            while (forRange.length>1) {//范围缩小至1前
                
                start=forRange.location;
                end=start+forRange.length-1;
                mid=(start+end)/2;
                midLineCount = [_self substringToIndex:mid+1].strUILinesCount(maxWidth,attrDict);
                if(midLineCount<toLine){//不包含当前，向右区间
                    
                    forRange=NSMakeRange(mid+1, end-mid);
                    continue;
                }else if (midLineCount>toLine){//不包含当前，向左区间
                    
                    forRange=NSMakeRange(start, mid-start);
                    continue;
                }else{//==
                    
                    if(midLineCount<[_self substringToIndex:mid+2].strUILinesCount(maxWidth,attrDict)){//临界
                        
                        forRange=NSMakeRange(mid, 1);
                        break;
                    }else{//不包含当前，向右区间
                        
                        forRange=NSMakeRange(mid+1, end-mid);
                        continue;
                    }
                }
            }
        }
        return [_self substringToIndex:forRange.location+1];
    };
}

- (NSRange (^)(NSUInteger, CGFloat, NSString *, NSDictionary<NSAttributedStringKey,id> *,BOOL*))strSubRangeToMaxUILineIfAppendStr
{
    return ^NSRange(NSUInteger maxLine , CGFloat maxWidth, NSString* ifAppendStr ,NSDictionary<NSAttributedStringKey,id>* attrDict,BOOL* isFullOfLines){
        LinkHandle_VAL_IFNOT(NSString){
            return NSMakeRange(NSNotFound, 0);
        }
        LinkGroupHandle_VAL(strSubRangeToMaxUILineIfAppendStr,maxLine,maxWidth,ifAppendStr,attrDict,isFullOfLines)
        
        if([[attrDict allKeys] containsObject:NSAttachmentAttributeName]){
            NSLog(@"LinkBlock：The calculation of NSAttachment does not support");
            return NSMakeRange(NSNotFound, 0);
        }
        
        //连ifAppendStr都不能完全放进去
        if(ifAppendStr.strUILinesCount(maxWidth, attrDict) > maxLine){
            *isFullOfLines = YES;
            return NSMakeRange(NSNotFound, 0);
        }
        
        if(_self.strAppend(ifAppendStr).strUILinesCount(maxWidth,attrDict) <= maxLine){//完全可以展示
            *isFullOfLines = NO;
            return NSMakeRange(0, _self.length);
        }
        
        *isFullOfLines = YES;
        
        NSString* newIfAppend = [NSString stringWithFormat:@"...%@",ifAppendStr];
        
        //折半查找
        NSRange forRange = NSMakeRange(0 , _self.length);
        NSInteger start,mid,end,midLineCount;
        
        if(!forRange.length||maxLine<1){
            
            return NSMakeRange(NSNotFound, 0);
        }else if (forRange.length==1){
            
            return NSMakeRange(0, _self.length);
        }else{
            
            while (forRange.length>1) {//范围缩小至1前
                
                start=forRange.location;
                end=start+forRange.length-1;
                mid=(start+end)/2;
                midLineCount = [_self substringToIndex:mid+1].strAppend(newIfAppend).strUILinesCount(maxWidth,attrDict);
                if(midLineCount<maxLine){//不包含当前，向右区间
                    
                    forRange=NSMakeRange(mid+1, end-mid);
                    continue;
                }else if (midLineCount>maxLine){//不包含当前，向左区间
                    
                    forRange=NSMakeRange(start, mid-start);
                    continue;
                }else{//==
                    
                    if(midLineCount<[_self substringToIndex:mid+2].strAppend(newIfAppend).strUILinesCount(maxWidth,attrDict)){//临界
                        
                        forRange=NSMakeRange(mid, 1);
                        break;
                    }else{//不包含当前，向右区间
                        
                        forRange=NSMakeRange(mid+1, end-mid);
                        continue;
                    }
                }
            }
        }
        return NSMakeRange(0, forRange.location+1);
    };
}

- (BOOL (^)(void))strIsBlank{
    return ^(){
        return self.strIsBlankAs().boolValue;
    };
}

- (NSNumber* (^)(void))strIsBlankAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strIsBlankAs)
        if ([[_self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return @YES;
        }
        if ([_self isEqualToString:@"<null>"]) {
            return @YES;
        }
        if ([_self isEqualToString:@"(null)"]) {
            return @YES;
        }
        return @NO;
    };
}



- (NSNumber* (^)(void))strLengthAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strLengthAs)
        return @(_self.length);
    };
}

- (NSUInteger (^)(void))strLengthASCII
{
    return ^NSUInteger(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strLengthASCII)
        NSUInteger asciiLength = 0;
        for (NSUInteger i = 0; i < _self.length; i++)
        {
            unichar uc = [_self characterAtIndex: i];
            asciiLength += isascii(uc) ? 1 : 2;
        }
        return asciiLength;
    };
}

- (NSUInteger (^)(void))strLengthUnicode
{
    return ^NSUInteger(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strLengthUnicode)
        NSUInteger asciiLength = 0;
        for (NSUInteger i = 0; i < _self.length; i++)
        {
            unichar uc = [_self characterAtIndex: i];
            asciiLength += isascii(uc) ? 1 : 2;
        }
        NSUInteger unicodeLength = asciiLength / 2;
        if(asciiLength % 2)
        {
            unicodeLength++;
        }
        return unicodeLength;
    };
}

- (NSUInteger (^)(void))strLengthComposed
{
    return ^NSUInteger(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strLengthComposed)
        NSUInteger re=0; NSRange range;
        for(int i=0; i<_self.length; i+=range.length){
            range = [_self rangeOfComposedCharacterSequenceAtIndex:i];
            re++;
        }
        return re;
    };
}

- (NSUInteger (^)(NSString *))strCustomComposedLength
{
    return ^NSUInteger(NSString* reg){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strCustomComposedLength,reg)
        
        NSUInteger ret = 0;
        NSMutableString* tempString = [_self mutableCopy];
        if(reg){
            NSError* error;
            NSRegularExpression* regExp = [[NSRegularExpression alloc] initWithPattern:reg options:0 error:&error];
            if(!error){
                ret += [regExp replaceMatchesInString:tempString options:0 range:NSMakeRange(0, tempString.length) withTemplate:@""];
            }
        }
        NSRange range;
        for(int i=0; i<tempString.length; i+=range.length){
            range = [tempString rangeOfComposedCharacterSequenceAtIndex:i];
            ret++;
        }
        return ret;
    };
}

- (BOOL (^)(void))strContainsEmoji
{
    return ^(){
        return self.strContainsEmojiAs().boolValue;
    };
}

- (NSNumber* (^)(void))strContainsEmojiAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strContainsEmojiAs)
        NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger c = [expression matchesInString:_self options:0 range:NSMakeRange(0, _self.length)].count;
        return [NSNumber numberWithBool:c?YES:NO];
    };
}

- (NSString* (^)(void))strClearSpaceAndWrap
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strClearSpaceAndWrap)
        NSString *noWrap = [_self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        noWrap = [noWrap stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        noWrap = [noWrap stringByReplacingOccurrencesOfString:@" " withString:@""];
        return noWrap;
    };
}

- (NSComparisonResult (^)(NSString *))strCompareNumberSensitive
{
    return ^(NSString* str ){
        LinkHandle_VAL_IFNOT(NSString){
            return NSOrderedSame;
        }
        LinkGroupHandle_VAL(strCompareNumberSensitive,str)
        return [_self compare:str options: NSNumericSearch | NSWidthInsensitiveSearch ];
    };
}

- (NSComparisonResult (^)(NSString *))strCompare
{
    return ^NSComparisonResult(NSString* str){
        LinkHandle_VAL_IFNOT(NSString){
            return NSNotFound;
        }
        LinkGroupHandle_VAL(strCompare,str)
        return [_self compare:str options: NSWidthInsensitiveSearch | NSForcedOrderingSearch];
    };
}

- (BOOL (^)(void))strIsInteger
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(NSString){
            return NO;
        }
        LinkGroupHandle_VAL(strIsInteger)
        NSScanner *scaner= [[NSScanner alloc] initWithString:_self];
        NSInteger intVal;
        return [scaner scanInteger:&intVal] && [scaner isAtEnd];
    };
}

- (BOOL (^)(void))strIsFloating
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(NSString){
            return NO;
        }
        LinkGroupHandle_VAL(strIsFloating)
        NSScanner *scaner= [[NSScanner alloc] initWithString:_self];
        double doubleVal;
        return [scaner scanDouble:&doubleVal] && [scaner isAtEnd];
    };
}

- (BOOL (^)(void))strIsNumber
{
    return ^BOOL(){
        return self.strIsNumberAs().boolValue;
    };
}
- (NSNumber *(^)(void))strIsNumberAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strIsNumberAs)
        return @( _self.strIsInteger() || _self.strIsFloating() );
    };
}

- (NSString *(^)(NSString *))strDeleteLeft
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strDeleteLeft,str)
        NSMutableString * reIsStrM= [_self mutableCopy];
        NSRange range = [str rangeOfString:str];
        if(range.location == 0){
            [reIsStrM deleteCharactersInRange:range];
        }
        return reIsStrM.copy;
    };
}

- (NSString *(^)(NSString *))strDeleteRight
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strDeleteRight,str)
        NSString* re = _self;
        NSString* lastStr = [re substringWithRange:NSMakeRange(_self.length- str.length, str.length)];
        if([str isEqualToString:lastStr]){
            re= [_self substringWithRange:NSMakeRange(0, _self.length - str.length)];
        }
        return re;
    };
}

- (NSString *(^)(NSString*))strTrimLeft
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strTrimLeft,str)
        NSMutableString * str_m = _self.strMutableCopy();
        [str_m replaceOccurrencesOfString:str
                                  withString:@""
                                     options:NSAnchoredSearch
                                       range:NSMakeRange(0, _self.length)];
        return str_m.copy;
    };
}

- (NSString *(^)(NSString*))strTrimRight
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strTrimRight,str)
        NSMutableString * str_m= [_self mutableCopy];
        [str_m replaceOccurrencesOfString:str
                                  withString:@""
                                     options:NSBackwardsSearch|NSAnchoredSearch
                                       range:NSMakeRange(0, _self.length)];
        return str_m.copy;
    };
}

- (NSString *(^)(NSString *))strTrim
{
    return ^id(NSString* str){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strTrim,str)
        NSMutableString * str_m= _self.strMutableCopy();
        [str_m replaceOccurrencesOfString:str
                                  withString:@""
                                     options:NSAnchoredSearch
                                       range:NSMakeRange(0, _self.length)];
        [str_m replaceOccurrencesOfString:str
                                  withString:@""
                                     options:NSBackwardsSearch|NSAnchoredSearch
                                       range:NSMakeRange(0, _self.length)];
        return str_m.copy;
    };
}

- (UIColor *(^)(void))strToUIColorFromHex
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToUIColorFromHex)
        NSString *newString = [[_self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        if ([newString length] < 6)
            return [UIColor whiteColor];
        if ([newString hasPrefix:@"0X"])
            newString = [newString substringFromIndex:2];
        if ([newString hasPrefix:@"#"])
            newString = [newString substringFromIndex:1];
        if ([newString length] != 6)
            return [UIColor whiteColor];
        
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [newString substringWithRange:range];
        range.location = 2;
        NSString *gString = [newString substringWithRange:range];
        range.location = 4;
        NSString *bString = [newString substringWithRange:range];
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    };
}

- (double (^)(void))strToDoubleFromHex
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0.0;
        }
        LinkGroupHandle_VAL(strToDoubleFromHex)
        NSString *newString = [[_self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        if ([newString hasPrefix:@"0X"])
            newString = [newString substringFromIndex:2];
        if ([newString hasPrefix:@"#"])
            newString = [newString substringFromIndex:1];
        double re=0.0;
        [[NSScanner scannerWithString:newString] scanHexDouble:&re];
        return re;
    };
}

- (unsigned int (^)(void))strToIntFromHex
{
    return ^unsigned int(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strToIntFromHex)
        NSString *newString = [[_self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        if ([newString hasPrefix:@"0X"])
            newString = [newString substringFromIndex:2];
        if ([newString hasPrefix:@"#"])
            newString = [newString substringFromIndex:1];
        unsigned int re = 0;
        [[NSScanner scannerWithString:newString] scanHexInt:&re];
        return re;
    };
}

- (CGRect (^)(void))strToCGRect
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return CGRectZero;
        }
        LinkGroupHandle_VAL(strToCGRect)
        return CGRectFromString(_self);
    };
}

- (CGPoint (^)(void))strToCGPoint
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return CGPointZero;
        }
        LinkGroupHandle_VAL(strToCGPoint)
        return CGPointFromString(_self);
    };
}

- (CGVector (^)(void))strToCGVector
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return CGVectorMake(0, 0);
        }
        LinkGroupHandle_VAL(strToCGVector)
        return CGVectorFromString(_self);
    };
}

- (CGSize (^)(void))strToCGSize
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(strToCGSize)
        return CGSizeFromString(_self);
    };
}

- (CGAffineTransform (^)(void))strToCGAffineTransform
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return CGAffineTransformMake(0, 0, 0, 0, 0, 0);
        }
        LinkGroupHandle_VAL(strToCGAffineTransform)
        return CGAffineTransformFromString(_self);
    };
}

- (UIEdgeInsets (^)(void))strToUIEdgeInsets
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return UIEdgeInsetsZero;
        }
        LinkGroupHandle_VAL(strToUIEdgeInsets)
        return UIEdgeInsetsFromString(_self);
    };
}

- (UIOffset (^)(void))strToUIOffset
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSString){
            return UIOffsetZero;
        }
        LinkGroupHandle_VAL(strToUIOffset)
        return UIOffsetFromString(_self);
    };
}

- (NSData *(^)(void))strToNSDataWithContentsOfFile
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSDataWithContentsOfFile)
        return [NSData dataWithContentsOfFile:_self];
    };
}

- (NSData *(^)(NSStringEncoding))strToNSDataUseEncoding
{
    return ^id(NSStringEncoding encoding){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSDataUseEncoding,encoding)
        return [_self dataUsingEncoding:encoding];
    };
}

- (NSDate *(^)(NSString *))strToNSDateWithFormat
{
    return ^id(NSString* formatStr){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSDateWithFormat,formatStr)
        NSDateFormatter* fmt = [NSDateFormatter new];
        fmt.dateFormat = formatStr;
        return [fmt dateFromString:_self];
    };
}

- (NSDate *(^)(void))strToNSDateSince1970
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSDateSince1970)
        return [NSDate dateWithTimeIntervalSince1970:[_self doubleValue]];
    };
}

- (NSDictionary *(^)(NSStringEncoding))strToNSDictionary
{
    return ^id(NSStringEncoding encoding){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSDictionary,encoding)
        NSString* newStr = [_self stringByReplacingOccurrencesOfString:@" "
                                                            withString:@""];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        
        NSData* strIsData = [newStr dataUsingEncoding:encoding];
        NSDictionary* re = [NSJSONSerialization JSONObjectWithData:strIsData
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
        return [re isKindOfClass:[NSDictionary class]] ? re : [NSDictionary new];
    };
}

- (NSArray *(^)(NSStringEncoding))strToNSArrary
{
    return ^id(NSStringEncoding encoding){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSArrary,encoding)
        NSString* newStr = [_self stringByReplacingOccurrencesOfString:@" " withString:@""];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        
        NSData* strIsData = [newStr dataUsingEncoding:encoding];
        NSArray* re = [NSJSONSerialization JSONObjectWithData:strIsData
                                                      options:NSJSONReadingMutableContainers
                                                        error:nil];
        return [re isKindOfClass:[NSArray class]] ? re : [NSArray new];
    };
}

- (NSPredicate *(^)(void))strToPredicate
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToPredicate)
        return [NSPredicate predicateWithFormat:_self];
    };
}

- (NSPredicate *(^)(id, ...))strToPredicateWidthFormatArgs
{
    return ^id(id obj1, ...){
        LinkHandle_REF(NSString)
        NSPredicate* re;
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            if(obj1){
                va_list args;
                va_start(args, obj1);
                for (int i=0; i<group.linkObjects.count; i++) {
                    id re = [NSPredicate predicateWithFormat:group.linkObjects[i].asNSString arguments:args];
                    [returnObjs addObject:re];
                }
                va_end(args);
            }else{
                for (int i=0; i<group.linkObjects.count; i++) {
                    id re = [NSPredicate predicateWithFormat:group.linkObjects[i].asNSString];
                    [returnObjs addObject:re];
                }
            }
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        if(obj1){
            
            va_list args;
            va_start(args, obj1);
            re = [NSPredicate predicateWithFormat:_self arguments:args];
            va_end(args);
        }else{
            
            re = [NSPredicate predicateWithFormat:_self];
        }
        return re;
    };
}

- (SystemSoundID (^)(void))strToSystemSoundID
{
    return ^SystemSoundID(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strToSystemSoundID)
        
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)_self.strToNSURL(),&soundID);
        return soundID;
    };
}

- (UIView *(^)(NSUInteger))strLoadNibNamedAt
{
    return ^id(NSUInteger index){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strLoadNibNamedAt , index)
        
        return
        
        [[UINib nibWithNibName:_self bundle:NSBundle.mainBundle]
         
          instantiateWithOwner:nil options:nil][index];
    };
}

- (UIView *(^)(void))strLoadNibNamedFirst
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strLoadNibNamedFirst)
        
        
        return
        
        [[[UINib nibWithNibName:_self bundle:NSBundle.mainBundle]
          
          instantiateWithOwner:nil options:nil]
         
         firstObject];
    };
}

- (UIView *(^)(void))strLoadNibNamedLast
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strLoadNibNamedLast)
        
        return
        
        [[[UINib nibWithNibName:_self bundle:NSBundle.mainBundle]
          
          instantiateWithOwner:nil options:nil]
         
         lastObject];
    };
}

-(NSURL *(^)(void))strToNSURL
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSURL)
        return [NSURL URLWithString:_self];
    };
}

- (NSAttributedString *(^)(NSDictionary<NSAttributedStringKey,id> *))strToNSAttributedString
{
    return ^id(NSDictionary<NSAttributedStringKey,id>* attrbute){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSAttributedString,attrbute)
        return [[NSAttributedString alloc] initWithString:_self attributes:attrbute];
    };
}

- (NSMutableAttributedString *(^)(NSDictionary<NSAttributedStringKey,id> *))strToNSMutableAttributedString
{
    return ^id(NSDictionary<NSAttributedStringKey,id>* attrbute){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSMutableAttributedString,attrbute)
        return [[NSMutableAttributedString alloc] initWithString:_self attributes:attrbute];
    };
}

- (NSIndexPath *(^)(NSStringEncoding encoding))strToNSIndexPathFromJsonArray
{
    return ^id(NSStringEncoding encoding){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSIndexPathFromJsonArray,encoding)
        return _self.strToNSArrary(encoding).arrToNSIndexPath();
    };
}

- (UIImage *(^)(void))strToUIImage
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToUIImage)
        UIImage* reImg = [UIImage imageNamed:_self];
        if(!reImg){
            
            reImg = [UIImage imageWithContentsOfFile:_self.strPathByFileNameInBundle(nil)];
        }
        if(!reImg){
            return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"未能找到图片%@",_self]] logError];
        };
        return reImg;
    };
}

- (NSNumber *(^)(void))strToNSNumber
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToNSNumber)
        NSScanner* scanner = [[NSScanner alloc] initWithString:_self];
        if([scanner scanInteger:nil] && scanner.isAtEnd){
            NSInteger n;
            [scanner scanInteger:&n];
            return [NSNumber numberWithInteger:n];
        }
        scanner.scanLocation = 0;
        if([scanner scanDouble:nil] && scanner.isAtEnd){
            double n;
            [scanner scanDouble:&n];
            return [NSNumber numberWithDouble:n];
        }
        scanner.scanLocation = 0;
        if([scanner scanHexInt:nil] && scanner.isAtEnd){
            unsigned int n;
            [scanner scanHexInt:&n];
            return [NSNumber numberWithUnsignedInt:n];
        }
        return @0;
    };
}

- (UIImageView *(^)(void))strToUIImageView
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToUIImageView)
        return [[UIImageView alloc] initWithImage:_self.strToUIImage().linkEnd];
    };
}

- (NSArray<NSString*> *(^)(NSString *))strSplitWithStr
{
    return ^id(NSString* splitStr){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSplitWithStr,splitStr)
        return [_self componentsSeparatedByString:splitStr];
    };
}

- (NSArray<NSString*> *(^)(NSString *))strSplitWithCharsStr
{
    return ^id(NSString* splitStrs){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSplitWithCharsStr,splitStrs)
        NSCharacterSet *charSet= [NSCharacterSet characterSetWithCharactersInString:splitStrs];
        return [_self componentsSeparatedByCharactersInSet:charSet];
    };
}

- (BOOL (^)(NSString *))strHasPrefix
{
    return ^(NSString* prefix){
        return self.strHasPrefixAs(prefix).boolValue;
    };
}

- (NSNumber* (^)(NSString *))strHasPrefixAs
{
    return ^id(NSString* prefix){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strHasPrefixAs,prefix)
        return @([_self hasPrefix:prefix]);
    };
}

- (BOOL (^)(NSString *))strHasSuffix
{
    return ^(NSString* suffix){
        return self.strHasSuffixAs(suffix).boolValue;
    };
}

- (NSNumber* (^)(NSString *))strHasSuffixAs
{
    return ^id(NSString* suffix){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strHasSuffixAs,suffix)
        return @([_self hasSuffix:suffix]);
    };
}

- (NSString *(^)(NSUInteger))strSubFrom
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubFrom,idx)
        return [_self substringFromIndex:idx];
    };
}
- (NSString *(^)(NSUInteger))strSubComposeFrom
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubComposeFrom,idx)
        NSUInteger composeCurrentIdx=0; NSRange range = NSMakeRange(NSNotFound, 0);
        for(int i=0; i<_self.length; i+=range.length){
            range = [_self rangeOfComposedCharacterSequenceAtIndex:i];
            if(composeCurrentIdx == idx) break;
            if( i+range.length < _self.length) composeCurrentIdx++;
        }
        if(idx > composeCurrentIdx) return @"";
        return [_self substringFromIndex:range.location];
    };
}

- (NSString *(^)(NSUInteger))strSubTo
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubTo,idx)
        return [_self substringToIndex:idx];
    };
}
- (NSString *(^)(NSUInteger))strSubComposeTo
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubComposeTo,idx)
        NSUInteger composeCurrentIdx=0; NSRange range = NSMakeRange(NSNotFound, 0);
        for(int i=0; i<_self.length; i+=range.length){
            range = [_self rangeOfComposedCharacterSequenceAtIndex:i];
            if(composeCurrentIdx == idx) break;
            if( i+range.length < _self.length) composeCurrentIdx++;
        }
        if(idx > composeCurrentIdx) return _self;
        return [_self substringToIndex:range.location];
    };
}

- (NSString *(^)(NSUInteger, NSUInteger))strSubFromTo
{
    return ^id(NSUInteger from, NSUInteger to){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubFromTo,from,to)
        if( from> to || to>_self.length) return @"";
        return [_self substringWithRange:NSMakeRange(from, to- from+ 1)];
    };
}
- (NSString *(^)(NSRange ))strSubWithRange
{
    return ^id(NSRange range){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubWithRange,range)
        return [_self substringWithRange:range];
    };
}
- (NSString *(^)(NSUInteger, NSUInteger))strSubComposeFromTo
{
    return ^id(NSUInteger from, NSUInteger to){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubComposeFromTo,from,to)
        if(from<to){
            return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"截取字符串错误:from=%@<to=%@",@(from),@(to)]] logError];
        }
        NSUInteger composeCurrentIdx=0;
        NSRange range = NSMakeRange(NSNotFound,0);
        NSRange rangeFrom = range;
        NSRange rangeTo = range;
        for(int i=0; i<_self.length; i+=range.length , composeCurrentIdx++){
            
            range = [_self rangeOfComposedCharacterSequenceAtIndex:i];
            
            if(rangeFrom.length==0 && composeCurrentIdx == from){
                rangeFrom = range;
            }
            rangeTo = range;
            if(composeCurrentIdx == to) break;
        }
        if(!rangeFrom.length) return @"";
        return [_self substringWithRange:NSMakeRange(rangeFrom.location, rangeTo.location-rangeFrom.location)];
    };
}

- (NSObject *(^)(void))strToObjectFromName
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strToObjectFromName)
        Class class= NSClassFromString(_self);
        if(class){
            return [[class alloc] init];
        }else{
            return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"未能找到类型%@",_self]] logError];
        }
    };
}

- (BOOL (^)(NSString *))strRegexIsMatch
{
    return ^(NSString* regex){
        LinkHandle_VAL_IFNOT(NSString){
            return NO;
        }
        LinkGroupHandle_VAL(strRegexIsMatch,regex)
        return (BOOL)[_self rangeOfString:regex options:NSRegularExpressionSearch].length;
    };
}

- (NSNumber* (^)(NSString *))strRegexIsMatchAs
{
    return ^id(NSString* regex){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strRegexIsMatchAs,regex)
        return @((BOOL)[_self rangeOfString:regex options:NSRegularExpressionSearch].length);
    };
}

- (NSMutableArray<NSString*>*(^)(NSString *))strRegexMatchs
{
    return ^id(NSString* regex){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strRegexMatchs,regex)
        NSError* error;
        NSRegularExpression* reg = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
        NSMutableArray* re = [NSMutableArray new];
        if(!error){
            [reg enumerateMatchesInString:regex options:0 range:NSMakeRange(0, _self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                [re addObject:[_self substringWithRange:result.range]];
            }];
        }else{
            NSLog(@"Not RegEx:%@",regex);
        }
        return re;
    };
}

- (NSString *(^)(NSString *, NSString*))strRegexReplace
{
    return ^id(NSString* regexStr, NSString* replaceTemplate){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strRegexReplace,regexStr,replaceTemplate)
        NSError* error = nil;
        NSRegularExpression* regex = [[NSRegularExpression alloc]
                                      initWithPattern:regexStr
                                      options:0
                                      error:&error];
        if(error)
            return _self;
        return [regex stringByReplacingMatchesInString:[_self mutableCopy]
                                               options:0
                                                 range:NSMakeRange(0, _self.length)
                                          withTemplate:replaceTemplate];
    };
}

- (double (^)(void))strFindNumber
{
    return ^(){
        double re = 0.0;
        LinkHandle_VAL_IFNOT(NSString){
            return re;
        }
        LinkGroupHandle_VAL(strFindNumber)
        NSScanner* scaner= [[NSScanner alloc] initWithString:_self];
        [scaner scanDouble:&re];
        return re;
    };
}


- (NSString *(^)(void))strReversed
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strReversed)
        NSUInteger start = 0;
        NSUInteger end = _self.length - 1;
        NSString *tempStr;
        NSString *re = _self;
        while (start < end) {
            tempStr = [re substringWithRange:NSMakeRange(start, 1)];
            re = [re stringByReplacingCharactersInRange:NSMakeRange(start, 1) withString:[_self substringWithRange:NSMakeRange(end, 1)]];
            re = [re stringByReplacingCharactersInRange:NSMakeRange(end, 1) withString:tempStr];
            start++;
            end--;
        }
        return re;
    };
}

- (NSUInteger (^)(void))strLinesCount
{
    return ^NSUInteger(){
        LinkHandle_VAL_IFNOT(NSString){
            return 0;
        }
        LinkGroupHandle_VAL(strLinesCount)
        return [[_self componentsSeparatedByString:@"\n"] count];
    };
}

- (NSString *(^)(NSUInteger))strSubToLine
{
    return ^id(NSUInteger toLine){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSubToLine,toLine)
        NSMutableString* re = [NSMutableString new];
        NSArray<NSString*>* linesArr = [_self componentsSeparatedByString:@"\n"];
        [linesArr enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            if(idx < toLine){
                [re appendString:str];
                [re appendString:@"\n"];
            }
        }];
        return [re copy];
    };
}

- (NSString *(^)(NSStringEncoding))strURLEncode
{
    return ^id(NSStringEncoding encode){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLEncode,encode)
        return [_self stringByAddingPercentEscapesUsingEncoding:encode];
    };
}

- (NSString *(^)(NSStringEncoding))strURLDecode
{
    return ^id(NSStringEncoding encode){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLDecode,encode)
        return [_self stringByReplacingPercentEscapesUsingEncoding:encode];
    };
}

- (NSString *(^)(void))strURLEncodeUTF8
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLEncodeUTF8)
        return _self.strURLEncode(NSUTF8StringEncoding);
    };
}

- (NSString *(^)(void))strURLDecodeUTF8
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLDecodeUTF8)
        return _self.strURLDecode(NSUTF8StringEncoding);
    };
}

- (NSString *(^)(void))strByAddingPercentEncodingWithURLQueryAllowedCharacterSet
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strByAddingPercentEncodingWithURLQueryAllowedCharacterSet)
        return [_self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    };
}

- (NSString *(^)(void))strURLBeforeKeyValues
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLBeforeKeyValues)
        return [[_self componentsSeparatedByString:@"?"] firstObject];
    };
}

- (NSDictionary *(^)(void))strURLKeyValues
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLKeyValues)
        NSArray<NSString*>* splitedArr = [_self componentsSeparatedByString:@"?"];
        if(splitedArr.count!=2) return @{};
        NSArray<NSString*>* kvStrArr = [splitedArr[1] componentsSeparatedByString:@"&"];
        NSMutableDictionary* kvDict = [NSMutableDictionary new];
        [kvStrArr enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSArray<NSString*>* kvArr = [kvStr componentsSeparatedByString:@"="];
            if(kvArr.count==2)
                kvDict[kvArr[0]] = kvArr[1];
        }];
        return [kvDict copy];
    };
}

- (NSString *(^)(NSString *))strURLValueForKey
{
    return ^id(NSString* key){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLValueForKey,key)
        NSDictionary* kvs = _self.strURLKeyValues();
        if(!kvs)
            return _self;
        return [kvs objectForKey:key];
    };
}

- (NSString *(^)(NSString *, NSString *))strURLSetValueForKey
{
    return ^id(NSString* value , NSString* key){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLSetValueForKey,value,key)
        NSArray<NSString*>* splitedArr = [_self componentsSeparatedByString:@"?"];
        if(splitedArr.count==1 && ![_self isEqualToString:@""]){
            return [NSString stringWithFormat:@"%@?%@=%@",splitedArr[0],key,value];
        }else if(splitedArr.count!=2){//0,3..
            return _self;
        }
        
        NSArray<NSString*>* kvStrArr = [splitedArr[1] componentsSeparatedByString:@"&"];//abc=abc
        
        NSMutableArray<NSString*>* kvStrArrM = [kvStrArr mutableCopy];
        __block BOOL hasKey = NO;
        [kvStrArr enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSArray<NSString*>* kvArr = [kvStr componentsSeparatedByString:@"="];
            if(kvArr.count==2){
                if([kvArr[0] isEqualToString:key]){
                    
                    hasKey = YES;
                    kvStrArrM[idx] = [[kvArr[0] stringByAppendingString:@"="] stringByAppendingString:value];
                }
            }
        }];
        if(!hasKey){
            [kvStrArrM addObject:[[key stringByAppendingString:@"="] stringByAppendingString:value]];
        }
        //合
        NSMutableString* reURL = [NSMutableString new];
        [reURL appendString:splitedArr[0]];
        [reURL appendString:@"?"];//http//:www.abc.com/abc?
        [kvStrArrM enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [reURL appendString:kvStr];
            if(idx!=kvStrArrM.count-1)
                [reURL appendString:@"&"];//http//:www.abc.com/abc?abc=abc&...
        }];
        
        return [reURL copy];
    };
}

- (NSString *(^)(NSDictionary<NSString*,NSString*> *))strURLSetKeyValueWithDict
{
    return ^id(NSDictionary<NSString*,NSString*>* keyValues){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLSetKeyValueWithDict,keyValues)
        NSArray<NSString*>* splitedArr = [_self componentsSeparatedByString:@"?"];
        if(splitedArr.count==1 && ![_self isEqualToString:@""]){
            
            NSMutableString* re = [NSMutableString stringWithFormat:@"%@?",splitedArr[0]];
            __block NSInteger idx = 0;
            [keyValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
                
                [re appendString:key];
                [re appendString:@"="];
                [re appendString:value];
                if(idx!=keyValues.count-1)
                    [re appendString:@"&"];
                idx++;
            }];
            return [re copy];
        }else if(splitedArr.count!=2){//0,3..
            return _self;
        }
        
        NSArray<NSString*>* kvStrArr = [splitedArr[1] componentsSeparatedByString:@"&"];//abc=abc,...
        NSMutableArray<NSString*>* kvStrArrM = [kvStrArr mutableCopy];
        
        [keyValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
            
            __block BOOL hasKey = NO;
            [kvStrArr enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSArray<NSString*>* kvArr = [kvStr componentsSeparatedByString:@"="];
                if(kvArr.count==2){
                    if([kvArr[0] isEqualToString:key]){
                        
                        hasKey = YES;
                        kvStrArrM[idx] = [[kvArr[0] stringByAppendingString:@"="] stringByAppendingString:value];
                    }
                }
            }];
            if(!hasKey){
                [kvStrArrM addObject:[[key stringByAppendingString:@"="] stringByAppendingString:value]];
            }
        }];
        
        //合
        NSMutableString* reURL = [NSMutableString new];
        [reURL appendString:splitedArr[0]];
        [reURL appendString:@"?"];//http//:www.abc.com/abc?
        [kvStrArrM enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [reURL appendString:kvStr];
            if(idx!=kvStrArrM.count-1)
                [reURL appendString:@"&"];//http//:www.abc.com/abc?abc=abc&...
        }];
        
        return [reURL copy];
    };
}

- (NSArray *(^)(void))strURLAllKeys
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLAllKeys)
        NSDictionary* kvs = _self.strURLKeyValues();
        if(!kvs) return NSArrayNew;
        return [kvs allKeys];
    };
}

- (NSArray *(^)(void))strURLAllValues
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLAllValues)
        NSDictionary* kvs = _self.strURLKeyValues();
        if(!kvs) return NSArrayNew;
        return [kvs allValues];
    };
}

- (NSString *(^)(NSString *))strURLRemoveValueForKey
{
    return ^id(NSString* key){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLRemoveValueForKey,key)
        NSArray<NSString*>* splitedArr = [_self componentsSeparatedByString:@"?"];
        if(splitedArr.count!=2) return _self;
        
        NSArray<NSString*>* kvStrArr = [splitedArr[1] componentsSeparatedByString:@"&"];//abc=abc
        
        NSMutableArray<NSString*>* kvStrArrM = [kvStrArr mutableCopy];
        
        [kvStrArr enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSArray<NSString*>* kvArr = [kvStr componentsSeparatedByString:@"="];
            if(kvArr.count==2){
                if([kvArr[0] isEqualToString:key]){
                    [kvStrArrM removeObjectAtIndex:idx];
                }
            }
        }];
        //合
        NSMutableString* reURL = [NSMutableString new];
        [reURL appendString:splitedArr[0]];
        [reURL appendString:@"?"];//http//:www.abc.com/abc?
        [kvStrArrM enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [reURL appendString:kvStr];
            if(idx!=kvStrArrM.count-1)
                [reURL appendString:@"&"];//http//:www.abc.com/abc?abc=abc&...
        }];
        
        return [reURL copy];
    };
}

- (NSString *(^)(NSString *, NSString *))strURLReplaceKeyWithKey
{
    return ^id(NSString* replaceKey , NSString* withKey){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLReplaceKeyWithKey,replaceKey,withKey)
        NSArray<NSString*>* splitedArr = [_self componentsSeparatedByString:@"?"];
        if(splitedArr.count!=2) return _self;
        
        NSArray<NSString*>* kvStrArr = [splitedArr[1] componentsSeparatedByString:@"&"];//abc=abc
        
        NSMutableArray<NSString*>* kvStrArrM = [kvStrArr mutableCopy];
        
        [kvStrArr enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSArray<NSString*>* kvArr = [kvStr componentsSeparatedByString:@"="];
            if(kvArr.count==2){
                if([kvArr[0] isEqualToString:replaceKey]){
                    kvStrArrM[idx] = [[withKey stringByAppendingString:@"="] stringByAppendingString:kvArr[1]];
                }
            }
        }];
        //合
        NSMutableString* reURL = [NSMutableString new];
        [reURL appendString:splitedArr[0]];
        [reURL appendString:@"?"];//http//:www.abc.com/abc?
        [kvStrArrM enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [reURL appendString:kvStr];
            if(idx!=kvStrArrM.count-1)
                [reURL appendString:@"&"];//http//:www.abc.com/abc?abc=abc&...
        }];
        
        return [reURL copy];
    };
}

- (NSString *(^)(NSDictionary<NSString *,NSString *> *))strURLReplaceKeyWithDict
{
    return ^id(NSDictionary<NSString*,NSString*>* replaceKey_withKey){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strURLReplaceKeyWithDict,replaceKey_withKey)
        NSArray<NSString*>* splitedArr = [_self componentsSeparatedByString:@"?"];
        if(splitedArr.count!=2) return _self;
        
        NSArray<NSString*>* kvStrArr = [splitedArr[1] componentsSeparatedByString:@"&"];//abc=abc
        
        NSMutableArray<NSString*>* kvStrArrM = [kvStrArr mutableCopy];
        [replaceKey_withKey enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull replaceKey, NSString * _Nonnull withKey, BOOL * _Nonnull stop) {
            
            [kvStrArr enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSArray<NSString*>* kvArr = [kvStr componentsSeparatedByString:@"="];
                if(kvArr.count==2){
                    if([kvArr[0] isEqualToString:replaceKey]){
                        kvStrArrM[idx] = [[withKey stringByAppendingString:@"="] stringByAppendingString:kvArr[1]];
                    }
                }
            }];
        }];
        
        //合
        NSMutableString* reURL = [NSMutableString new];
        [reURL appendString:splitedArr[0]];
        [reURL appendString:@"?"];//http//:www.abc.com/abc?
        [kvStrArrM enumerateObjectsUsingBlock:^(NSString * _Nonnull kvStr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [reURL appendString:kvStr];
            if(idx!=kvStrArrM.count-1)
                [reURL appendString:@"&"];//http//:www.abc.com/abc?abc=abc&...
        }];
        
        return [reURL copy];
    };
}

- (NSString *(^)(NSString *))strPathByFileNameInBundle
{
    return ^id(NSString* type){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPathByFileNameInBundle,type)
        return [[NSBundle mainBundle] pathForResource:_self ofType:type];
    };
}

- (NSString *(^)(NSString *))strPathAppendingComponent
{
    return ^id(NSString* component){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPathAppendingComponent,component)
        return [_self stringByAppendingPathComponent:component];
    };
}

- (BOOL (^)(void))strPathFileExists
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(NSString){
            return NO;
        }
        LinkGroupHandle_VAL(strPathFileExists)
        return [[NSFileManager defaultManager] fileExistsAtPath:_self];
    };
}

- (NSNumber* (^)(void))strPathFileExistsAs
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPathFileExistsAs)
        return @([[NSFileManager defaultManager] fileExistsAtPath:_self]);
    };
}

- (NSString *(^)(void))strPathSoundPlay
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPathSoundPlay)
        
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)_self.strToNSURL(),&soundID);
        AudioServicesAddSystemSoundCompletion(soundID,
                                              NULL,
                                              NULL,
                                              _lb_SystemSoundFinishedPlayingCallback,
                                              NULL
                                              );
        AudioServicesPlaySystemSound(soundID);
        
        return _self;
    };
}
//播放后的回调
void _lb_SystemSoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    AudioServicesDisposeSystemSoundID(sound_id);
}

- (NSString *(^)(id<NSCoding>))strPathArchiveObject
{
    return ^id(id<NSCoding>obj){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPathArchiveObject , obj)
        [NSKeyedArchiver archiveRootObject:obj toFile:_self];
        return _self;
    };
}

- (NSObject *(^)(void))strPathUnarchiveObjectAsWhatReturn
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPathUnarchiveObjectAsWhatReturn)
        return linkObj([NSKeyedUnarchiver unarchiveObjectWithFile:_self]);
    };
}

- (NSString *(^)(void))strCopyToGeneralPasteboard
{
    return ^id(){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strCopyToGeneralPasteboard)
        [UIPasteboard generalPasteboard].string = _self;
        return _self;
    };
}
- (NSString *(^)(NSString*))strAlertInCurrentViewController
{
    return ^id(NSString* cancelButton){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strAlertInCurrentViewController,cancelButton)
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:_self message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:cancelButton?:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        return _self.vcpresentedFromCurrentController(YES, nil);
    };
}

- (UIView *(^)(UIView *))strSetToControlTextAsWhatSet
{
    return ^id(UIView* view){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strSetToControlTextAsWhatSet, view)
        
        if([view isKindOfClass:UIButton.class]){
            
            [(id)view setTitle:_self forState:UIControlStateNormal];
        }else if ([view respondsToSelector:@selector(setText:)]){
            
            [(id)view  setText:_self];
        }
        
        return linkObj(view);
    };
}

@end

@implementation NSString (NSStringLinkBlock)

- (void)strEnumerateScanIntegerUsingBlock:(void (^)(NSInteger num, NSUInteger idx, BOOL *stop))block
{
    if(block){

        NSError* error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[+\\-]?[0-9]+" options:NSRegularExpressionCaseInsensitive error:&error];
        if(error)
            return;
        NSArray* reArr = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        [reArr enumerateObjectsUsingBlock:^(NSTextCheckingResult*  _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* numStr = [self substringWithRange: result.range];
            block(numStr.integerValue , idx, stop);
        }];
    }
}

- (void)strEnumerateScanFloatingUsingBlock:(void(^)(double num, NSUInteger idx, BOOL *stop))block
{
    if(block){

        NSError* error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[+\\-]?(?:[0-9]*\\.[0-9]+|[0-9]+\\.)" options:NSRegularExpressionCaseInsensitive error:&error];
        if(error)
            return;
        NSArray* reArr = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        [reArr enumerateObjectsUsingBlock:^(NSTextCheckingResult*  _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* numStr = [self substringWithRange: result.range];
            block(numStr.doubleValue , idx, stop);
        }];
    }
}

- (void)strEnumerateScanNumberUsingBlock:(void(^)(double num, NSUInteger idx, BOOL *stop))block
{
    if(block){

        NSError* error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[+\\-]?\\d+(\\.\\d+)?" options:NSRegularExpressionCaseInsensitive error:&error];
        if(error)
            return;
        NSArray* reArr = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        [reArr enumerateObjectsUsingBlock:^(NSTextCheckingResult*  _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* numStr = [self substringWithRange: result.range];
            block(numStr.doubleValue , idx, stop);
        }];
    }
}

- (void)strEnumerateComposedUsingBlock:(void (^)(NSString *, NSRange, BOOL *))block
{
    if(block){

        [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            block(substring,enclosingRange,stop);
        }];
    }
}

- (NSMutableString*)strEnumerateComposedModifiedUsingBlock:(void (^)(NSString *__autoreleasing *, NSRange, BOOL *))block
{
    if(block){
        NSMutableString* newStr = [NSMutableString new];
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            block(&substring,enclosingRange,stop);
            [newStr appendString:substring];
        }];
        return newStr;
    }
    return [self mutableCopy];
}

- (void)strEnumerateCustomComposed:(NSString *)regex usingBlock:(void (^)(NSString *__autoreleasing, NSRange, BOOL, BOOL *))block
{
    if(!block) return;
    
    NSError* error = nil;
    NSRegularExpression* regExp = [[NSRegularExpression alloc] initWithPattern:regex options:0 error:&error];
    if(!error){
        
        NSRange range; BOOL isCustom = NO; BOOL stop = NO;
        NSMutableArray<NSTextCheckingResult*>* matchs = [[regExp matchesInString:self options:0 range:NSMakeRange(0, self.length)] mutableCopy];//获得匹配集
        for(int i=0; (i<self.length && !stop); i+=range.length){
            
            if(matchs.count && [matchs firstObject].range.location == i){
                //当前起始点是一个规则起点
                range = [matchs firstObject].range;
                [matchs removeObjectAtIndex:0];
                isCustom = YES;
            }else{
                //composed
                range = [self rangeOfComposedCharacterSequenceAtIndex:i];
                isCustom = NO;
            }
            block([self substringWithRange:range] , range , isCustom , &stop);
        }
    }
}

- (NSString *)strEnumerateURLUsingBlock:(void (^)(NSString *__autoreleasing *urlBeforeKeyValue, NSString *__autoreleasing * key , NSString *__autoreleasing * value , BOOL * stop))block
{
    BOOL isStop = NO;
    NSArray<NSString*>* base_KVArr = [self componentsSeparatedByString:@"?"];
    NSString* baseURL = [base_KVArr firstObject];
    NSMutableArray<NSArray*>* kvArrM = [NSMutableArray new];//存储
    if(base_KVArr.count==2){
        
        NSArray<NSString*>* kvStrArr = [base_KVArr[1] componentsSeparatedByString:@"&"];
        for (int i=0; i<kvStrArr.count; i++) {
            
            NSArray* kvArr = [kvStrArr[i] componentsSeparatedByString:@"="];
            if(kvArr.count == 2){
                
                NSString* k = kvArr[0];
                NSString* v = kvArr[1];
                if(!isStop)
                    block(&baseURL , &k , &v , &isStop);
                if(baseURL && k && v)
                    [kvArrM addObject:@[k,v]];
            }
        }
        
        NSMutableString* reStr = [NSMutableString new];
        [reStr appendString:baseURL];
        [reStr appendString:@"?"];
        [kvArrM enumerateObjectsUsingBlock:^(NSArray * _Nonnull kvArr, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(![kvArr[0] isEqualToString:@""] || ![kvArr[1] isEqualToString:@""]){
                
                [reStr appendString:[[kvArr[0] stringByAppendingString:@"="] stringByAppendingString:kvArr[1]]];
                if(idx!=kvArrM.count-1)
                    [reStr appendString:@"&"];
            }
        }];
        return [reStr copy];
    }else if (base_KVArr.count==1){
        
        NSString* k; NSString* v;
        block(&baseURL , &k , &v , &isStop);
        return baseURL;
    }
    return self;
}
@end
