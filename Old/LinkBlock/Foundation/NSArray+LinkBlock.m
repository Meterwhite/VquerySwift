//
//  NSArray+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import <stdarg.h>


@implementation NSObject(NSArraryLinkBlock)

- (BOOL (^)(NSUInteger))arrContainsIndex
{
    return ^BOOL(NSUInteger index){
        return self.arrContainsIndexAs(index).boolValue;
    };
}

- (NSNumber* (^)(NSUInteger))arrContainsIndexAs
{
    return ^id(NSUInteger index){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrContainsIndexAs,index)
        return @(index< _self.count);
    };
}

- (NSUInteger (^)(id))arrIndexOfObj
{
    return ^NSUInteger(id obj){
        LinkHandle_VAL_IFNOT(NSArray){
            return NSNotFound;
        }
        LinkGroupHandle_VAL(arrIndexOfObj, obj)
        return [_self indexOfObject:obj];
    };
}

- (NSNumber *(^)(id))arrIndexOfObjAs
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrIndexOfObjAs, obj)
        return @([_self indexOfObject:obj]);
    };
}

- (NSMutableArray *(^)(NSMutableArray *))arrAddToArrAsWhatSet
{
    return ^id(NSMutableArray* arr){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrAddToArrAsWhatSet,arr)
        [arr addObjectsFromArray:_self];
        return linkObj(arr);
    };
}

- (NSArray *(^)(NSUInteger, NSUInteger))arrObjsFromIndexTo
{
    return ^id(NSUInteger idx1, NSUInteger idx2){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrObjsFromIndexTo,idx1,idx2)
        if(!_self.count ||idx1>idx2 || idx1> _self.count-1) return [NSArray new];
        if(idx2> _self.count-1) idx2= _self.count - 1;
        return [_self subarrayWithRange:NSMakeRange(idx1, idx2 - idx1 + 1)];
    };
}

- (NSMutableString *(^)(NSString *))arrJoin
{
    return ^id(NSString* split){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrJoin,split)
        NSMutableString* ret = [NSMutableString new];
        [_self enumerateObjectsUsingBlock:^(id  item, NSUInteger idx, BOOL * stop) {
            
            if(![item isKindOfClass:[NSString class]]){
                item = [item description];
            }
            
            [ret appendString:item];
            
            if(split && idx!=_self.count-1){
                [ret appendString:split];
            }
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(void))arrJoinArr
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrJoinArr)
        NSMutableArray* re = [NSMutableArray new];
        [_self enumerateObjectsUsingBlock:^(id  _Nonnull arrItem, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([arrItem isKindOfClass:[NSArray class]]){
                [re addObjectsFromArray:arrItem];
            }
        }];
        return re;
    };
}

- (NSMutableDictionary *(^)(void))arrJoinDict
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrJoinDict)
        NSMutableDictionary* re = [NSMutableDictionary new];
        [_self enumerateObjectsUsingBlock:^(id  _Nonnull dictItem, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([dictItem isKindOfClass:[NSDictionary class]]){
                [re addEntriesFromDictionary:dictItem];
            }
        }];
        return re;
    };
}

- (NSMutableArray *(^)(NSUInteger))arrSplitWithCount
{
    return ^id(NSUInteger count){
        if(!count) return self;
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSplitWithCount,count)
        NSMutableArray* re = [NSMutableArray new];
        if(_self.count){
            
            [_self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSUInteger groupIdx = idx / count;
                NSMutableArray* group;
                if(re.count > groupIdx ){
                    
                    group = [re objectAtIndex:groupIdx];
                }else{
                    
                    group = [NSMutableArray new];
                    [re addObject:group];
                }
                [group addObject:obj];
            }];
        }
        return re;
    };
}

