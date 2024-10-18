//
//  Others+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/10/1.
//  Copyright © 2016年 NOVO. All rights reserved.
//


#import "LinkBlock.h"

@implementation NSObject(OtherLinkBlock)

- (NSUInteger (^)(void))strLength
{return ^(){return self.asNSString.length;};}


- (NSObject *(^)(id*))setTo
{return self.objSetTo;}

- (NSObject *(^)(id*))objSetTo
{
    return ^id(id* toObject){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetTo,toObject)
        *toObject= _self;
        return _self;
    };
}

- (NSObject *(^)(void))objValueRandom
{return self.objValuesRandom;}

- (NSObject *(^)(id))objSetDelegate
{return self.objSetValueForKdelegate;}

- (UIImage *(^)(float))imgBlur
{return ^id(float percent){return self.imgBlurLightRadius(percent*(20.0/0.6));};}


- (NSMutableArray *(^)(id, id))arrInsertBehind
{
    return ^id(id obj, id behindObj){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertBehind,obj,behindObj)
        if(![_self isKindOfClass:[NSMutableArray class]]){
            _self = [_self mutableCopy];
        }
        return _self.arrInsertNext(obj,behindObj);
    };
}


- (NSObject *(^)(NSString *))nslogTitle
{
    return ^id(NSString* title){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(nslogTitle,title)
        NSLog(@"%@%@",title,_self);
        return _self;
    };
}

- (NSObject *(^)(NSString *))logInfo
{
    return ^id(NSString* info){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(logInfo,info)
        NSLog(@"%@",info);
        return self;
    };
}


- (NSValue *(^)(NSArray *))valueCGPointSetToViews
{
    return ^id(NSArray* views){
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueCGPointSetToViews,views)
        [views enumerateObjectsUsingBlock:^(UIView* v, NSUInteger idx, BOOL *stop) {
            if([v isKindOfClass:[UIView class]]){
                CGRect frame = v.frame;
                frame.origin = [_self CGPointValue];
                v.frame = frame;
            }
        }];
        return _self;
    };
}

- (NSValue *(^)(NSArray *))valueCGSizeSetToViews
{
    return ^id(NSArray* views){
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueCGSizeSetToViews,views)
        [views enumerateObjectsUsingBlock:^(UIView* v, NSUInteger idx, BOOL *stop) {
            if([v isKindOfClass:[UIView class]]){
                CGRect frame = v.frame;
                frame.size = [_self CGSizeValue];
                v.frame = frame;
            }
        }];
        return _self;
    };
}

- (NSObject *(^)(void))objValuesRandom
{
    return ^id(){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objValuesRandom)
        
        unsigned int outCount, i;
        objc_property_t* properties = class_copyPropertyList([self class], &outCount);
        for(i=0 ; i< outCount; i++){
            
            NSString* pName = @(property_getName(properties[i]));
            NSString *attrs = @(property_getAttributes(properties[i]));
            NSUInteger dotLoc = [attrs rangeOfString:@","].location;
            NSArray* attrInfos = [attrs componentsSeparatedByString:@","];
            NSString *code = nil;
            NSUInteger loc = 1;
            if (dotLoc == NSNotFound) { // 没有
                code = [attrs substringFromIndex:loc];
            } else {
                code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
            }
            
            if([attrInfos containsObject:@"R"]){//只读属性
                continue;
            }
            else if (![[attrInfos.lastObject substringToIndex:1] isEqualToString:@"V"]){//无值
                continue;
            }
            
            if ([code isEqualToString:@"@"]) {
                //id
                continue;
            } else if (code.length == 0) {
                //KVCDisabled
                continue;
            } else if (code.length > 3 && [code hasPrefix:@"@\""]) {//对象
                // 去掉@"和"，截取中间的类型名称
                code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
                Class clazz = NSClassFromString(code);
                
                if([clazz isSubclassOfClass:[NSNumber class]]){//数字
                    [_self setValue:@(arc4random_uniform(10000)) forKey:pName];
                }else if ([clazz isSubclassOfClass:[NSMutableString class]]){//字符串
                    [_self setValue:[[NSUUID UUID].UUIDString substringToIndex:4].mutableCopy forKey:pName];
                }else if ([clazz isSubclassOfClass:[NSString class]]){
                    [_self setValue:[[NSUUID UUID].UUIDString substringToIndex:4] forKey:pName];
                }else if ([clazz isSubclassOfClass:[NSDate class]]){//日期
                    [_self setValue:[NSDate dateWithTimeIntervalSince1970:arc4random_uniform(MAXFLOAT)] forKey:pName];
                }else if ([clazz isSubclassOfClass:[UILabel class]] ||
                          [clazz isSubclassOfClass:[UITextView class]] ||
                          [clazz isSubclassOfClass:[UITextField class]]){
                    
                    UIView* titleView = [clazz new];
                    [titleView setValue:[[NSUUID UUID].UUIDString substringToIndex:4] forKeyPath:@"text"];
                    [_self setValue:titleView forKey:pName];
                }else if ([clazz isSubclassOfClass:[UIButton class]]){
                    
                    UIButton* btn = [clazz new];
                    [btn setTitle:[[NSUUID UUID].UUIDString substringToIndex:4] forState:UIControlStateNormal];
                    [_self setValue:btn forKey:pName];
                }
            } else if ([code isEqualToString:@":"] ||//SEL
                       [code isEqualToString:@"^{objc_ivar=}"] ||//ivar
                       [code isEqualToString:@"^{objc_method=}"] ||//Method
                       [code isEqualToString:@"@?"]) {//block
                //KVCDisabled
                continue;
            }
            
            // 是否为数字类型
            NSString *lowerCode = code.lowercaseString;
            NSArray *numberTypes = @[@"i", @"s", @"c", @"b", @"f", @"d", @"l", @"q", @"c"];
            if ([numberTypes containsObject:lowerCode]) {
                //numberType
                [_self setValue:@(arc4random_uniform(10001)) forKey:pName];
                if ([lowerCode isEqualToString:@"c"]  || [lowerCode isEqualToString:@"b"]) {
                    //boolType
                    [_self setValue:@(arc4random_uniform(2)==0?NO:YES) forKey:pName];
                }
            }
        }
        
        free(properties);
        return _self;
    };
}

