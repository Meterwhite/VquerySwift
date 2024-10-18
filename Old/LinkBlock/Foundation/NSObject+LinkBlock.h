//
//  NSObject+LinkBlock.h

//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(LinkBlockNSObject)

#pragma mark - Foundation Mirror
@property LB_BK NSObject*    (^objCopy)(void);
@property LB_BK NSObject*    (^objMutableCopy)(void);
/** NSLog(@"%@",self); */
@property LB_BK NSObject*    (^nslog)(void);
@property LB_BK BOOL         (^objIsEqual)(id obj);
@property LB_BK NSNumber*    (^objIsEqualAs)(id obj);
@property LB_BK NSString*    (^objClassName)(void);
@property LB_BK NSString*    (^objSuperclassName)(void);

@property LB_BK BOOL         (^objIsRespondsSEL)(SEL sel);
@property LB_BK NSNumber*    (^objIsRespondsSELAs)(SEL sel);
@property LB_BK BOOL         (^objIsKindOf)( __unsafe_unretained Class clazz);
@property LB_BK NSNumber*    (^objIsKindOfAs)( __unsafe_unretained Class clazz);
@property LB_BK BOOL         (^objIsSubClassOf)( __unsafe_unretained Class clazz);
@property LB_BK NSNumber*    (^objIsSubClassOfAs)( __unsafe_unretained Class clazz);
@property LB_BK BOOL         (^objIsMemberOfClass)( __unsafe_unretained Class clazz);
@property LB_BK NSNumber*    (^objIsMemberOfClassAs)( __unsafe_unretained Class clazz);

/** result nil==>NSNull , NSNull.linkEnd == nil */
@property LB_BK NSObject*    (^objValueForKey)(NSString* key);
/** result nil==>NSNull , NSNull.linkEnd == nil */
@property LB_BK NSObject*    (^objValueForKeyPath)(NSString* key);
@property LB_BK NSObject*    (^objSetValueForKey)(id value,NSString* key);
@property LB_BK NSObject*    (^objSetValueForKeyPath)(id value,NSString* key);
@property LB_BK NSObject*    (^objSetValuesWithKeyValues)(NSDictionary<NSString *,id> * keyValues);
@property LB_BK NSDictionary*(^objKeyValueWithKeys)(NSArray<NSString*>*keys);
@property LB_BK NSObject*    (^objPerformSelector)(SEL sel);

#pragma mark - Foundation Speed/速度
/**
 <^NSNumber*(NSString* predicateFormat,...)>
 Refer to : evaluateWithObject:
 */
@property LB_BK NSNumber*    (^objEvaluatePredicateAs)(NSString* predicateFormat,...);
/** <^BOOL(NSString* predicateFormat,...)> */
@property LB_BK BOOL         (^objEvaluatePredicate)(NSString* predicateFormat,...);
/** Determine if is block */
@property LB_BK BOOL         (^objIsKindOfNSBlock)(void);
@property LB_BK NSNumber*    (^objIsKindOfNSStringAs)(void);
@property LB_BK NSNumber*    (^objIsKindOfNSArrayAs)(void);
@property LB_BK NSNumber*    (^objIsKindOfNSDictionaryAs)(void);
@property LB_BK NSNumber*    (^objIsKindOfUIViewAs)(void);
@property LB_BK NSNumber*    (^objIsKindOfNSValueAs)(void);
@property LB_BK NSNumber*    (^objIsKindOfNSNumberAs)(void);
@property LB_BK NSObject*    (^objSetValueForKdelegate)(id value);
@property LB_BK NSObject*    (^objSetValueForKdataSource)(id value);
@property LB_BK NSObject*    (^objSetValueForKtext)(id value);

/**
 view.objSetScreenWidthForKeyPath(@"[<frame||bounds>.]size.width");
 view.objSetScreenWidthForKeyPath(@"width");
 */
//@property LB_BK NSObject*  (^objSetScreenWidthForPath)(NSString* path);
@property LB_FN NSObject*  logRetainCount;
@property LB_FN CFIndex    objRetainCount;