- (NSIndexPath *(^)(void))arrToNSIndexPath
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrToNSIndexPath)
        if(!_self.count) return [NSNull null];
        NSUInteger* idxs = malloc(sizeof(NSUInteger)*_self.count);
        for (NSUInteger i = 0; i<_self.count; i++) {
            idxs[i] = [_self[i] unsignedIntegerValue];
        }
        return [NSIndexPath indexPathWithIndexes:idxs length:_self.count];
    };
}
- (NSMutableOrderedSet *(^)(void))arrToNSOrderedSet
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrToNSOrderedSet)
        return [NSMutableOrderedSet orderedSetWithArray:_self];
    };
}
- (BOOL (^)(id))arrContains
{
    return ^(id obj){
        return self.arrContainsAs(obj).boolValue;
    };
}

- (NSNumber* (^)(id))arrContainsAs
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrContainsAs,obj)
        return @([_self containsObject:obj]);
    };
}

- (NSMutableArray *(^)(NSUInteger))arrSubFrom
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSubFrom,idx)
        NSUInteger count = _self.count;
        if(idx >= count ) return _self;
        return [[_self subarrayWithRange:NSMakeRange(idx, count - idx)] mutableCopy];
    };
}

- (NSMutableArray *(^)(NSUInteger))arrSubTo
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSubTo,idx)
        NSUInteger count = _self.count;
        if(idx >= count ) return _self;
        return [[_self subarrayWithRange:NSMakeRange(0, idx)] mutableCopy];
    };
}

- (NSObject* (^)(void))arrAny
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_VAL(arrAny)
        if(_self.count)
            return _self[arc4random_uniform((u_int32_t)_self.count)];
        return [NSNull null];
    };
}

- (NSObject* (^)(NSUInteger))arrAt
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_VAL(arrAt,idx)
        if(idx>_self.count-1){
            return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"数组%p越界",_self]] logError];
        }
        return [_self objectAtIndex:idx];
    };
}

- (NSMutableArray *(^)(NSString * , ...))arrFilter
{
    return ^id(NSString* predicateFormat , ...){
        
        LinkHandle_REF(NSArray)
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            
            va_list args;
            va_start(args, predicateFormat);
            for (int i=0; i<group.linkObjects.count; i++) {
                
                id re = [(id)group.linkObjects[i]
                         filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:predicateFormat arguments:args]];
                [returnObjs addObject:[re mutableCopy]];
            }
            va_end(args);
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        va_list args;
        va_start(args, predicateFormat);
        NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:args];
        va_end(args);
        return [[_self filteredArrayUsingPredicate:predicate] mutableCopy];
    };
}

- (NSUInteger (^)(id))arrCountOfObj
{
    return ^NSUInteger(id obj){
        return self.arrCountOfObjAs(obj).unsignedIntegerValue;
    };
}
- (NSNumber *(^)(id))arrCountOfObjAs
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrCountOfObjAs,obj)
        return @([[NSCountedSet setWithArray:_self] countForObject:obj]);
    };
}

- (NSIndexSet *(^)(id))arrGetValuesIndexForValue
{
    return ^id(id value){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrGetValuesIndexForValue,value)
        return  [_self indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isEqual:value])
                return YES;
            return NO;
        }];
    };
}

- (NSObject *(^)(void))arrLast
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrLast)
        return [_self lastObject];
    };
}

- (NSObject *(^)(void))arrFirst
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrFirst)
        return [_self firstObject];
    };
}

- (NSMutableArray *(^)(id, id))arrReplaceItemKeyForDictionaryItemDepth
{
    return ^id(id replaceKey,id withKey){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrReplaceItemKeyForDictionaryItemDepth,replaceKey,withKey)
        NSMutableArray* ret = [NSMutableArray arrayWithArray:_self];
        [ret enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            if([dict isKindOfClass:[NSDictionary class]]){
                dict = dict.dictReplaceForKeyDepth(replaceKey, withKey);
                ret[idx] = dict;
            }
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(id, id))arrReplaceItemKeyForDictionaryItem
{
    return ^id(id replaceKey,id withKey){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrReplaceItemKeyForDictionaryItem,replaceKey,withKey)
        NSMutableArray* ret = [NSMutableArray arrayWithArray:_self];
        [ret enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            if([dict isKindOfClass:[NSDictionary class]]){
                dict = dict.dictReplaceForKey(replaceKey, withKey);
                ret[idx] = dict;
            }
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(__unsafe_unretained Class))arrObjsWithKindOfClass
{
    return ^id(__unsafe_unretained Class typeClass){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrObjsWithKindOfClass,typeClass)
        if(!typeClass)
            return _self;
        NSMutableArray* re = [NSMutableArray array];
        [_self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:typeClass]){
                [re addObject:obj];
            }
        }];
        return re;
    };
}