- (NSObject* (^)(__unsafe_unretained Class))objMustType
{
    return ^id(Class clazz){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objMustType,clazz)
        if(!clazz || ![_self isKindOfClass:clazz]){
            return [clazz new];
        }else{
            return _self;
        }
    };
}

- (NSObject *(^)(NSMutableArray *))objAddToArr
{
    return ^id(NSMutableArray* arr){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objAddToArr,arr)
        if([arr isKindOfClass:[NSMutableArray class]]){
            [arr addObject:_self];
        }
        return _self;
    };
}

- (NSObject *(^)(NSMutableArray *))objRemoveFromArr
{
    return ^id(NSMutableArray* arr){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objRemoveFromArr,arr)
        if([arr isKindOfClass:[NSMutableArray class]]){
            [arr removeObject:_self];
        }
        return _self;
    };
}

- (NSObject *(^)(NSMutableDictionary *, id<NSCopying>))objSetToDict
{
    return ^id(NSMutableDictionary* dict, id<NSCopying> key){
        LinkHandle_REF(NSObject)
        LinkGroupHandle_REF(objSetToDict,dict,key)
        dict[key] = _self;
        return _self;
    };
}

#pragma mark - 2018.10

- (NSArray *(^)(id, NSString *))arrSetValueForKey
{
    return ^id(id value , NSString* key){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrSetValueForKey,value,key)
        [_self setValue:value forKeyPath:key];
        return _self;
    };
}

- (NSDictionary *(^)(void))arrToDictByKeyNumber
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrToDictByKeyNumber)
        NSMutableDictionary* re= [NSMutableDictionary dictionary];
        [_self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [re setObject:obj forKey:@(idx)];
        }];
        return [re copy];
    };
}

- (NSDictionary *(^)(void))arrToDictByKeyString
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrToDictByKeyString)
        NSMutableDictionary* re= [NSMutableDictionary dictionary];
        [_self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [re setObject:obj forKey:[NSString stringWithFormat:@"%lu", (unsigned long)idx]];
        }];
        return [re copy];
    };
}

- (NSMutableArray *(^)(void))arrObjsValueRandom
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrObjsValueRandom)
        
        [_self enumerateObjectsUsingBlock:^(NSObject*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.objValuesRandom();
        }];
        return [_self mutableCopy];
    };
}
- (NSDictionary *(^)(void))dictObjsValueRandom
{
    return ^id(){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictObjsValueRandom)
        [_self.allValues enumerateObjectsUsingBlock:^(NSObject*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.objValuesRandom();
        }];
        return _self;
    };
}

- (NSArray *(^)(void))dictAllKeys
{
    return ^id(){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictAllKeys)
        return [_self allKeys];
    };
}

