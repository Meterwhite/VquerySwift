//
//  NSMutableArray+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSMutable2DArrayLinkBlock)

- (_Nullable id)thisValueFor2DArray
{
    return self==NSNull.null ? nil : self;
}

- (NSNumber *(^)(void))m2DArraryCountAs
{
    return ^id(){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryCountAs)
        
        return @(_self.count*[_self.firstObject count]);
    };
}

- (NSNumber *(^)(void))m2DArraryRowCountAs
{
    return ^id(){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryRowCountAs)
        
        return @(_self.count);
    };
}

- (NSNumber *(^)(void))m2DArraryColCountAs
{
    return ^id(){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryColCountAs)
        
        return @([_self.firstObject count]);
    };
}

- (NSObject *(^)(NSUInteger, NSUInteger))m2DArraryObjectAt
{
    return ^id(NSUInteger x,NSUInteger y){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryObjectAt,x,y)
        
        if(!_self.firstObject || !_self.count)
            return NSNull.null;
        if(x > [_self.firstObject count] || y > _self.count-1)
            return NSNull.null;
        
        return _self[x][y];
    };
}

- (NSMutableArray * (^)(id, NSUInteger, NSUInteger))m2DArrarySetObjectAt
{
    return ^id(id obj ,NSUInteger x,NSUInteger y){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArrarySetObjectAt,obj,x,y)
        
        if(!obj) return _self;
        
        if(!_self.firstObject || !_self.count)
            return _self;
        if(x > [_self.firstObject count] || y > _self.count-1)
            return _self;
       
        _self[x][y] = obj;
        return _self;
    };
}

- (NSMutableArray * (^)(NSUInteger, NSUInteger))m2DArraryCleanObjectAt
{
    return ^id(NSUInteger x,NSUInteger y){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryCleanObjectAt,x,y)
        
        if(!_self.firstObject || !_self.count)
            return _self;
        if(x > [_self.firstObject count] || y > _self.count-1)
            return _self;
        
        _self[x][y] = NSNull.null;
        return _self;
    };
}

- (NSMutableArray *(^)(void))m2DArraryCleanAllObjects
{
    return ^id(){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryCleanAllObjects)
        
        if(!_self.firstObject || !_self.count)
            return _self;
        
        id non = NSNull.null;
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger y, BOOL* stop) {
            [rowArray enumerateObjectsUsingBlock:^(id item, NSUInteger x, BOOL * _Nonnull stop) {
                if(item != non){
                    rowArray[x] = non;
                }
            }];
        }];
        return _self;
    };
}
- (NSMutableArray *(^)(id))m2DArraryCleanObject
{
    return ^id(id obj){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryCleanObject,obj)
        
        if(!_self.firstObject || !_self.count)
            return _self;
        
        id non = NSNull.null;
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger x, BOOL* stop) {
            [rowArray enumerateObjectsUsingBlock:^(id item, NSUInteger y, BOOL * _Nonnull stop) {
                rowArray[y] = non;
            }];
        }];
        return _self;
    };
}

- (NSValue *(^)(id))m2DArraryIndexOfObject
{
    return ^id(id obj){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryIndexOfObject,obj)
        
        if(!obj)
            return NSNull.null;
        
        if(!_self.firstObject || !_self.count)
            return NSNull.null;
        
        __block NSValue* ret;
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger x, BOOL* stop) {
            NSUInteger y = [rowArray indexOfObject:obj];
            if(y != NSNotFound){
                ret = [NSValue valueWithCGPoint:CGPointMake(x , y)];
                *stop = YES;
            }
        }];
        
        return ret?:NSNull.null;
    };
}

- (NSArray<NSValue *> *(^)(id obj))m2DArraryIndexesOfObject
{
    return ^id(id obj){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryIndexOfObject,obj)
        
        if(!obj)
            return NSNull.null;
        
        if(!_self.firstObject || !_self.count)
            return NSNull.null;
        
        NSMutableArray* ret = NSMutableArrayNew;
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger x, BOOL* stop) {
            NSUInteger y = [rowArray indexOfObject:obj];
            if(y != NSNotFound){
                [ret addObject:[NSValue valueWithCGPoint:CGPointMake(x , y)]];
                *stop = YES;
            }
        }];
        return ret;
    };
}

- (NSArray *(^)(NSUInteger))m2DArraryObjectsForRow
{
    return ^id(NSUInteger row){
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryObjectsForRow,row)
        
        if(!_self.count || row > [_self.firstObject count] - 1)
            return NSNull.null;
        
        return _self[row];
    };
}

- (NSArray *(^)(NSUInteger))m2DArraryObjectsForCol
{
    return ^id(NSUInteger col){
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryObjectsForCol,col)
        
        if(!_self.count || col > [_self count] - 1)
            return NSNull.null;
        
        NSMutableArray* ret = NSMutableArrayNew;
        
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger x, BOOL* stop) {
            [ret addObject:rowArray[col]];
        }];
        return ret;
    };
}

- (NSObject *(^)(NSUInteger))m2DArraryCleanObjectsForRow
{
    return ^id(NSUInteger row){
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryCleanObjectsForRow,row)
        
        if(!_self.count || row > [_self.firstObject count] - 1)
            return _self;
        
        _self[row] = NSNull.null;
        return _self;
    };
}

- (NSObject *(^)(NSUInteger))m2DArraryCleanObjectsForCol
{
    return ^id(NSUInteger col){
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryCleanObjectsForCol,col)
        
        if(!_self.count || col > [_self count] - 1)
            return _self;
        
        id non = NSNull.null;
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger x, BOOL* stop) {
            rowArray[col] = non;
        }];
        return _self;
    };
}

- (NSNumber *(^)(id))m2DArraryContainsObjectAs
{
    return ^id(id obj){
        
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(m2DArraryContainsObjectAs,obj)
        
        if(!_self.firstObject || !_self.count)
            return _self;
        
        id non = NSNull.null;
        [_self enumerateObjectsUsingBlock:^(NSMutableArray* rowArray, NSUInteger x, BOOL* stop) {
            [rowArray enumerateObjectsUsingBlock:^(id item, NSUInteger y, BOOL * _Nonnull stop) {
                rowArray[y] = non;
            }];
        }];
        return _self;
    };
}
@end
