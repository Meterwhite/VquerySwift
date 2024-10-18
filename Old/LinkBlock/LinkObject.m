//
//  LinkObject.m
//  LinkBlockProgram
//
//  Created by Novo on 2018/10/18.
//  Copyright © 2018 Novo. All rights reserved.
//

#import "LinkBlock.h"
#import <objc/runtime.h>
//#import <CoreData/CoreData.h>
#import "DynamicLink.h"
#import "LinkHelper.h"
#import "LinkBlockInvocation.h"
#import "NSNil.h"

@implementation NSObject(LinkObject)

- (NSObject *)makeLinkObjs
{
    LinkHandle_REF(NSArray)
    
    if([self isKindOfClass:[LinkGroup class]])
        return self;
    
    return [LinkGroup groupWithArr:_self];
}


- (id)linkEnd
{
    if([self isKindOfClass:[LinkInfo class]]){
        
        if([self isKindOfClass:[LinkError class]]){
            
            ((LinkError*)self).throwCount++;
            [(LinkError*)self logError];
            return nil;
        }else if([self isKindOfClass:[LinkGroup class]]){
            
            return [[(self.thisLinkObjs).linkObjects firstObject] linkEnd];
        }else if ([self isKindOfClass:[LinkReturn class]]){
            
            return [[(LinkReturn*)self returnValue] linkEnd];
        }
    }
    return self==NSNull.null ? nil : self;
}


- (NSObject *(^)(NSUInteger, void (^)(NSObject *, NSUInteger)))linkLoop
{
    return ^id(NSUInteger count,void(^block)(NSObject* loopObject,NSUInteger idx)){
        
        LinkHandle_REF(NSObject)
        
        if([self isKindOfClass:[LinkGroup class]]){
            [self.thisLinkObjs.linkObjects enumerateObjectsUsingBlock:^(NSObject*loopObject, NSUInteger idx, BOOL* stop) {
                for (int i=0; i<count; i++) {
                    block(loopObject,i);
                }
            }];
            return self;
        }
        
        for (int i=0; i<count; i++) {
            block(_self,i);
        }
        return self;
    };
}


- (NSArray* )linkEnds
{
    if([self isKindOfClass:[LinkInfo class]]){
        if([self isKindOfClass:[LinkError class]]){
            
            ((LinkError*)self).throwCount++;
            [(LinkError*)self logError];
            return nil;
        }else if([self isKindOfClass:[LinkGroup class]]){
            
            return [self.thisLinkObjs.linkObjects copy];
        }else if ([self isKindOfClass:[LinkReturn class]]){
            
            NSObject* retValue = ((LinkReturn*)self).returnValue;
            if([retValue isKindOfClass:[LinkGroup class]]){
                return retValue.linkEnds;
            }
            return [NSArray arrayWithObject:retValue];
        }
    }
    return [NSArray arrayWithObject:self];
}

- (id (^)(NSUInteger))linkEndsAt
{
    return ^id(NSUInteger idx){
        
        if([self isKindOfClass:[LinkInfo class]]){
            if([self isKindOfClass:[LinkError class]]){
                
                ((LinkError*)self).throwCount++;
                [(LinkError*)self logError];
                return nil;
            }else if([self isKindOfClass:[LinkGroup class]]){
                
                if(idx < self.thisLinkObjs.linkObjects.count){
                    return [self.thisLinkObjs.linkObjects[idx] linkEnd];
                }
                return nil;
            }else if ([self isKindOfClass:[LinkReturn class]]){
                
                LinkGroup* group = ((LinkReturn*)self).returnValue;
                if([group isKindOfClass:[LinkGroup class]]){
                    
                    if(idx < group.linkObjects.count){
                        return [group.linkObjects[idx] linkEnd];
                    }
                    return nil;
                }
            }
        }
        return self;
    };
}



- (NSObject *(^)(id))linkPush
{
    return ^id(id obj){
        LinkHandle_REF(NSObject)
        
        if([self isKindOfClass:[LinkGroup class]]){
            [self.thisLinkObjs.linkObjects addObject:obj];
            return self;
        }
        return [LinkGroup groupWithObjs:_self,obj,nil];
    };
}


- (NSObject *(^)(void))linkPop
{
    return ^id(){
        LinkHandle_REF(NSObject)
        if([self isKindOfClass:[LinkGroup class]]){
            
            [self.thisLinkObjs.linkObjects removeLastObject];
            return self;
        }
        return self;
    };
}