- (NSArray *(^)(void))dictAllValues
{
    return ^id(){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictAllValues)
        return [_self allValues];
    };
}


- (BOOL (^)(id<NSCopying>))dictGetBOOL
{
    return ^(id<NSCopying> key){
        LinkHandle_VAL_IFNOT(NSDictionary){
            return NO;
        }
        LinkGroupHandle_VAL(dictGetBOOL,key)
        if(_self[key] && ![_self[key] isKindOfClass:[NSNull class]]){//@(0),@"1",...
            if([_self[key] isKindOfClass:[NSNumber class]] || [_self[key] isKindOfClass:[NSString class]])
            {
                return [_self[key] boolValue];//@(0),@"0"
            }else{
                return NO;
            }
        }else{//nil,NSNull
            return NO;
        }
        return [_self[key] boolValue];
    };
}

- (NSNumber* (^)(id))dictGetBOOLAs
{
    return ^id(id key){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictGetBOOLAs,key)
        if(_self[key] && ![_self[key] isKindOfClass:[NSNull class]]){//@(0),@"1",...
            if([_self[key] isKindOfClass:[NSNumber class]] || [_self[key] isKindOfClass:[NSString class]])
            {
                return @([_self[key] boolValue]);//@(0),@"0"
            }else{
                return @NO;
            }
        }else{//nil,NSNull
            return @NO;
        }
        return @([_self[key] boolValue]);
    };
}

- (id (^)(id))dictGetNoNSNull
{
    return ^id(id key){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictGetNoNSNull,key)
        if(!_self[key] || [_self[key] isKindOfClass:[NSNull class]] ){
            return NSNull.null;
        }
        return _self[key];
    };
}

- (CGSize (^)(NSNumber *))labTextSize
{
    return ^CGSize(NSNumber* maxWidth){
        LinkHandle_VAL_IFNOT(UILabel){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(labTextSize,maxWidth)
        
        NSAttributedString* attrStr = _self.attributedText;
        attrStr = attrStr ? attrStr: [[NSAttributedString alloc] initWithString:_self.text attributes:@{NSForegroundColorAttributeName:_self.textColor,NSFontAttributeName:_self.font}
                                      ];
        return [attrStr boundingRectWithSize:CGSizeMake(maxWidth?maxWidth.doubleValue:CGRectGetWidth(_self.bounds), CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     context:nil].size;
    };
}

- (NSTimeInterval (^)(void))dateTimeIntervalSince1970
{
    return ^NSTimeInterval(){
        return [(id)self timeIntervalSince1970];
    };
}

- (BOOL (^)(id))strPredicateEvaluate
{
    return ^(id obj){
        return self.strPredicateEvaluateAs(obj).boolValue;
    };
}
- (NSNumber *(^)(id))strPredicateEvaluateAs
{
    return ^id(id obj){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPredicateEvaluateAs , obj)
        return @([[NSPredicate predicateWithFormat:_self] evaluateWithObject:obj]);
    };
}

- (NSArray *(^)(NSArray *))strPredicateFilteredArray
{
    return ^id(NSArray* arr){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPredicateFilteredArray , arr)
        return [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:_self]];
    };
}

- (NSString *(^)(id))strPredicateFilterMutable
{
    return ^id(id collection){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strPredicateFilterMutable,collection)
        if([collection respondsToSelector:@selector(filterUsingPredicate:)]){
            [collection filterUsingPredicate:[NSPredicate predicateWithFormat:_self]];
        }
        return _self;
    };
}
- (NSObject *(^)(id))strKeyForValueWith
{
    return ^id(id obj){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strKeyForValueWith, obj)
        return [obj valueForKey:_self];
    };
}

- (NSObject *(^)(id))strKeyPathForValueWith
{
    return ^id(id obj){
        LinkHandle_REF(NSString)
        LinkGroupHandle_REF(strKeyPathForValueWith, obj)
        return [obj valueForKeyPath:_self];
    };
}

- (NSObject *(^)(id))linkTo
{
    return ^id(id obj){
        
        if([self isKindOfClass:[LinkInfo class]]){
            if(((LinkError*)self).infoType == LinkInfoError){
                
                ((LinkError*)self).throwCount++;
            }else if(((LinkReturn*)self).infoType == LinkInfoReturn){
                
                return self;
            }
        }
        
        LinkGroupHandle_REF(linkTo,obj)
        if(obj){
            return obj;
        }
        else{
            return self;
        }
    };
}