- (NSMutableArray *(^)(BOOL))arrSort
{
    return ^id(BOOL ascending){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSort,ascending)
        
        if([self respondsToSelector:@selector(sortUsingComparator:)]){
            
            [_self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 compare:obj2]*(ascending?1:-1);
            }];
            return _self;
        }
        
        return [_self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2]*(ascending?1:-1);
        }];
    };
}

- (NSMutableArray *(^)(NSString *, BOOL))arrSortByKey
{
    return ^id(NSString* key , BOOL ascending){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSortByKey,key,ascending)
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
        if([_self respondsToSelector:@selector(sortUsingDescriptors:)]){
        
            [_self sortUsingDescriptors:@[sort]];
            return _self;
        }
            
        return [_self sortedArrayUsingDescriptors:@[sort]];
    };
}
- (NSMutableArray *(^)(NSString *))arrSortByKeyAscending
{
    return ^id(NSString* key){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSortByKeyAscending,key)
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
        if([_self respondsToSelector:@selector(sortUsingDescriptors:)]){
            
            [_self sortUsingDescriptors:@[sort]];
            return _self;
        }
        
        return [_self sortedArrayUsingDescriptors:@[sort]];
    };
}
- (NSMutableArray *(^)(NSString *))arrSortByKeyDescending
{
    return ^id(NSString* key){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSortByKeyDescending,key)
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:NO];
        if([_self respondsToSelector:@selector(sortUsingDescriptors:)]){
            
            [_self sortUsingDescriptors:@[sort]];
            return _self;
        }
        
        return [_self sortedArrayUsingDescriptors:@[sort]];
    };
}

- (NSMutableArray *(^)(void))arrReversed
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrReversed)
        
        return [[[_self reverseObjectEnumerator] allObjects] mutableCopy];
    };
}