#pragma mark - Foundation Extent
/** 是否是可变类型*/
@property LB_BK BOOL         (^objIsMutable)(void);
@property LB_BK NSNumber*    (^objIsMutableAs)(void);
/** 可变拷贝并且操作到子项 */
@property LB_BK NSObject*    (^objMutableCopyEnumerate)(void);
/** <^()> 不可变对象转为可变对象，否则不会发生任何事 */
@property LB_BK NSObject*    (^objNeedMutable)(void);
@property LB_BK NSObject*    (^nslogValueForKeyPath)(NSString* key);
/** asKey∈{NSString,NSArray} */
@property LB_BK NSObject*    (^objSetNilForKey)(id asKey);
/** asKey∈{NSString,NSArray} */
@property LB_BK NSObject*    (^objSetRandomStringForKeyPath)(id asKey, NSUInteger len);
/** asKey∈{NSString,NSArray} */
@property LB_BK NSObject*    (^objSetRandomStringzh_CNForKeyPath)(id asKey, NSUInteger len);
/** asKey∈{NSString,NSArray}随机数字字符串，不会以'0'作为开始 */
@property LB_BK NSObject*    (^objSetRandomStringNumberForKeyPath)(id asKey, NSUInteger len);
/** asKey∈{NSString,NSArray} set integer value */
@property LB_BK NSObject*    (^objSetRandomNumberForKeyPath)(id asKey, uint32_t max);
/** asKey∈{NSString,NSArray} set double value */
@property LB_BK NSObject*    (^objSetRandomDoubleForKeyPath)(id asKey, uint32_t max, NSUInteger len);
/**
 *  asKey∈{NSString,NSArray} set NSDate
 *  days∈{NSNumber,NSArray<NSNumber>}
 *  days == @(-30) or @[@(-30)]random in the past 30 days；Otherwise opposite
 *  days == @[@(-30) , @(30)]，random in the past 30 days or next 30 days
 *  days == nil or @0，random in the past 24 hours
 */
@property LB_BK NSObject*    (^objSetRandomDateForKeyPath)(id asKey,id days);
/**
 *  <^(NSString* key)>
 *  bool取反: bool type=<YES/NO>,NSNumber 同理<@YES/@NO>,
 *  相反数: number type = <1/-1> .NSNumber 同理,<@(1),@(-1)>
 *  字符串逆序: <@"abc"/@"cba">
 *  width和height的交换: CGRect和CGSize
 *  CGPoint,CGVector,UIOffset 交换值
 *  UIEdgeInsets,NSDirectionalEdgeInsets 交换上下值,交换左右值
 *  特别的：属性类型是c的直接量属性时,无法区分这三种类型<bool,char,xyShort>,此处按bool对待
 */
@property LB_BK NSObject*    (^objReverseValueForKey)(NSString* key);

/** Set all value nil or 0 while key accessible  */
@property LB_BK NSObject*    (^objSetAllValuesBlank)(void);

/** Return self */
@property LB_BK NSObject*    (^objPerformSelectors)(SEL sel0,...);
@property LB_BK NSObject*    (^objPerformSelectorArgument)(SEL sel,id arg);
@property LB_BK NSObject*    (^objPerformsSelectorArguments)(SEL sel0,NSArray* args0,...);
/**
 *  Perform selector and return retuslt.
 *  All result is boxed.
 *  (void || nil => return NSNull)
 **/
@property LB_BK NSObject*    (^objPerformSelectorAsWhatReturn)(SEL sel);
@property LB_BK NSArray*     (^objPerformSelectorsAsWhatReturns)(SEL sel0,...);
@property LB_BK NSObject*    (^objPerformSelectorArgumentAsWhatReturn)(SEL sel,id arg);
@property LB_BK NSArray*     (^objPerformsSelectorArgumentsAsWhatReturns)(SEL sel0,NSArray*args0,...);



#pragma mark - Weak coding/弱类型编码
/** From NSJSONSerialization */
@property LB_BK NSString*    (^objToJsonString)(void);
/** retrun value can be used to NSJSONSerialization  */
@property LB_BK NSObject*    (^objToNSJsonObject)(void);
@property LB_BK NSObject*    (^objToNSJsonObjectDepth)(void);
@property LB_BK NSObject*    (^objToNSJsonObjectFoundation)(void);
@property LB_BK NSObject*    (^objToNSJsonObjectDepthAndFoundation)(void);
/** self is not a collection object  */
@property LB_BK NSDictionary*(^objToNSDictionary)(void);
@property LB_BK NSDictionary*(^objToNSDictionaryWithKeys)(NSArray* asKey);
/** <JSValue & NSString> to nsnumber */
@property LB_BK NSNumber*    (^objToNSNumber)(void);
/** objs∈{NSArray,NSOrderedSet} */
@property LB_BK NSObject*    (^objGetPrevItemFromObjs)(id objs);
@property LB_BK NSObject*    (^objGetNextItemFromObjs)(id objs);
/** obs∈{UIView,CALayer,UIViewController,NSIndexSet,.objectEnumerator} */
@property LB_BK NSNumber*    (^objIsSubitemOfObjAs)(id obj);
/** objs∈{.objectEnumerator,NSIndexSet} */
@property LB_BK BOOL         (^objIsSubitemOfObjs)(id objs);
@property LB_BK NSNumber*    (^objIsSubitemOfObjsAs)(id objs);
/** objs∈{.keyEnumerator} */
@property LB_BK BOOL         (^objIsKeyOfObjs)(id objs);
@property LB_BK NSNumber*    (^objIsKeyOfObjsAs)(id objs);
/** Determine object if is NSNumber or number of string */
@property LB_BK NSNumber*    (^objIsNumberAs)(void);
/** Determine type or protocol{<NSFastEnumeration>,NSIndexSet,NSIndexPath} */
@property LB_BK NSNumber*    (^objIsCollectionAs)(void);

