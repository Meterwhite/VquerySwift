//
//  NSArray+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//
#import "LinkBlockDefine.h"

#ifndef NSArrayNew
#define NSArrayNew ([NSArray new])
#endif


@interface NSObject(NSArraryLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK NSObject*                (^arrAt)(NSUInteger idx);
@property LB_BK BOOL                     (^arrContains)(id obj);
@property LB_BK NSNumber*                (^arrContainsAs)(id obj);
@property LB_BK NSMutableArray*          (^arrSubFrom)(NSUInteger idx);
@property LB_BK NSMutableArray*          (^arrSubTo)(NSUInteger idx);
@property LB_BK NSArray*                 (^arrObjsFromIndexTo)(NSUInteger from, NSUInteger to);
@property LB_BK NSObject*                (^arrLast)(void);
@property LB_BK NSObject*                (^arrFirst)(void);
@property LB_BK NSUInteger               (^arrIndexOfObj)(id obj);
@property LB_BK NSNumber*                (^arrIndexOfObjAs)(id obj);

#pragma mark - Foundation Speed/速度
@property LB_BK BOOL                     (^arrContainsIndex)(NSUInteger idx);
@property LB_BK NSNumber*                (^arrContainsIndexAs)(NSUInteger idx);
@property LB_BK NSUInteger               (^arrCountOfObj)(id obj);
@property LB_BK NSNumber*                (^arrCountOfObjAs)(id obj);
@property LB_BK NSMutableArray*          (^arrAddToArrAsWhatSet)(NSMutableArray* arr);
@property LB_BK NSMutableArray*          (^arrReversed)(void);
@property LB_BK NSIndexSet*              (^arrGetValuesIndexForValue)(id value);
/** use compare: to sort value */
@property LB_BK NSMutableArray*          (^arrSort)(BOOL ascending);
@property LB_BK NSMutableArray*          (^arrSortByKey)(NSString* key, BOOL ascending);
@property LB_BK NSMutableArray*          (^arrSortByKeyAscending)(NSString* key);
@property LB_BK NSMutableArray*          (^arrSortByKeyDescending)(NSString* key);


#pragma mark - Foundation Extend/补充
/** Join item as string,like it in javescript  */
@property LB_BK NSMutableString*         (^arrJoin)(NSString* split);
@property LB_BK NSMutableArray*          (^arrFilter)(NSString* predicateFormat,...);
/** return NSNull if array.count==0 */
@property LB_BK NSObject*                (^arrAny)(void);
@property LB_BK NSMutableArray*          (^arrObjsWithKindOfClass)(Class typeClass);
@property LB_BK BOOL                     (^arrContainsKeyValue)(NSString* key,id value);
@property LB_BK NSNumber*                (^arrContainsKeyValueAs)(NSString* key,id value);



#pragma mark - Weak coding/弱类型编码
/** @[@0,@1,@2] */
@property LB_BK NSIndexPath*     (^arrToNSIndexPath)(void);
@property LB_BK NSMutableOrderedSet*(^arrToNSOrderedSet)(void);
@property LB_BK NSMutableArray*  (^arrAddObj)(id obj);
@property LB_BK NSMutableArray*  (^arrAddObjs)(id objs);
/** Unable overflow */
@property LB_BK NSMutableArray*  (^arrInsertObjAt)(id obj, NSUInteger index);
/** Unable overflow */
@property LB_BK NSMutableArray*  (^arrInsertObjsAt)(id objs, NSUInteger index);

@property LB_BK NSMutableArray*  (^arrRemoveObj)(id obj);
@property LB_BK NSMutableArray*  (^arrRemoveAll)(void);
/** Unable overflow */
@property LB_BK NSMutableArray*  (^arrRemoveAt)(NSUInteger index);
/** Unable overflow;Note: 'to' is include.  */
@property LB_BK NSMutableArray*  (^arrRemoveObjsFromIndexTo)(NSUInteger from,NSUInteger to);
/** Add object only one */
@property LB_BK NSMutableArray*  (^arrAddObjUnique)(id obj);
/** Insert before */
@property LB_BK NSMutableArray*  (^arrInsertObjBefore)(id insert, id beforThis);
/** Insert next */
@property LB_BK NSMutableArray*  (^arrInsertObjNextTo)(id insert, id nextToThis);
/** Previous item */
@property LB_BK NSObject*        (^arrGetPrevItemForObj)(id obj);
/** Next item */
@property LB_BK NSObject*        (^arrGetNextItemForObj)(id obj);


#pragma mark - LinkBlock
@property LB_BK NSMutableArray*          (^arrKeyValueMatchedObjs)(NSString* key,id value);
@property LB_BK NSMutableArray*          (^arrKeyValuesMatchedObjs)(NSDictionary<NSString*,id>* kv);
@property LB_BK NSMutableArray*          (^arrReplaceObjWith)(id obj,id newObj);
/** join array-type item to one array*/
@property LB_BK NSMutableArray*          (^arrJoinArr)(void);
@property LB_BK NSMutableDictionary*     (^arrJoinDict)(void);
/** add or replace an object if key-value matched */
@property LB_BK NSMutableArray*(^arrAddOrReplaceItemCaseValueForKey)(id obj , NSString* key);
@property LB_BK NSMutableArray*(^arrInsertOrReplaceItemCaseValueForKeyAt)(id obj , NSString* key, NSUInteger idx);
/** replace an object if key-value matched */
@property LB_BK NSMutableArray*(^arrReplaceItemCaseValueForKey)(id obj,NSString* key);
@property LB_BK NSMutableArray*(^arrReplaceItemsCaseValueForKey)(NSArray* objs , NSString* key);
/** split array,each subarray has same length.Return self if count==0  */
@property LB_BK NSMutableArray*          (^arrSplitWithCount)(NSUInteger count);
/**
 Difference set by key-value,each item must has the same key.
 做'差集'(数组每项必须含字段key)
 */
@property LB_BK NSMutableArray*          (^arrMinusArrByKey)(NSArray* arr, NSString* keyPath);
/**
 union set by key-value,each item must has the same key./并集
 */
@property LB_BK NSMutableArray*          (^arrUnionArrByKey)(NSArray* arr, NSString* keyPath);
/**
 intersection set by key-value,each item must has the same key./交集
 */
@property LB_BK NSMutableArray*          (^arrInterectArrByKey)(NSArray* arr, NSString* keyPath);

@property LB_BK NSMutableArray*          (^arrReplaceItemKeyForDictionaryItem)(id key,id newKey);
/** arrReplaceItemKeyForDictionaryItem().Deep traversal */
@property LB_BK NSMutableArray*          (^arrReplaceItemKeyForDictionaryItemDepth)(id key,id newKey);
/**
 Sort NSValue-NSRange.If isCombine=YES NSRange(0,2) will contain NSRange(0,1).
*/
@property LB_BK NSMutableArray<NSValue*>*(^arrSortRange)(BOOL ascending,BOOL isCombine);
/**
 IBOutletConllection of constraint
 asPriority ∈ {NSNumber | NSArray<NSNumber*>}
 */
@property LB_BK NSArray*                (^arrConstraintsActiveByPriority)(id asPrioriry);
@end

@interface NSArray<__covariant ObjectType>(NSArraryLinkBlock)

- (NSMutableArray<ObjectType>*)arrFindUsingBlock:
(BOOL(^)(ObjectType obj, NSUInteger idx, BOOL *stop))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");


- (void)arrEnumerateWithPredicateFormat:(NSString*)predicateFormat
                             usingBlock:(void(^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 *  Enumerate string by composed from rule in array
 *  if self = @[@"cry",@"smile"],@"cry" also be treated as a composed
 */
- (void)arrStringEnumerateComposedInString:(NSString *)string usingBlock:(void (^)(NSString *subString, NSRange range, BOOL isCustom, BOOL *stop))block;
@end