- (NSMutableArray *(^)(NSArray *, NSString *))arrMinusArrByKey
{
    return ^id(NSArray* arr, NSString* keyPath){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrMinusArrByKey,arr,keyPath)
        NSMutableArray* ret = [NSMutableArray new];
        __block BOOL hasItem;
        [_self enumerateObjectsUsingBlock:^(id fromItem, NSUInteger i, BOOL * stopI) {
            hasItem = NO;
            [arr enumerateObjectsUsingBlock:^(id toItem, NSUInteger j, BOOL * stopJ) {
                
                if([[fromItem valueForKeyPath:keyPath] isEqual: [toItem valueForKeyPath:keyPath]]){
                    hasItem = YES; *stopJ = YES;
                }
            }];
            if(!hasItem){
                [ret addObject:fromItem];
            }
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(NSArray *, NSString *))arrUnionArrByKey
{
    return ^id(NSArray* arr, NSString* keyPath){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrMinusArrByKey,arr,keyPath)
        NSMutableArray* ret = [NSMutableArray arrayWithArray:_self];
        __block BOOL hasItem;
        [_self enumerateObjectsUsingBlock:^(id fromItem, NSUInteger i, BOOL * stopI) {
            hasItem = NO;
            [arr enumerateObjectsUsingBlock:^(id toItem, NSUInteger j, BOOL * stopJ) {
                
                if([[fromItem valueForKeyPath:keyPath] isEqual: [toItem valueForKeyPath:keyPath]]){
                    hasItem = YES; *stopJ = YES;
                }
            }];
            if(!hasItem){
                [ret addObject:fromItem];
            }
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(NSArray *, NSString *))arrInterectArrByKey
{
    return ^id(NSArray* arr, NSString* keyPath){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrMinusArrByKey,arr,keyPath)
        NSMutableArray* ret = [NSMutableArray new];
        __block BOOL hasItem;
        [_self enumerateObjectsUsingBlock:^(id fromItem, NSUInteger i, BOOL * stopI) {
            hasItem = NO;
            [arr enumerateObjectsUsingBlock:^(id toItem, NSUInteger j, BOOL * stopJ) {
                if([[fromItem valueForKeyPath:keyPath] isEqual: [toItem valueForKeyPath:keyPath]]){
                    hasItem = YES; *stopJ = YES;
                }
            }];
            if(hasItem){
                [ret addObject:fromItem];
            }
        }];
        return ret;
    };
}

- (BOOL (^)(NSString *, id))arrContainsKeyValue
{
    return ^(NSString* key , id val){
        return self.arrContainsKeyValueAs(key,val).boolValue;
    };
}

- (NSNumber *(^)(NSString *, id))arrContainsKeyValueAs
{
    return ^id(NSString* key , id val){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrContainsKeyValueAs,key,val)
        return @((BOOL)[[_self valueForKeyPath:key] containsObject:val]);
    };
}

- (NSMutableArray *(^)(NSString *, id))arrKeyValueMatchedObjs
{
    return ^id(NSString* key , id value){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrKeyValueMatchedObjs,key,value)
        NSMutableArray* ret = [NSMutableArray new];
        [_self enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([[item valueForKeyPath:key] isEqual:value]) [ret addObject:item];
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(NSDictionary<NSString*,id>*))arrKeyValuesMatchedObjs
{
    return ^id(NSDictionary<NSString*,id>* kv){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrKeyValuesMatchedObjs,kv)
        NSMutableArray* ret = [NSMutableArray new];
        [_self enumerateObjectsUsingBlock:^(id  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            
            __block BOOL match = YES;
            [kv enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
                
                if(![[item valueForKeyPath:key] isEqual:value]){
                    match = NO; *stop = YES;
                }
            }];
            [ret addObject:item];
        }];
        return ret;
    };
}

- (NSMutableArray *(^)(id))arrAddObj
{
    return ^id(id obj){
        
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrAddObj,obj)
        
        if(![_self respondsToSelector:@selector(addObject:)])
            _self = _self.mutableCopy;
        
        if(obj){
            [_self addObject:obj];
        }
        return _self;
    };
}

- (NSMutableArray *(^)(id))arrAddObjUnique
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrAddObjUnique , obj)
        
        if(![_self respondsToSelector:@selector(addObject:)])
            _self = _self.mutableCopy;
        
        if(obj && ![_self containsObject:obj]){
            [_self addObject:obj];
        }
        return _self;
    };
}

- (NSMutableArray *(^)(id obs))arrAddObjs
{
    return ^id(id objs){
        
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrAddObjs,objs)
        
        if(![objs respondsToSelector:@selector(indexOfObject:)])
            return _self;
        
        ///NSMutableArray or NSMutableOrderedSet
        if(![_self respondsToSelector:@selector(addObjectsFromArray:)]){
            _self = _self.mutableCopy;
        }
        
        if(!objs) return _self;
        
        if([objs isKindOfClass:NSArray.class]){
            [_self addObjectsFromArray:objs];
        }else if([objs objIsArrayableAs]()){
            [_self addObjectsFromArray:[objs objsArrayRepresentation]()];
        }
        return _self;
    };
}

- (NSMutableArray *(^)(id, NSUInteger))arrInsertObjAt
{
    return ^id(id obj, NSUInteger index){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertObjAt,obj,index)
        
        if(!obj || index > _self.count) return _self;
        
        if(![_self respondsToSelector:@selector(insertObject:atIndex:)])
            _self = _self.mutableCopy;
        
        [_self insertObject:obj atIndex:index];
        
        return _self;
    };
}