/**
 object that can get item by index
 obj ∈  {
    .responseToSelector(
        indexOfObject:,characterAtInde:,
        indexAtPosition:,pointerAtIndex:,
        resultAtIndex:,rangeAtIndex:,
        valueAtIndex:,glyphAtIndex:)
 }
 */
@property LB_BK NSNumber*  (^objIsIndexableAs)(void);
/**
 Collection that can get item by key
 obj ∈ {
    .responseToSelector(
        objectForKey:,propertyForKey:
    )
 }
 */
@property LB_BK NSNumber*  (^objIsKeyableAs)(void);
/**
 Array-able means object can convert to array object;
 obj ∈  {
    __kindof NSArray,
    .responseToSelector(
    allObjects,array
 )
 }
 */
@property LB_BK NSNumber*  (^objIsArrayableAs)(void);
/**
 Dictionary-able means object can convert to dictionary object;
 obj ∈  {
    __kindof NSDictionary,
    .responseToSelector(
        dictionaryRepresentation
    )
 */
@property LB_BK NSNumber*  (^objIsDictionaryableAs)(void);

/**
 self ∈ {
 NSString ,NSMutableString ,
 .responsetoSelector(
    addObject:, addEntriesFromDictionary:,
    appendAttributedString:, addSubview:, addSublayer:,
    appendData:, appendPath:, addIndex:
 )}
 note:String∈{NSString , NSMutableString}
 */
@property LB_BK NSObject*    (^objAdd)(id obj);
/** Refer to:objAdd */
@property LB_BK NSObject*    (^objAddTo)(id obj);
/** switch link object to parameter */
@property LB_BK NSObject*    (^objAddToAsWhatSet)(id obj);


/**
 self ∈ {
    NSString,NSMutableString,
    .responseToSelector(
        insertObject:atIndex:,
        insertSubview:atIndex:,
        insertSublayer:atIndex:
    )
 }
 */
@property LB_BK NSObject*    (^objInsert)(id obj , NSUInteger idx);
/** Refer to:objInsert */
@property LB_BK NSObject*    (^objInsertTo)(id obj , NSUInteger idx);
/** switch link object to parameter */
@property LB_BK NSObject*    (^objInsertToAsWhatSet)(id obj , NSUInteger idx);

/**
 self∈{
 NSString,NSMutableString,
 .responseToSelector(removeObject:,
    removeFromSuperview,
    removeFromSuperlayer,
    removeFromParentViewController,
    removeIndex:
    removeObjectForKey:
 )
 }
 */
@property LB_BK NSObject*    (^objRemove)(id obj);
/** Refer to:objRemove */
@property LB_BK NSObject*    (^objRemoveFrom)(id obj);
/** switch link object to parameter */
@property LB_BK NSObject*    (^objRemoveFromAsWhatSet)(id obj);


/**
 self   ∈   {
    NSString,NSMutableString,UIView,CALayer,
    .responseToSelector(
        removeAllObjects,removeAllIndexes,
        removeAllPoints,removeAllSegments,
        setText:
    )
 }
 note:setText: means setText:@"";
 */
@property LB_BK NSObject*    (^objRemoveAll)(void);

/**
 Type of objs is kind of collection that can be sort;
 */
@property LB_BK NSObject<NSFastEnumeration>*(^objsSortByKey)(NSString* key,BOOL ascending);
@property LB_BK NSObject<NSFastEnumeration>*(^objsSortByKeyAscending)(NSString* key);
@property LB_BK NSObject<NSFastEnumeration>*(^objsSortByKeyDescending)(NSString* key);
@property LB_BK NSObject<NSFastEnumeration>*(^objsFilterByPredicate)(NSPredicate* pred);
/** 'select' means not to modify original object */
@property LB_BK NSObject<NSFastEnumeration>*(^objsSelectByPredicate)(NSPredicate* pred);
@property LB_BK NSObject<NSFastEnumeration>*(^objsSelectByPredicateString)(NSString* pred);