- (NSObject *(^)(NSUInteger))linkAt
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSObject)
        if([_self isKindOfClass:[LinkGroup class]]){
            if(idx>self.thisLinkObjs.linkObjects.count-1) return self;
            return self.thisLinkObjs.linkObjects[idx];
        }
        return _self;
    };
}


-  (NSObject *(^)(NSString *, ...))linkSelect
{
    return ^id(NSString *predicateStr,...){
        
        LinkHandle_REF(NSObject)
        LinkGroup* group = self.thisLinkObjs;
        if([_self isKindOfClass:[LinkGroup class]]){
            
            if(group.linkObjects.count) return self;
            
            va_list args;
            va_start(args, predicateStr);
            NSPredicate* pred= [NSPredicate predicateWithFormat:predicateStr arguments:args];
            va_end(args);
            [group.linkObjects filterUsingPredicate:pred];
        }
        return self;
    };
}


- (NSObject *(^)(BOOL))linkIf
{
    return ^id(BOOL condition){
        
        if([self isKindOfClass:[LinkInfo class]]){
            if([(LinkError*)self infoType] == LinkInfoError){
                //LinkError just return.
                ((LinkError*)self).throwCount++;
            }else if([(LinkReturn*)self infoType] == LinkInfoReturn){
                
                if([(LinkReturn*)self returnType] == LinkReturnCondition && condition ==YES){
                    //linkIf...linkIf is allowed.
                    if(((LinkReturn*)self).condition == LinkConditionIF){
                        return [(LinkReturn*)self returnValue];
                    }
                }
                //Here is force interrupt,just return it.
            }
            return self;
        }
        
        LinkGroupHandle_REF(linkIf,condition)
        //Case no means next block would not be execute until linkElse.
        if(condition == NO){
            return [[LinkReturn alloc] initWithReturnValue:self returnType:LinkReturnCondition];
        }
        //Do noting for normal object
        return self;
    };
}

- (NSObject *)linkElse
{
    if([self isKindOfClass:[LinkInfo class]]){
        if(((LinkError*)self).infoType == LinkInfoError){
            //LinkError just return.
            ((LinkError*)self).throwCount++;
        }else if(((LinkReturn*)self).infoType == LinkInfoReturn){
            
            if([(LinkReturn*)self returnType] == LinkReturnCondition){
                //DO noting if linkElse is before here.
                if([(LinkReturn*)self condition] == LinkConditionIF){
                    return ((LinkReturn*)self).returnValue;
                }
            }
        }
        return self;
    }
    if([self isKindOfClass:[LinkGroup class]]){
        
        LinkGroup* group = self.thisLinkObjs;
        NSMutableArray* desLinkReturnItems = [NSMutableArray new];
        for (int i=0; i<group.linkObjects.count; i++) {
            ///Execute linkElse on each item.
            [desLinkReturnItems addObject:group.linkObjects[i].linkElse];
        }
        [group.linkObjects setArray:desLinkReturnItems];
        return group;
    }
    
    //Next normal block will not be execute until other link-condition!
    return [[LinkReturn alloc] initWithReturnValue:self returnType:LinkReturnCondition conditionType:LinkConditionELSE];
}

- (NSObject *)linkReturn
{
    if([self isKindOfClass:[LinkInfo class]]){
        if(((LinkError*)self).infoType == LinkInfoError){
            //LinkError just return.
            ((LinkError*)self).throwCount++;
            return self;
        }else if(((LinkReturn*)self).infoType == LinkInfoReturn){
            
            switch ([(LinkReturn*)self returnType]) {
                case LinkReturnLink:
                    return self;
                case LinkReturnCondition:
                {
                    ((LinkReturn*)self).returnType = LinkReturnLink;
                    [self setValue:@(LinkConditionNon) forKey:@"condition"];
                    return self;
                }
                default:
                    return self;
            }
        }
    }
    if([self isKindOfClass:[LinkGroup class]]){
        LinkGroup* group = self.thisLinkObjs;
        NSMutableArray* returnObjs = [NSMutableArray new];
        for (int i=0; i<group.linkObjects.count; i++) {
            id re = group.linkObjects[i].linkReturn;
            [returnObjs addObject:re];
        }
        [group.linkObjects setArray:returnObjs];
        return group;
    }
    return [[LinkReturn alloc] initWithReturnValue:self returnType:LinkReturnLink];
}