- (NSMutableArray *(^)(id, NSUInteger))arrInsertObjsAt
{
    return ^id(id objs, NSUInteger index){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertObjsAt,objs,index)
        
        if(!objs || index > _self.count) return _self;
        
        if(![objs isKindOfClass:NSArray.class]) return _self;
        
        if(![_self respondsToSelector:@selector(insertObjects:atIndexes:)])
            _self = _self.mutableCopy;
        
        if([objs isKindOfClass:NSOrderedSet.class]){
            objs = [(NSOrderedSet*)objs array];
        }
        
        [(id)_self insertObjects:objs atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, [objs count])]];
        
        return _self;
    };
}

- (NSMutableArray *(^)(id, id))arrInsertObjBefore
{
    return ^id(id obj, id beforThis){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertObjBefore,obj,beforThis)
        
        if(![_self respondsToSelector:@selector(insertObject:atIndex:)]){
            LB_MCopy_VAR(_self);
        }
        
        if(obj && beforThis) {
            
            NSUInteger idx= [_self indexOfObject:beforThis];
            if(idx != NSNotFound){
                [_self insertObject:obj atIndex:idx];
            }
        }
        return _self;
    };
}

- (NSMutableArray *(^)(id, id))arrInsertObjNextTo
{
    return ^id(id obj, id nextToThis){
        
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertObjNextTo,obj,nextToThis)
        
        if(![_self respondsToSelector:@selector(insertObject:atIndex:)]){
            LB_MCopy_VAR(_self);
        }
        
        if(obj && nextToThis) {
            
            NSUInteger idx= [_self indexOfObject:nextToThis];
            if(idx != NSNotFound){
                
                [_self insertObject:obj atIndex:++idx];
            }
        }
        return _self;
    };
}

- (NSObject *(^)(id))arrGetPrevItemForObj
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrGetPrevItemForObj,obj)
        return linkObj_id(obj).objGetPrevItemFromObjs(_self);
    };
    
    
}

- (NSObject *(^)(id))arrGetNextItemForObj
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrGetNextItemForObj,obj)
        return linkObj_id(obj).objGetNextItemFromObjs(_self);
    };
}

- (NSMutableArray *(^)(id))arrRemoveObj
{
    return ^id(id obj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrRemoveObj,obj)
        
        if(![_self respondsToSelector:@selector(removeObject:)]){
            _self = _self.mutableCopy;
        }
        [_self removeObject:obj];
        return _self;
    };
}

- (NSMutableArray *(^)(NSUInteger))arrRemoveAt
{
    return ^id(NSUInteger index){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrRemoveAt,index)
        
        if(![_self respondsToSelector:@selector(removeObjectAtIndex:)]){
            _self = _self.mutableCopy;
        }
        
        if(index < _self.count){
            [_self removeObjectAtIndex:index];
        }
        return _self;
    };
}
- (NSMutableArray *(^)(NSUInteger, NSUInteger))arrRemoveObjsFromIndexTo
{
    return ^id(NSUInteger from, NSUInteger to){
        LinkHandle_REF(NSArray)
        
        LinkGroupHandle_REF(arrRemoveObjsFromIndexTo,from,to)
        if(![_self respondsToSelector:@selector(removeObjectAtIndex:)]){
            _self = _self.mutableCopy;
        }
        if( to<_self.count && from<to ){
            [_self removeObjectsInRange:NSMakeRange(from, to - from + 1)];
        }
        return _self;
    };
}

- (NSMutableArray *(^)(void))arrRemoveAll
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrRemoveAll)
        if(![_self respondsToSelector:@selector(removeAllObjects)])
            _self = _self.mutableCopy;
        [_self removeAllObjects];
        return _self;
    };
}