///MARK: These API are for collection type.
@property LB_BK NSObject*  (^objsAddItem)(id item);
@property LB_BK NSObject*  (^objsRemoveAllItem)(void);
///MARK: Index-able collection.
@property LB_BK NSObject*  (^objsItemAt)(NSUInteger idx);
/** ...objsIndexOfItemAs().anUnsignedIntegerNumber... */
@property LB_BK NSNumber*  (^objsIndexOfItemAs)(id item);
@property LB_BK NSObject*  (^objsLastItem)(void);
@property LB_BK NSObject*  (^objsFirstItem)(void);
///MARK: Key-able collection.
@property LB_BK NSObject*  (^objsItemForKey)(id key);
@property LB_BK NSObject*  (^objsSetItemForKey)(id item,id key);
/** Refer to: objIsArrayableAs(). */
@property LB_BK NSArray*   (^objsArrayRepresentation)(void);
/** Refer to: objIsDictionaryableAs() */
@property LB_BK NSDictionary*   (^objsDictionaryRepresentation)(void);

/**
 self   ∈   {
    .responseToSelector(
        count,
        length
    )
 }
 Return @(NSNotFound) if not response to sel.
 */
@property LB_BK NSNumber*    (^objLengthAs)(void);
@property LB_BK NSUInteger   (^objLength)(void);
/** Same as `objLength` */
@property LB_BK NSUInteger   (^objCount)(void);


#pragma mark - LinkBlock

/**
 *  Extend keyPath for [setValue:forKeyPath:].Provides access to key-value pairs of structures.
 *  Use operator '->' to access structure member in 'fullPath',else 'fullPath' is the same as keyPath.
 *  :
 *  @"view.nickNameLable.frame->size->width"
 */
@property LB_BK NSObject*    (^objValueForFullPath)(NSString* fullPath);
/** Refer to : objValueForFullPath */
@property LB_BK NSObject*    (^objSetValueForFullPath)(id value, NSString* fullPath);
/** search is ignoring Case.This block is invalid for the Foundation propertys.It works for custom propertys.  */
@property LB_BK NSObject*    (^objSetValueForSubkey)(id value, NSString* subkey);
/** set value for all matched key by regex.This block is invalid for the Foundation propertys.It works for custom propertys. */
@property LB_BK NSObject*    (^objSetValueForRegexKey)(id value, NSString* regexKey);
@property LB_BK NSNumber*    (^objEachValueIsTrueForKeyPathsAs)(id<NSFastEnumeration> keyPaths);
@property LB_BK NSNumber*    (^objSomeValueIsTrueForKeyPathsAs)(id<NSFastEnumeration> keyPaths);
/**
 <^NSNumber*(NSString* keyPath,NSString* predicateFormat,...)>
 Refer to : objEvaluatePredicateAs
 */
@property LB_BK NSNumber*    (^objEvaluateValueForKeyPathAs)(NSString* keyPath,NSString* predicateFormat,...);
/** <^BOOL(NSString* keyPath,NSString* predicateFormat,...)> */
@property LB_BK BOOL         (^objEvaluateValueForKeyPath)(NSString* keyPath,NSString* predicateFormat,...);
/**
 <^NSObject*(id value, NSString* keyPath,NSString* predicateFormat,...)>
 If self matched by predicate call setValue:forkeyPath:
 Refer to : objEvaluatePredicateAs.
 */
@property LB_BK NSObject*    (^objSetValueForKeyPathWhenEvaluated)(id value, NSString* keyPath,NSString* predicateFormat,...);
/**
 *  Set screen size,width,height by FullPath.(Fullpath refer to: objValueForFullPath.)
 *  -
 *  width : "view.frame->size->width" , "label.myWidth0" ,...
 *  height: "label.y" , "label.myBottom" ,...
 *  size  : <unclearKey> , "mySize"
 *  -
 *  Discussion:
 *  1.When fullPath is for struct that contains '->':
 *  Set to height when last component of keyPath is euqual to one of {height,y,vertical,top,bottom},otherwise width.
 *  2.When fullpath is normal keyPath(Ignoring Case):
 *  Set height if last component of keyPath is contains one of {height,y,vertical,top,bottom} or euqal to y'.If not contains 'width' that will set to size,otherwise set to width.
 *  In a word : width > height > size.
 */
