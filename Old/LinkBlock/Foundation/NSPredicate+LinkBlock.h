//
//  NSPredicate+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 2018/10/9.
//  Copyright © 2018 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#pragma mark - Normal declare


/**
 SELF_KEY is used to format to make string like "SELF == 0"
 */
#define SELF_KEY (@"SELF")

#define PredicateNew(format,args...)    \
    \
    ([NSPredicate predicateWithFormat:format,##args])

#define PredicateWitchIsFalse(witch)    \
    \
    ([NSPredicate predicateWithFormat:@"%K==0",witch])

#define PredicateWitchIsTrue(witch)\
    \
    ([NSPredicate predicateWithFormat:@"%K==1",witch])

#define PredicateWitchIsNil(witch)  \
    \
    ([NSPredicate predicateWithFormat:@"%K==nil",witch])

#define PredicateWitchNotNil(witch) \
    \
    ([NSPredicate predicateWithFormat:@"%K!=nil",witch])

#define PredicateWitchIsEqual(witch,value)  \
    \
    ([NSPredicate predicateWithFormat:@"%K=%@",witch,value])

#define PredicateWitchNotEqual(witch,value) \
    \
    ([NSPredicate predicateWithFormat:@"%K!=%@",witch,value])

#define PredicateWitchIsIn(witch,value) \
    \
    ([NSPredicate predicateWithFormat:@"%K IN (%@)",witch,value])

#define PredicateWitchNotIn(witch,value)    \
    \
    ([NSPredicate predicateWithFormat:@"NOT %K IN (%@)",witch,value])


#define PredicateWitchBeginsWith(witch,value)   \
    \
    ([NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",witch,value])

#define PredicateWitchBeginsWith(witch,value)   \
    \
    ([NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",witch,value])

#define PredicateWitchNotBeginsWith(witch,value)    \
    \
    ([NSPredicate predicateWithFormat:@"NOT %K BEGINSWITH[cd] %@",witch,value])

#define PredicateWitchEndsWith(witch,value) \
    \
    ([NSPredicate predicateWithFormat:@"%K ENDSWITH[cd] %@",witch,value])

#define PredicateWitchNotEndsWith(witch,value)  \
    \
    ([NSPredicate predicateWithFormat:@"NOT %K ENDSWITH[cd] %@",witch,value])

#define PredicateWitchContains(witch,value) \
    \
    ([NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",witch,value])

#define PredicateWitchNotContains(witch,value)  \
    \
    ([NSPredicate predicateWithFormat:@"NOT %K CONTAINS[cd] %@",witch,value])

#define PredicateWitchLike(witch,value) \
    \
    ([NSPredicate predicateWithFormat:@"%K LIKE[cd] %@",witch,value])

#define PredicateWitchGreaterThan(witch,value)  \
    \
    ([NSPredicate predicateWithFormat:@"%K>%@",witch,value])

#define PredicateWitchGreaterThanOrEqual(witch,value)   \
    \
    ([NSPredicate predicateWithFormat:@"%K>=%@",witch,value])

#define PredicateWitchLessThan(witch,value) \
    \
    ([NSPredicate predicateWithFormat:@"%K<%@",witch,value])

#define PredicateWitchLessThanOrEqual(witch,value)  \
    \
    ([NSPredicate predicateWithFormat:@"%K<=%@",witch,value])


#define PredicateWitchBetween(witch,left,right) \
    \
    ([NSPredicate predicateWithFormat:@"(%K >= %@) AND (%K < %@)",witch,left,right])



#pragma mark - LinkBlcok declare

#define PredicateWitchIsKindOfClass(witch,type)\
    \
([NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,id bindings) {\
    if(![witch isEqualToString:SELF_KEY]){\
        evaluatedObject = [evaluatedObject valueForKeyPath:witch];\
    }\
    return [evaluatedObject isKindOfClass:[type class]];\
}])

#define PredicateWitchNotNSNull(witch)  \
    \
    ([NSPredicate predicateWithFormat:@"SELF!=%@",NSNull.null])


@interface NSObject(NSPredicateLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK NSPredicate*(^predWithSubstitutionVariables)(NSDictionary* variables);
@property LB_BK NSObject<NSFastEnumeration>* (^predFilterObjs)(id objs);
/** equal to ^andPredicate */
@property LB_BK NSCompoundPredicate* (^predAnd)(NSPredicate* predicate);
@property LB_BK NSCompoundPredicate* (^predNot)(NSPredicate* predicate);
@property LB_BK NSCompoundPredicate* (^predOr)(NSPredicate* predicate);

#pragma mark - Foundation Speed/速度
/**
 *  predicateA.andPredicate(predicateB);
 */
@property LB_BK NSCompoundPredicate* (^andPredicate)(NSPredicate* predicate);
@property LB_BK NSCompoundPredicate* (^notPredicate)(NSPredicate* predicate);
@property LB_BK NSCompoundPredicate* (^orPredicate)(NSPredicate* predicate);

#pragma mark - Foundation Extend/补充
/** select means not to modify original object,here is 'objs' */
@property LB_BK NSObject<NSFastEnumeration>* (^predSelectObjs)(id objs);

#pragma mark - Weak coding/弱类型编码

#pragma mark - LinkBlock

@end