- (NSObject *)linkIf_YES
{
    if([self isKindOfClass:[LinkInfo class]]){
        if([(LinkError*)self infoType] == LinkInfoError){
            //LinkError just return.
            ((LinkError*)self).throwCount++;
            return self;
        }else if([(LinkReturn*)self infoType] == LinkInfoReturn){
            
            switch ([(LinkReturn*)self returnType]) {
                case LinkReturnLink:
                    return self;//Here Force interrupt
                case LinkReturnCondition:
                {
                    
                    if(((LinkReturn*)self).condition == LinkConditionIF){
                        
                        //Try restore the state,is case @YES,!NSNull
                        id linkObj = ((LinkReturn*)self).returnValue;
                        if(
                           linkObj != NSNull.null
                           ||
                           ([linkObj isKindOfClass:[NSNumber class]] && [linkObj boolValue]==YES)
                           ){
                            return linkObj;
                        }
                    }
                }
                default:
                    return self;
            }
        }
        return self;
    }
    ////////////////////
    ///LinkGroupHandle
    ////////////////////
    if([self isKindOfClass:[LinkGroup class]]){
        LinkGroup* group = self.thisLinkObjs;
        NSMutableArray* desLinkReturnItems = [NSMutableArray new];
        for (int i=0; i<group.linkObjects.count; i++) {
            //Execute linkIf_YES on each item;
            [desLinkReturnItems addObject:group.linkObjects[i].linkIf_YES];
        }
        [group.linkObjects setArray:desLinkReturnItems];
        return group;
    }
    
    if(
       self != NSNull.null
       ||
       ([self isKindOfClass:[NSNumber class]] && [(NSNumber*)self boolValue]==YES)
       ){
        //Case {@YES,!NSNull}
        return self;
    }
    //{@NO,NSNull} next block would not be execute until other link-condition.
    return [[LinkReturn alloc] initWithReturnValue:self returnType:LinkReturnCondition];
}

- (NSObject *)linkIf_NO
{
    if([self isKindOfClass:[LinkInfo class]]){
        if([(LinkError*)self infoType] == LinkInfoError){
            
            ((LinkError*)self).throwCount++;
            return self;
        }else if([(LinkReturn*)self infoType] == LinkInfoReturn){//中断时
            
            switch ([(LinkReturn*)self returnType]) {
                case LinkReturnLink:
                    return self;
                case LinkReturnCondition:
                {
                    
                    if(((LinkReturn*)self).condition == LinkConditionIF){
                        
                        id linkObj = [(LinkReturn*)self returnValue];
                        //Try restore the state,is case @NO,NSNull
                        if(
                           linkObj == NSNull.null
                           ||
                           ([linkObj isKindOfClass:[NSNumber class]] && ![linkObj boolValue])
                           ){
                            return linkObj;
                        }
                    }
                }
                default:
                    return self;
            }
        }
        return self;
    }
    ////////////////////
    ///LinkGroupHandle
    ////////////////////
    if([self isKindOfClass:[LinkGroup class]]){
        LinkGroup* group = self.thisLinkObjs;
        NSMutableArray* desLinkReturnItems = [NSMutableArray new];
        for (int i=0; i<group.linkObjects.count; i++) {
            
            [desLinkReturnItems addObject:group.linkObjects[i].linkIf_NO];
        }
        [group.linkObjects setArray:desLinkReturnItems];
        return group;
    }
    
    if(
       self == NSNull.null
        ||
       ([self isKindOfClass:[NSNumber class]] && !([(NSNumber*)self boolValue]==NO))
       ){
        return self;
    }
    return [[LinkReturn alloc] initWithReturnValue:self returnType:LinkReturnCondition];
}

- (NSObject *)linkIfNull
{
    return self.linkIf_NO;
}

- (NSObject *)linkIfNonNull
{
    return self.linkIf_YES;
}


- (NSObject *(^)(NSString *, ...))linkEvalCode
{
    return ^id(NSString* code, ...){
        LinkHandle_REF(NSObject)
        
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            va_list args;
            va_start(args, code);
            for (int i=0; i<group.linkObjects.count; i++) {
                DynamicLink* link = [DynamicLink dynamicLinkWithCode:code];
                id result = [link invoke:_self args:&args];
                [returnObjs addObject:result];
            }
            va_end(args);
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        va_list args;
        va_start(args , code);
        DynamicLink* link = [DynamicLink dynamicLinkWithCode:code];
        id result = [link invoke:_self args:&args];
        va_end(args);
        
        return result;
    };
}