@property LB_BK NSObject*    (^objSetScreenValueForFullPath)(NSString* fullPath);
/**
 *  Refer to : objValueForFullPath
 *  Same as:
 *  [B setValue:[A valueForKeyPath:keyPath] forKey:keyPath];
 *  Note: asFullPath    ∈   {NSString , NSArray<NSString>}
 */
@property LB_BK NSObject*    (^objCopyValueFromObjectByFullPath)(id srcObj,id asFullPath);

/**
 key : property name of an object.
 
 return value
 :
 @"id"          :       id and id<Protocol>
 ClassName      :       Like 'NSObject'
 StructName     :       structual.Like 'CGRect','_NSRange'
 @"NSBlock"     :       block
 @"SEL"         :       sel value
 @"objc_ivar"   :       objc_ivar value
 @"objc_method" :       objc_method value
 c type         :       '[unsigned ]char' , '[unsigned ]int' , '[unsigned ]short' ,
                        '[unsigned ]long' , '[unsigned ]long long' ,
                        'float' , 'double' , 'bool'
 nil            :       useless data
 */
@property LB_SBK NSString*    (^classProgrammingTypeForKey)(NSString* key);

/**
 asKey  ∈   {NSString,NSArray<NSString>}
 The key id property name.
 
 Initialize value for key if the type of the key is explicit.
 When type is one of 'id','SEL','objc_ivar','objc_method' and 'NSBlock', it will do nothing.
 
 */
@property LB_BK NSObject*     (^objInitializeValueForKey)(id asKey);

/** !Print object as json string */
@property LB_BK NSObject*    (^po)(void);
@property LB_BK NSObject*    (^poDetail)(void);
/** Determine if object contain info/对象是否有内容
 check：
 String Type - Empty
 NSValue Type(NSNumber-0，Struct-DefaultValue，Others-NULL)
 Collection contains item
 UIView contains subview
 Custom Type - nil
 */
@property LB_BK BOOL         (^objIsBlank)(void);
@property LB_BK BOOL         (^objIsNSNull)(void);
@property LB_BK NSNumber*    (^objIsNSNullAs)(void);

@property LB_BK NSObject*    (^objCopyByArchive)(void);

@property LB_BK BOOL         (^objIsEqualToEach)(id obj,...);
@property LB_BK NSNumber*    (^objIsEqualToEachAs)(id obj,...);
@property LB_BK BOOL         (^objIsEqualToEachInArray)(NSArray* arr);
@property LB_BK NSNumber*    (^objIsEqualToEachInArrayAs)(NSArray* arr);
@property LB_BK BOOL         (^objIsEqualToSomeone)(id obj,...);
@property LB_BK NSNumber*    (^objIsEqualToSomeoneAs)(id obj,...);
@property LB_BK BOOL         (^objIsEqualToSomeoneInArray)(NSArray* arr);
@property LB_BK NSNumber*    (^objIsEqualToSomeoneInArrayAs)(NSArray* arr);



#pragma mark - NSBlock
@property LB_BK NSUInteger    (^blockArgsCount)(void);
@property LB_BK const char *  (^blockReturnType)(void);


#pragma mark - NSClass
/** Determine if is Foundation type */
+ (BOOL)lb_classIsBasic;
+ (BOOL)lb_classContainProperty:(NSString*)property;
+ (BOOL)lb_classContainIvar:(NSString*)ivarName;
+ (NSArray<NSString*>*)lb_classGetIvarList;
+ (NSArray<NSString*>*)lb_classGetPropertyList;
/** reference:property type encodings;<(NSString*)key> */
+ (NSString*)lb_classGetPropertyType:(NSString*)key;
/** Depth Traversal */
+ (NSArray<NSString*>*)lb_classGetAllPropertyList:(BOOL)includeFoundation;
- (NSArray<NSString*>*)lb_objGetInstanceMethodList;
+ (NSArray<NSString*>*)lb_classGetClassMethodList;
+ (NSArray<NSString*>*)lb_classGetProtocolList;
/** Depth Traversal */
+ (void)lb_classEnumerateUsingBlock:(void(^)(Class clazz , BOOL* stop))block
                       includeBasic:(BOOL)includeBasic;

/** propertyName reference:property type encodings */
+ (void)lb_classPropertysEnumerateUsingBlock:(void(^)(Class clazz,NSString* propertyName,NSString* propertyType,BOOL* stop))block includeBasic:(BOOL)includeBasic;

@end
