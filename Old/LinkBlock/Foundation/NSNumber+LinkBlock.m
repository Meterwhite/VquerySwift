//
//  NSNumber+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/4.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"


@implementation NSObject(NSNumberLinkBlock)

- (BOOL (^)(void))numIsIntegerType
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsIntegerType)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        
        char ocType = _self.objCType[0];
        if(ocType == 's' ||//short
           ocType == 'i' ||//int
           ocType == 'l' ||//long
           ocType == 'q' ||//long long
           ocType == 'S' ||//unsigned short
           ocType == 'I' ||//unsigned int
           ocType == 'L' ||//unsigned long
           ocType == 'Q' ){//unsigned long long
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(void))numIsFloatingType
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsFloatingType)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        
        char ocType = _self.objCType[0];
        if(ocType == 'f' ||//float
           ocType == 'd' ){//double
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(void))numIsCharType
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsCharType)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        
        char ocType = _self.objCType[0];
        if(ocType == 'c' ||//char
           ocType == 'C' ){//unsigned char
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(void))numIsBOOL
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsBOOL)
        if(_self.class == NSClassFromString(@"__NSCFBoolean") ||
           [_self isKindOfClass: NSClassFromString(@"__NSCFBoolean")]){
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(void))numIsChar
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsChar)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        
        char ocType = _self.objCType[0];
        if(ocType == 'c' ){
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(void))numIsShort
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsShort)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 's') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsInt
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsInt)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'i') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsLong
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsLong)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'l') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsLongLong
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsLongLong)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'q') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsUnsignedChar
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsUnsignedChar)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        
        char ocType = _self.objCType[0];
        if(ocType == 'C' ){
            return YES;
        }
        return NO;
    };
}

- (BOOL (^)(void))numIsUnsignedShort
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsUnsignedShort)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'S') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsUnsignedInt
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsUnsignedInt)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'I') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsUnsignedLong
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsUnsignedLong)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'L') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsUnsignedLongLong
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsUnsignedLongLong)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'Q') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsFloat
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsFloat)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'f') return YES;
        return NO;
    };
}

- (BOOL (^)(void))numIsDouble
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        };
        LinkGroupHandle_VAL(numIsDouble)
        if(_self.class != NSClassFromString(@"__NSCFNumber")) return NO;
        if(_self.objCType[0] == 'd') return YES;
        return NO;
    };
}

- (NSString *(^)(NSUInteger))numToStrFloating
{
    return ^id(NSUInteger digit){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numToStrFloating,digit)
        if(digit<=0){
            
            return [NSString stringWithFormat:@"%ld", (long)[_self integerValue]];
        }else{
            
            NSString* formatStr = [NSString stringWithFormat:@"%%.%@f",@(digit)];
            return  [NSString stringWithFormat:formatStr , [_self doubleValue]];
        }
    };
}

- (NSMutableString *(^)(NSUInteger))numToStrPercent
{
    return ^id(NSUInteger digit){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numToStrPercent,digit)
        NSMutableString* re = [NSMutableString new];
        [re appendString:@([_self doubleValue]*100.0).numToStrFloating(digit)];
        [re appendString:@"%"];
        return re;
    };
}

- (NSString *(^)(NSUInteger))numToStrByMaxDecimalWidth
{
    return ^id(NSUInteger maxDigit){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numToStrByMaxDecimalWidth,maxDigit)
        if(!_self.numIsFloatingType())  return self.description;
        if(maxDigit<1) return @(_self.integerValue).description;
        NSString* formatStr = [NSString stringWithFormat:@"%%.%@f",@(maxDigit)];
        NSString* numStr = [NSString stringWithFormat:formatStr,_self.doubleValue];
        numStr = numStr.strTrimRight(@"0");
        return numStr;
    };
}

- (BOOL (^)(void))numHasDecimalValue
{
    return ^(){
        return self.numHasDecimalValueAs().boolValue;
    };
}
- (NSNumber* (^)(void))numHasDecimalValueAs
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numHasDecimalValueAs)
        if([_self doubleValue] - [_self integerValue]) return @YES;
        return @NO;
    };
}

- (BOOL (^)(NSNumber*))numIsGreatThanNum
{
    return ^BOOL(NSNumber* num){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsGreatThanNum,num)
        return [_self compare:num]==NSOrderedDescending;
    };
}

- (NSNumber* (^)(NSNumber*))numIsGreatThanNumAs
{
    return ^id(NSNumber* num){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsGreatThanNumAs,num)
        return @([_self compare:num]==NSOrderedDescending);
    };
}

- (BOOL (^)(NSNumber*))numIsGreatEqualNum
{
    return ^BOOL(NSNumber* num){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsGreatEqualNum,num)
        return [_self compare:num]>=NSOrderedSame;
    };
}

- (NSNumber* (^)(NSNumber*))numIsGreatEqualNumAs
{
    return ^id(NSNumber* num){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsGreatEqualNumAs,num)
        return @([_self compare:num]>=NSOrderedSame);
    };
}

- (BOOL (^)(NSNumber*))numIsLessThanNum
{
    return ^BOOL(NSNumber* num){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsLessThanNum,num)
        return [_self compare:num]==NSOrderedAscending;
    };
}

- (NSNumber* (^)(NSNumber*))numIsLessThanNumAs
{
    return ^id(NSNumber* num){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsLessThanNumAs,num)
        return @([_self compare:num]==NSOrderedAscending);
    };
}