- (NSObject *(^)(id , ...))linkCodeEval
{
    return ^id(id obj, ...){
        LinkHandle_REF(NSString)
        
        ///////////////////////
        //LinkGroupHandle_REF
        if([self isKindOfClass:[LinkGroup class]]){
            LinkGroup* group = self.thisLinkObjs;
            NSMutableArray* returnObjs = [NSMutableArray new];
            va_list args;
            va_start(args, obj);
            for (int i=0; i<group.linkObjects.count; i++) {
                DynamicLink* link = [DynamicLink dynamicLinkWithCode:_self];
                id result = [link invoke:obj args:&args];
                [returnObjs addObject:result];
            }
            va_end(args);
            [group.linkObjects setArray:returnObjs];
            return group;
        }
        //LinkGroupHandle_VAL
        ///////////////////////
        
        va_list vList;
        va_start(vList , obj);
        DynamicLink* link = [DynamicLink dynamicLinkWithCode:_self];
        id result = [link invoke:obj args:&vList];
        va_end(vList);
        
        return result;
    };
}




#pragma mark - 类型转换

#ifndef LBMarcoLinkTransType
#define LBMarcoLinkTransType(ReType) \
- (ReType *)as##ReType \
{ \
return (id)self; \
}
#endif

LBMarcoLinkTransType(NSString)
LBMarcoLinkTransType(NSMutableString)
LBMarcoLinkTransType(NSArray)
LBMarcoLinkTransType(NSMutableArray)
LBMarcoLinkTransType(NSDictionary)
LBMarcoLinkTransType(NSMutableDictionary)
LBMarcoLinkTransType(NSAttributedString)
LBMarcoLinkTransType(NSMutableAttributedString)
LBMarcoLinkTransType(NSURL)
LBMarcoLinkTransType(NSUserDefaults)
LBMarcoLinkTransType(NSNumber)
LBMarcoLinkTransType(NSValue)
LBMarcoLinkTransType(NSDate)
LBMarcoLinkTransType(NSData)
LBMarcoLinkTransType(NSOrderedSet)
LBMarcoLinkTransType(NSMutableOrderedSet)
LBMarcoLinkTransType(NSHashTable)
LBMarcoLinkTransType(NSMapTable)
LBMarcoLinkTransType(NSIndexPath)
LBMarcoLinkTransType(NSIndexSet)
LBMarcoLinkTransType(NSMutableSet)
LBMarcoLinkTransType(NSSet)
LBMarcoLinkTransType(NSCalendar)

LBMarcoLinkTransType(UIView)
LBMarcoLinkTransType(UILabel)
LBMarcoLinkTransType(UIControl)
LBMarcoLinkTransType(UIButton)
LBMarcoLinkTransType(UIScrollView)
LBMarcoLinkTransType(UIImage)
LBMarcoLinkTransType(UIColor)
LBMarcoLinkTransType(UIViewController)
LBMarcoLinkTransType(UIImageView)
LBMarcoLinkTransType(UITableView)
LBMarcoLinkTransType(UITextField)
LBMarcoLinkTransType(UITextView)
LBMarcoLinkTransType(UIWebView)

LBMarcoLinkTransType(CALayer)



#ifndef LB_Indicate
#define LB_Indicate(func)\
- (id)func\
{\
return self;\
}
#endif

LB_Indicate(whatSet)
LB_Indicate(thisLinkObj)
LB_Indicate(thisLinkObjs)
LB_Indicate(thisValue)
LB_Indicate(thisValues)

LB_Indicate(thisNumber)
LB_Indicate(aBOOLValue)
LB_Indicate(aFloatNumber)
LB_Indicate(aDoubleNumber)
LB_Indicate(anIntNumber)
LB_Indicate(anIntegerNumber)
LB_Indicate(anUnsignedIntNumber)
LB_Indicate(anUnsignedIntegerNumber)
LB_Indicate(aLongNumber)
LB_Indicate(aLongLongNumber)
LB_Indicate(aUnsignedLongNumber)
LB_Indicate(aUnsignedLongLongNumber)
LB_Indicate(aCGRectValue)
LB_Indicate(aCGSizeValue)
LB_Indicate(aCGPointValue)
LB_Indicate(aNSRangeValue)



@end