- (NSMutableArray *(^)(id, id))arrReplaceObjWith
{
    return ^id(id obj, id withObj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrReplaceObjWith,obj,withObj)
        
        if(!LB_RespondsToSEL(_self, setObject:atIndex:)){
            LB_MCopy_VAR(_self);
        }
        
        if(!obj || !withObj) return _self;
        
        NSUInteger idx =[_self indexOfObject:obj];
        if(idx != NSNotFound){
            [_self setObject:withObj atIndexedSubscript:idx];
        }
        return _self;
    };
}

- (NSMutableArray<NSValue *> *(^)(BOOL, BOOL))arrSortRange
{
    return ^id(BOOL ascending, BOOL isCombine){
        
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSortRange,ascending,isCombine)
        
        if(!LB_IsKindOfClass(_self, NSMutableArray)){
            LB_MCopy_VAR(_self);
        }
        
        NSMutableSet<NSValue*>* combineArr = [NSMutableSet new];
        NSInteger flagDirection = ascending?1:-1;
        [_self sortUsingComparator:^NSComparisonResult(NSValue*  _Nonnull obj1, NSValue*  _Nonnull obj2) {
            
            if([obj1 rangeValue].location < [obj2 rangeValue].location){
                
                return NSOrderedAscending*flagDirection;
            }else if ([obj1 rangeValue].location > [obj2 rangeValue].location){
                
                return NSOrderedDescending*flagDirection;
            }else{
                //location相同
                if([obj1 rangeValue].length < [obj2 rangeValue].length){
                    
                    if(isCombine)[combineArr addObject:obj1];
                    return NSOrderedAscending*flagDirection;
                }else if ([obj1 rangeValue].length > [obj2 rangeValue].length){
                    
                    if(isCombine)[combineArr addObject:obj2];
                    return NSOrderedDescending*flagDirection;
                }else{
                    
                    if(isCombine)[combineArr addObject:obj1];
                    return NSOrderedSame;
                }
            }
        }];
        if(isCombine){
            
            [combineArr enumerateObjectsUsingBlock:^(NSValue * _Nonnull combindItem, BOOL * _Nonnull stop) {
                
                [_self removeObjectAtIndex:[_self indexOfObject:combindItem]];
            }];
        }
        return _self;
    };
}

- (NSArray *(^)(id))arrConstraintsActiveByPriority
{
    return ^id(id asPriority){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrConstraintsActiveByPriority,asPriority)
        
        
        if([asPriority isKindOfClass:NSArray.class] == NO)
            
            asPriority = [NSArray arrayWithObject:asPriority];
        
        for (NSLayoutConstraint* item in _self)
        {
            item.active = [asPriority containsObject:@(item.priority)];
        }
        
        return _self;
    };
}

- (NSMutableArray *(^)(id, NSString *))arrAddOrReplaceItemCaseValueForKey
{
    return ^id(id obj , NSString* key){
        LinkHandle_REF(NSMutableArray)
        LinkGroupHandle_REF(arrAddOrReplaceItemCaseValueForKey,obj,key)
        
        if(!LB_IsKindOfClass(_self, NSMutableArray)){
            LB_MCopy_VAR(_self);
        }
        
        id uniqueValue = [obj valueForKey:key];
        NSArray* values = [_self valueForKey:key];
        NSIndexSet* idxSet = [values indexesOfObjectsPassingTest:^BOOL(id  _Nonnull val, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([val isEqual:uniqueValue])
                return YES;
            return NO;
        }];
        if(idxSet.count){
            
            [idxSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                _self[idx] = obj;
            }];
            return _self;
        }
        
        [_self addObject:obj];
        return _self;
    };
}