- (NSObject *)linkFirstObj
{
    LinkHandle_REF(NSObject)
    if([_self isKindOfClass:[LinkGroup class]]){
        
        return self.thisLinkObjs.linkObjects.firstObject;
    }
    return _self;
}

- (NSObject *)linkLastObj
{
    LinkHandle_REF(NSObject)
    if([_self isKindOfClass:[LinkGroup class]]){
        
       return self.thisLinkObjs.linkObjects.lastObject;
    }
    return _self;
}
- (NSObject *(^)(NSUInteger idx))linkOut
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSObject)
        if([_self isKindOfClass:[LinkGroup class]]){
            
            if(idx>self.thisLinkObjs.linkObjects.count-1) return self;
            [self.thisLinkObjs.linkObjects removeObjectAtIndex:idx];
            return self;
        }
        return _self;
    };
}


- (NSMutableArray *(^)(NSMutableArray *, NSUInteger))arrInsertToArrayAt
{
    return ^id(NSMutableArray* arr, NSUInteger index){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrInsertToArrayAt,arr,index)
        return linkObj(arr).m_arrInsertArrayAt(_self,index);
    };
}

- (NSMutableDictionary *(^)(id,id))dictSetWithKeyObject
{
    return ^id(id key  , id value){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictSetWithKeyObject,key,value)
        
        if(!LB_IsKindOfClass(_self, NSMutableDictionary)){
            LB_MCopy_VAR(_self);
        }
        
        if(value && key){
            [_self setObject:value forKey:key];
        }
        return _self;
    };
}

- (NSObject *)linkFrom:(NSUInteger)from to:(NSUInteger)to block:(void (^)(NSUInteger, NSObject *))block
{
    LinkHandle_REF(NSObject)
    if([self isKindOfClass:[LinkGroup class]]){
        LinkGroup* group = self.thisLinkObjs;
        [group.linkObjects.arrObjsFromIndexTo(from,to) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(block){
                block(idx,obj);
            }
        }];
    }
    return self;
}

- (NSObject *)linkAt:(NSUInteger)idx block:(void (^)(NSObject *))block
{
    LinkHandle_REF(NSObject)
    if([self isKindOfClass:[LinkGroup class]]){
        if(block){
            LinkGroup* group = self.thisLinkObjs;
            if(idx<group.linkObjects.count-1){
                block(group.linkObjects[idx]);
            }
        }
    }
    return self;
}

- (NSObject*)linkAfterIn:(double)time block:(void(^)(NSObject* link))block
{
    LinkHandle_REF(NSObject)
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(block)   block(_self);
    });
    return _self;
}

- (NSObject *)linkAsy_main_queue:(void (^)(NSObject *))block
{
    LinkHandle_REF(NSObject)
    dispatch_async(dispatch_get_main_queue(), ^{
        if(block)   block(_self);
    });
    return _self;
}

- (NSObject *)linkAsy_global_queue:(void (^)(NSObject *))block
{
    LinkHandle_REF(NSObject)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if(block)   block(_self);
    });
    return _self;
}

- (NSObject *)linkInBlock:(void (^)(NSObject *))block
{
    LinkHandle_REF(NSObject)
    if(block)   block(_self);
    return _self;
}
- (NSObject *)linkLoopIn:(NSUInteger)count block:(void (^)(NSObject *, NSUInteger))block
{
    LinkHandle_REF(NSObject)
    
    if(!block)
        return _self;
    
    for (int i=0; i<count; i++)
        block(_self , i);
    
    return _self;
}

- (UIView *(^)(UIView *))viewCopyX
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyX,fromView)
        CGRect frame = _self.frame;
        frame.origin.x = fromView.frame.origin.x;
        _self.frame= fromView.frame;
        return _self;
    };
}

- (UIView *(^)(UIView *))viewCopyY
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyY,fromView)
        CGRect frame = _self.frame;
        frame.origin.y = fromView.frame.origin.y;
        _self.frame= fromView.frame;
        return _self;
    };
}

- (UIView *(^)(UIView *))viewCopyFrame
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyFrame,fromView)
        _self.frame= fromView.frame;
        return _self;
    };
}

- (UIView *(^)(UIView *))viewCopySize
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopySize,fromView)
        CGRect frame = _self.frame;
        frame.size= fromView.frame.size;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(UIView *))viewCopyOrigin
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyOrigin,fromView)
        CGRect frame = _self.frame;
        frame.origin= fromView.frame.origin;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(UIView *))viewCopyCenter
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyCenter,fromView)
        _self.center = fromView.center;
        return _self;
    };
}



