//
//  LinkObject.h
//  LinkBlockProgram
//
//  Created by Novo on 2018/10/18.
//  Copyright © 2018 Novo. All rights reserved.
//

#import "LinkBlockDefine.h"
#import "LinkInfo.h"
#import "LinkGroup.h"
#import "LinkError.h"
#import "LinkReturn.h"
#import "Others+LinkBlock.h"


@interface NSObject(LinkObject)
#pragma mark ----NSArray----
/**
 self ∈ {_kindof NSArray}
 */
@property LB_FN NSObject*      makeLinkObjs;


#pragma mark ----NSObject----
@property LB_FN id             linkEnd;
/** Repeat execute the code using block. */
@property LB_BK NSObject*      (^linkLoop)(NSUInteger count,void(^)(NSObject* loopObject,NSUInteger idx));


@property LB_FN NSArray*       linkEnds;
@property LB_BK id             (^linkEndsAt)(NSUInteger idx);
@property LB_BK NSObject*      (^linkPush)(id obj);
@property LB_BK NSObject*      (^linkPop)(void);
@property LB_BK NSObject*      (^linkAt)(NSUInteger idx);
@property LB_BK NSObject*      (^linkSelect)(NSString* predicate,...);


@property LB_BK NSObject*      (^linkIf)(BOOL condition);
/** This block must behind `linkIf`*/
@property LB_FN NSObject*      linkElse;
/** After `linkReturn` no block can be executed; */
@property LB_FN NSObject*      linkReturn;
/** `YES` means @YES or !NSNull */
@property LB_FN NSObject*      linkIf_YES;
/** `NO` means @NO or NSNull */
@property LB_FN NSObject*      linkIf_NO;
/** `Null` means @NO or NSNull.It is the same as linkIf_NO */
@property LB_FN NSObject*      linkIfNull;
/** `NonNull` means @YES or !NSNull.It is the same as linkIf_YES */
@property LB_FN NSObject*      linkIfNonNull;


/**
 DynamicLink
 Parameters end with "nil,NSNotFond" indicate that it for structValue.
 :
 object.linkEvalCode(@"block0()...");
 */
@property LB_BK NSObject*     (^linkEvalCode)(NSString* script , ...);



/**
 MARK: Link Indicate/链条指示
 *******************
 When linkBlock object has changed,use this block to draw attention.
 Link Indicate will do noting, it just return self.
 *******************
 */

/**
 ...linkBlockRerutn<AsWhatSet>(parameterToSet).whatSet...;
 If linkBlock return value is parameters of itself ,it has suffix 'AsWhatSet'.
 Use `whatSet` to indicate that next linkObj is the parameters of previous linkObj.
 */
@property LB_FN NSObject*      whatSet;

/**
 指示链条的类型
 Use `thisLinkObjs`,`thisLinkObj` to indicate state of link.
 ...linkPush(~).linkPush(~).thisLinkObjs...
 */
@property LB_FN LinkGroup*     thisLinkObjs;
/** Use `thisLinkObjs`,`thisLinkObj` to indicate state of link. */
@property LB_FN NSObject*      thisLinkObj;

/**
 指示链条对象变更
 Use `thisValue`,`thisValues`,`thisNumber` to indicate that linkBlock object has changed.
 */
@property LB_FN NSObject*      thisValue;
/** indicate that linkBlock object has changed. */
@property LB_FN NSObject*      thisValues;
/** indicate that linkBlock object has changed. */
@property LB_FN NSNumber*      thisNumber;

/**
 指示NSNumber类型
 ...linkBlockRerutnANumber<As>().<aBOOLValue>...;
 All linkBlock return NSNumber value it has suffix 'As'.
 Use block named `a+TypeObject` to draw attention.
 */
@property LB_FN NSNumber*      aBOOLValue;
@property LB_FN NSNumber*      aFloatNumber;
@property LB_FN NSNumber*      aDoubleNumber;
@property LB_FN NSNumber*      anIntNumber;
@property LB_FN NSNumber*      anIntegerNumber;
@property LB_FN NSNumber*      anUnsignedIntNumber;
@property LB_FN NSNumber*      anUnsignedIntegerNumber;
@property LB_FN NSNumber*      aLongNumber;
@property LB_FN NSNumber*      aLongLongNumber;
@property LB_FN NSNumber*      aUnsignedLongNumber;
@property LB_FN NSNumber*      aUnsignedLongLongNumber;
@property LB_FN NSValue*       aCGRectValue;
@property LB_FN NSValue*       aCGSizeValue;
@property LB_FN NSValue*       aCGPointValue;
@property LB_FN NSValue*       aNSRangeValue;

#pragma mark ----NSString----
/**
 DynamicLink
 Parameters end with "nil,NSNotFond" indicate that it for structValue.
 :
 scriptString.linkCodeEval(targetObject,argument...);
 */
@property LB_BK NSObject*      (^linkCodeEval)(id obj, ...);



#pragma mark - Force type declaration/强制类型声明
/**
 *******************
 Force type declaration will do noting
 *******************
 */
- (NSString*)                  asNSString;
- (NSMutableString*)           asNSMutableString;
- (NSArray*)                   asNSArray;
- (NSMutableArray*)            asNSMutableArray;
- (NSDictionary*)              asNSDictionary;
- (NSMutableDictionary*)       asNSMutableDictionary;
- (NSAttributedString*)        asNSAttributedString;
- (NSMutableAttributedString*) asNSMutableAttributedString;
- (NSURL*)                     asNSURL;
- (NSUserDefaults*)            asNSUserDefaults;
- (NSNumber*)                  asNSNumber;
- (NSValue*)                   asNSValue;
- (NSDate*)                    asNSDate;
- (NSData*)                    asNSData;
- (NSSet*)                     asNSSet;
- (NSMutableSet*)              asNSMutableSet;
- (NSCalendar*)                asNSCalendar;
- (NSOrderedSet*)              asNSOrderedSet;
- (NSMutableOrderedSet*)       asNSMutableOrderedSet;
- (NSHashTable*)               asNSHashTable;
- (NSMapTable*)                asNSMapTable;
- (NSIndexPath*)               asNSIndexPath;
- (NSIndexSet*)                asNSIndexSet;

- (UIView*)                    asUIView;
- (UIImage*)                   asUIImage;
- (UILabel*)                   asUILabel;
- (UIControl*)                 asUIControl;
- (UIButton*)                  asUIButton;
- (UIScrollView*)              asUIScrollView;
- (UIImageView*)               asUIImageView;
- (UITableView*)               asUITableView;
- (UIColor*)                   asUIColor;
- (UIViewController*)          asUIViewController;
- (UITextField*)               asUITextField;
- (UITextView*)                asUITextView;
- (UIWebView*)                 asUIWebView;

- (CALayer*)                   asCALayer;

@end


NS_INLINE id _LB_MakeObj(id object){
    return object?object:[LinkError new];
}
/**
 End with nil~!
 */
NS_INLINE LinkInfo* _LB_MakeObjs(id object0, ...){
    if(!object0) return [LinkError new];
    va_list args;
    va_start(args, object0);
    return [LinkGroup groupWithObjs:object0 args:args];
}

NS_INLINE id _LB_DefaultObj(id obj , id instead){
    return obj?obj:instead;
}

NS_INLINE id _LB_NotNilObj(id obj){
    return obj?obj:[NSNull null];
}