- (NSMutableArray *(^)(id, NSString *, NSUInteger))arrInsertOrReplaceItemCaseValueForKeyAt
{
    return ^id(id obj , NSString* key , NSUInteger idx){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertOrReplaceItemCaseValueForKeyAt,obj,key,idx)
        
        if(!LB_IsKindOfClass(_self, NSMutableArray)){
            LB_MCopy_VAR(_self);
        }
        id uniqueValue = [obj valueForKey:key];
        NSArray* values = [_self valueForKey:key];
        NSIndexSet* idxSet = [values indexesOfObjectsPassingTest:^BOOL(id  _Nonnull val, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([val isEqual:uniqueValue])
                return YES;
            return NO;
        }];
        if(idxSet.count){
            
            [idxSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                
                [_self setObject:obj atIndexedSubscript:idx];
            }];
            return _self;
        }
        
        [_self insertObject:obj atIndex:idx];
        return _self;
    };
}

- (NSMutableArray *(^)(id, NSString *))arrReplaceItemCaseValueForKey
{
    return ^id(id obj , NSString* key){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrReplaceItemCaseValueForKey,obj,key)
        
        if(!LB_IsKindOfClass(_self, NSMutableArray)){
            LB_MCopy_VAR(_self);
        }
        id uniqueValue = [obj valueForKey:key];
        NSArray* values = [_self valueForKey:key];
        NSIndexSet* idxSet = [values indexesOfObjectsPassingTest:^BOOL(id  _Nonnull val, NSUInteger idx, BOOL * _Nonnull stop) {
            
            return [val isEqual:uniqueValue];
        }];
        if(idxSet.count){
            
            [idxSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                [_self setObject:obj atIndexedSubscript:idx];
            }];
        }
        return _self;
    };
}

- (NSMutableArray *(^)(NSArray *, NSString *))arrReplaceItemsCaseValueForKey
{
    return ^id(NSArray* objs , NSString* key){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrReplaceItemsCaseValueForKey,objs,key)
        if(!LB_IsKindOfClass(_self, NSMutableArray)){
            LB_MCopy_VAR(_self);
        }
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
            _self.arrReplaceItemCaseValueForKey(obj, key);
        }];
        return _self;
    };
}
@end

@implementation NSArray(NSArraryLinkBlock)

- (NSMutableArray *)arrFindUsingBlock:(BOOL (^)(id, NSUInteger, BOOL *))block
{
    NSMutableArray* reArr = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj,idx,stop)){
            [reArr addObject:obj];
        }
    }];
    return reArr;
}

- (void)arrEnumerateWithPredicateFormat:(NSString *)predicateFormat
                             usingBlock:(void (^)(id, NSUInteger, BOOL *))block
{
    NSMutableArray* re= [NSMutableArray new];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([predicate evaluateWithObject:obj]){
            [re addObject:obj];
            if(block) block(obj, idx, stop);
        }
    }];
}

- (void)arrStringEnumerateComposedInString:(NSString *)string usingBlock:(void (^)(NSString *, NSRange,BOOL , BOOL *))block
{
    if(block){
        
        NSMutableArray<NSValue*>* rangeRules = [NSMutableArray new];
        [self enumerateObjectsUsingBlock:^(NSString*  _Nonnull ruleString, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(![ruleString isKindOfClass:[NSString class]]){*stop = YES;return;}
            NSRange range;
            for (int i =0 ; i<string.length; i+=(range.location + range.length)) {
                
                range = [string rangeOfString:ruleString options:0 range:NSMakeRange(i, string.length-i)];
                if(range.length==0) break;
                [rangeRules addObject:[NSValue valueWithRange:range]];
            }
        }];
        rangeRules.arrSortRange(YES,YES);
        
        NSRange range; BOOL isCustom = NO; BOOL stop = NO;
        for(int i=0; (i<string.length && !stop); i+=range.length){
            
            if(rangeRules.count && [rangeRules firstObject].rangeValue.location == i){
                //当前起始点是一个规则起点
                range = [rangeRules firstObject].rangeValue;
                [rangeRules removeObjectAtIndex:0];
                isCustom = YES;
            }else{
                //普通元字符
                range = [string rangeOfComposedCharacterSequenceAtIndex:i];
                isCustom = NO;
            }
            block([string substringWithRange:range], range , isCustom , &stop);
        }
    }
}
@end