- (BOOL (^)(NSNumber*))numIsLessEqualNum
{
    return ^BOOL(NSNumber* num){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsLessEqualNum,num)
        return [_self compare:num]<=NSOrderedSame;
    };
}

- (NSNumber* (^)(NSNumber*))numIsLessEqualNumAs
{
    return ^id(NSNumber* num){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsLessEqualNumAs,num)
        return @([_self compare:num]<=NSOrderedSame);
    };
}

- (NSDate *(^)(void))numToNSDateSince1970
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numToNSDateSince1970)
        return [NSDate dateWithTimeIntervalSince1970:[_self doubleValue]];
    };
}

- (BOOL (^)(void))numIsOdd
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsOdd)
        if(_self.numIsIntegerType() && ([_self integerValue]%2 == 1)){
            
            return YES;
        }
        return NO;
    };
}
- (NSNumber* (^)(void))numIsOddAs
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsOddAs)
        if(_self.numIsIntegerType() && ([_self integerValue]%2 == 1)){
            return @YES;
        }
        return @NO;
    };
}

- (BOOL (^)(void))numIsEven
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsEven)
        if(_self.numIsIntegerType() && ([_self integerValue]%2 == 0)){
            return YES;
        }
        return NO;
    };
}
- (NSNumber* (^)(void))numIsEvenAs
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsEvenAs)
        if(_self.numIsIntegerType() && ([_self integerValue]%2 == 0)){
            return @YES;
        }
        return @NO;
    };
}

- (NSNumber* (^)(void))numIsNegativeAs
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsNegativeAs)
                            
        if([_self.stringValue characterAtIndex:0] == '-')
            return @YES;
        return @NO;
    };
}

- (BOOL (^)(void))numIsNegative
{
    return ^BOOL(){
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsNegativeAs)
        if([_self.stringValue characterAtIndex:0] == '-')
            return YES;
        return NO;
    };
}

- (NSNumber *(^)(void))numReverse
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numReverse)
        //NaN
        if([[NSDecimalNumber notANumber] isEqualToNumber:_self])
            return _self;
        //0
        if([[NSDecimalNumber zero] isEqualToNumber:_self])
            return _self;
        
        // @YES <=> @NO
        if(_self.class == NSClassFromString(@"__NSCFBoolean") ||
           [_self isKindOfClass: NSClassFromString(@"__NSCFBoolean")]){
            return [NSNumber numberWithBool:!_self.boolValue];
        }

        
        NSString* strValue = _self.stringValue;
        if([strValue characterAtIndex:0] == '-'){
            
            return [NSDecimalNumber decimalNumberWithString:[strValue substringFromIndex:1]];
        }
        
        return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"-%@",strValue]];
    };
}

- (BOOL (^)(void))numIsZero
{
    return ^BOOL(){
        
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsZero)
        
        return [[NSDecimalNumber zero] isEqualToNumber:_self];
    };
}
- (NSNumber *(^)(void))numIsZeroAs
{
    return ^NSNumber*(){
        
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numIsZeroAs)
        
        return @([[NSDecimalNumber zero] isEqualToNumber:_self]);
    };
}

- (BOOL (^)(void))numIsNaN
{
    return ^BOOL(){
        
        LinkHandle_VAL_IFNOT(NSNumber){
            return NO;
        }
        LinkGroupHandle_VAL(numIsNaN)
        
        return [[NSDecimalNumber notANumber] isEqualToNumber:_self];
    };
}


- (NSObject *(^)(id))numAsIndexToGetValueFromObj
{
    return ^id(id obj){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numAsIndexToGetValueFromObj,obj)
        
        
        if([obj respondsToSelector:@selector(objectAtIndex:)])
            goto CALL_ARRAY_GETVALUE;
        
        //string
        if([obj isKindOfClass:NSAttributedString.class]){
            obj = [obj string];
        }
        else if([obj isKindOfClass:NSString.class]){
            return @([obj characterAtIndex:[(id)_self unsignedIntegerValue]]);
        }
        
        //able to be array
        if([obj isKindOfClass:CALayer.class]){
            obj = [obj sublayers];
        }else if([obj isKindOfClass:UIView.class]){
            obj = [obj subviews];
        }
        
        if([obj respondsToSelector:@selector(objectAtIndex:)]){
            
        CALL_ARRAY_GETVALUE:
            {
                NSUInteger count = [obj count];
                NSUInteger idx = [(id)_self unsignedIntegerValue];
                if(idx<count){
                    return [obj objectAtIndex:idx];
                }
                return NSNull.null;
            }
        }
        return NSNull.null;
    };
}

- (UIFont *(^)(void))numToUIFontSystemSize
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numToUIFontSystemSize)
        return [UIFont systemFontOfSize:[_self doubleValue]];
    };
}

- (UIColor *(^)(void))numToUIColorFromHex
{
    return ^id(){
        LinkHandle_REF(NSNumber)
        LinkGroupHandle_REF(numToUIColorFromHex)
        NSInteger rgbValue = _self.integerValue;
        return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                               green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
    };
}

@end

@implementation NSNumber (NSNumberLinkBlock)

- (void)numForLoopASC:(void (^)(int))forBlock
{
    if(forBlock){
        int x = self.intValue;
        for(int i=0 ; i< x; i++ ){
            forBlock(i);
        }
    }
}

- (void)numForLoopDESC:(void (^)(int))forBlock
{
    if(forBlock){
        int x = self.intValue;
        for(int i=x-1 ; i > -1; i-- ){
            forBlock(i);
        }
    }
}


@end
