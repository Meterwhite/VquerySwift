//
//  NSPredicate+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 2018/10/9.
//  Copyright © 2018 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSPredicateLinkBlock)
- (NSCompoundPredicate *(^)(NSPredicate*))andPredicate
{
    return ^id(NSPredicate* predicate){
        
        LinkHandle_REF(NSPredicate)
        LinkGroupHandle_REF(andPredicate,predicate)
        
        return [NSCompoundPredicate andPredicateWithSubpredicates:@[_self,predicate]];
    };
}

- (NSCompoundPredicate *(^)(NSPredicate *))notPredicate
{
    return ^id(NSPredicate* predicate){
        
        LinkHandle_REF(NSPredicate)
        LinkGroupHandle_REF(notPredicate,predicate)
        
        NSCompoundPredicate* theNot = [NSCompoundPredicate notPredicateWithSubpredicate:predicate];
        return [NSCompoundPredicate andPredicateWithSubpredicates:@[_self,theNot]];
    };
}

- (NSCompoundPredicate *(^)(NSPredicate *))orPredicate
{
    return ^id(NSPredicate* predicate){
        
        LinkHandle_REF(NSPredicate)
        LinkGroupHandle_REF(orPredicate,predicate)
        
        return [NSCompoundPredicate orPredicateWithSubpredicates:@[_self,predicate]];
    };
}

- (NSPredicate *(^)(NSDictionary *))predWithSubstitutionVariables
{
    return ^id(NSDictionary* variables){
        
        LinkHandle_REF(NSPredicate)
        LinkGroupHandle_REF(predWithSubstitutionVariables,variables)
        return [ _self predicateWithSubstitutionVariables:variables];
    };
}

- (NSCompoundPredicate *(^)(NSPredicate *))predAnd
{
    return self.andPredicate;
}
- (NSCompoundPredicate *(^)(NSPredicate *))predNot
{
    return self.notPredicate;
}
- (NSCompoundPredicate *(^)(NSPredicate *))predOr
{
    return self.orPredicate;
}
- (NSObject<NSFastEnumeration> *(^)(id))predFilterObjs
{
    return ^id(id objs){
        
        LinkHandle_REF(NSPredicate)
        LinkGroupHandle_REF(predFilterObjs,objs)
        
        if([objs conformsToProtocol:@protocol(NSFastEnumeration)]) return _self;
        
        if([objs respondsToSelector:@selector(filterUsingPredicate:)]){
            [objs filterUsingPredicate:_self];
        }else if([objs respondsToSelector:@selector(filteredArrayUsingPredicate:)]){
            return [objs filteredArrayUsingPredicate:_self];
        }else if([objs respondsToSelector:@selector(filteredSetUsingPredicate:)]){
            return [objs filteredSetUsingPredicate:_self];
        }else if([objs respondsToSelector:@selector(filteredOrderedSetUsingPredicate:)]){
            return [objs filteredOrderedSetUsingPredicate:_self];
        }
        return _self;
    };
}

- (NSObject<NSFastEnumeration> *(^)(id))predSelectObjs
{
    return ^id(id objs){
        
        LinkHandle_REF(NSPredicate)
        LinkGroupHandle_REF(predFilterObjs,objs)
        
        if([objs conformsToProtocol:@protocol(NSFastEnumeration)]) return _self;
        
        if([objs respondsToSelector:@selector(filterUsingPredicate:)]){
            objs = [objs copy];
        }
        if([objs respondsToSelector:@selector(filteredArrayUsingPredicate:)]){
            return [objs filteredArrayUsingPredicate:_self];
        }else if([objs respondsToSelector:@selector(filteredSetUsingPredicate:)]){
            return [objs filteredSetUsingPredicate:_self];
        }else if([objs respondsToSelector:@selector(filteredOrderedSetUsingPredicate:)]){
            return [objs filteredOrderedSetUsingPredicate:_self];
        }
        return _self;
    };
}
@end