- (UIView *(^)(UIView *))viewCopyCenterX
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyCenterX,fromView)
        CGPoint center = _self.center;
        center.x= fromView.center.x;
        _self.center = center;
        return _self;
    };
}

- (UIView *(^)(UIView *))viewCopyCenterY
{
    return ^id(UIView* fromView){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewCopyCenterY,fromView)
        CGPoint center = _self.center;
        center.y= fromView.center.y;
        _self.center = center;
        return _self;
    };
}

- (UIView *(^)(UIView *, CGFloat))viewTopTo
{
    return ^id(UIView* toView, CGFloat margin){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewTopTo,toView,margin)
        CGRect frame = _self.frame;
        frame.origin.y = toView.viewMaxY()+ margin;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(UIView *, CGFloat))viewBottomTo
{
    return ^id(UIView* toView, CGFloat margin){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewBottomTo,toView,margin)
        CGRect frame = _self.frame;
        frame.origin.y = toView.frame.origin.y - margin;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(UIView *, CGFloat))viewLeftTo
{
    return ^id(UIView* toView, CGFloat margin){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewLeftTo,toView,margin)
        CGRect frame = _self.frame;
        frame.origin.x = toView.frame.origin.x - frame.size.width- margin;
        _self.frame = frame;
        return _self;
    };
}

- (UIView *(^)(UIView *, CGFloat))viewRightTo
{
    return ^id(UIView* toView, CGFloat margin){
        LinkHandle_REF(UIView)
        LinkGroupHandle_REF(viewRightTo,toView,margin)
        CGRect frame = _self.frame;
        frame.origin.x = toView.viewMaxX() + margin;
        _self.frame = frame;
        return _self;
    };
}


- (NSNumber *(^)(void))arrMaxNumber
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrMaxNumber)
        __block NSNumber* max = _self[0];
        [_self enumerateObjectsUsingBlock:^(NSNumber* num, NSUInteger idx, BOOL *stop) {
            if([num isKindOfClass:[NSNumber class]])
                if(max.doubleValue < num.doubleValue)
                    max = num;
        }];
        return max;
    };
}

- (NSNumber *(^)(void))arrMinNumber
{
    return ^id(){
        LinkHandle_REF(NSArray)
        LinkGroupHandle_REF(arrMinNumber)
        __block NSNumber* min = _self[0];
        [_self enumerateObjectsUsingBlock:^(NSNumber* num, NSUInteger idx, BOOL *stop) {
            if([num isKindOfClass:[NSNumber class]])
                if(min.doubleValue > num.doubleValue)
                    min = num;
        }];
        return min;
    };
}

+ (BOOL)classIsFoundation
{return [self lb_classIsBasic];}

+ (BOOL)classContainProperty:(NSString*)property
{return [self lb_classContainProperty:property];}

+ (BOOL)classContainIvar:(NSString*)ivarName
{return [self lb_classContainIvar:ivarName];}

+ (NSString*)classGetPropertyType:(NSString*)key
{return [self lb_classGetPropertyType:key];}

+ (NSArray<NSString*>*)classGetAllPropertyList:(BOOL)b
{return [self lb_classGetAllPropertyList:b];}

+ (void)classEnumerateUsingBlock:(void(^)(Class clazz , BOOL* stop))block
               includeFoundation:(BOOL)b
{
    [self lb_classEnumerateUsingBlock:block includeBasic:b];
}
+ (void)classPropertysEnumerateUsingBlock:(void(^)(Class clazz,NSString* propertyName,NSString* propertyType,BOOL* stop))block includeFoundation:(BOOL)b
{
    [self lb_classPropertysEnumerateUsingBlock:block includeBasic:b];
}

//- (BOOL (^)(NSAttributedString *))attr_strIsEqualToAttrStr
//{
//    return ^(NSAttributedString* attrStr){
//        LinkHandle_VAL_IFNOT(NSAttributedString){
//            return NO;
//        }
//        LinkGroupHandle_VAL(attr_strIsEqualToAttrStr,attrStr)
//        return [_self isEqualToAttributedString:attrStr];
//    };
//}
//
//- (NSNumber* (^)(NSAttributedString *))attr_strIsEqualToAttrStrAs
//{
//    return ^id(NSAttributedString* attrStr){
//        LinkHandle_REF(NSAttributedString)
//        LinkGroupHandle_REF(attr_strIsEqualToAttrStrAs,attrStr)
//        return @([_self isEqualToAttributedString:attrStr]);
//    };
//}
@end
