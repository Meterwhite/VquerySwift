//
//  LinkBlock.h
//
//  Created by NOVO on 15/8/13.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkObject.h"

#import "NSURL+LinkBlock.h"
#import "NSDate+LinkBlock.h"
#import "NSValue+LinkBlock.h"
#import "NSError+LinkBlock.h"
#import "NSArray+LinkBlock.h"
#import "NSObject+LinkBlock.h"
#import "NSString+LinkBlock.h"
#import "NSNumber+LinkBlock.h"
#import "NSIndexPath+LinkBlock.h"
#import "NSPredicate+LinkBlock.h"
#import "NSDictionary+LinkBlock.h"
#import "NSMutableArray+LinkBlock.h"
#import "NSMutableString+LinkBlock.h"
#import "NSAttributedString+LinkBlock.h"
#import "NSMutableDictionary+LinkBlock.h"
#import "NSMutableAttributedString+LinkBlock.h"

#import "JavaScriptCore+LinkBlock.h"

#import "UIFont+LinkBlock.h"
#import "UIView+LinkBlock.h"
#import "UIImage+LinkBlock.h"
#import "UILabel+LinkBlock.h"
#import "UIColor+LinkBlock.h"
#import "CALayer+LinkBlock.h"
#import "UIButton+LinkBlock.h"
#import "UIControl+LinkBlock.h"
#import "UIWebView+LinkBlock.h"
#import "UITextView+LinkBlock.h"
#import "UITextField+LinkBlock.h"
#import "UISearchBar+LinkBlock.h"
#import "UIImageView+LinkBlock.h"
#import "UITableView+LinkBlock.h"
#import "UIStackView+LinkBlock.h"
#import "UIBezierPath+LinkBlock.h"
#import "CAShapeLayer+LinkBlock.h"
#import "CAAnimations+LinkBlock.h"
#import "UIScrollView+LinkBlock.h"
#import "UITableViewCell+LinkBlock.h"
#import "UIViewController+LinkBlock.h"

//////////////////////////
//MARK:Basic
//////////////////////////

/**
 *  安全的链条
 *  Create linkObject.Make a safe object for link.
 */
#define linkObj(object) \
    \
    ((typeof(object))_LB_MakeObj(object))

/**
 *  ~ = linkObj...linkEnd;
 *  1.Used to get return value when needed.
 *  2.convert <LinkError || NSNull> to nil.
 */
#define linkEnd linkEnd

///For type of id
#define linkObj_id(object)  \
    \
    ((NSObject*)_LB_MakeObj(object))

//////////////////////////////////
//MARK:link objects/多对象的链条
//////////////////////////////////

/**
 * linkObjs(a,b,c...)
 *  安全的多对象的链条
 *  Craete link objects.Each one should not be nil.
 */
#define linkObjs(object,args...)    \
    \
    (_LB_MakeObjs(object,##args,nil))

/**
 <NSArray>.makeLinkObjs = linkObjs(...)
 as well as linkObjs/等同于linkObjs
 */
#define makeLinkObjs makeLinkObjs
/**
 Add a new into link objects
 ...linkPush(object)
 */
#define linkPush linkPush
/**
 Remove last object at specified index from link objects
 ...linkPop()
 */
#define linkPop linkPop

/**
 Fileter link objects.
 ...linkSelect(@"age > %@",age);
 */
#define linkSelect linkSelect

/**
 *  重复执行
 *  Repeat the following link code by copy link objects
 *  ...linkLoop(count)...
 */
#define linkLoop linkLoop
/**
 *  ~ = linkObjs......linkEnds;
 *  1.used to get return values for link objects.
 *  2.convert <LinkError||NSNull> to nil.
 */
#define linkEnds linkEnds
/**
 *  1.used to get a return value of link objects at specified index.
 *  2.convert <LinkError||NSNull> to nil.
 *  ~ = linkObjs...linkEndsAt(index);
 */
#define linkEndsAt linkEndsAt

///////////////////////////////////
//MARK:Link Condition/简单条件
///////////////////////////////////
/**
 Get linkObj from linkObjs and return it as next linkObj.
 ...linkAt(~)...
 */
#define linkAt linkAt
/**
 *  if-else in link
 *  :
 *  ...<linkIf(~)...>...<LinkElse...linkIf(~)...linkIf(~...)>
 *  `linkElse` has a higher priority.If execute <A> means that <B> would not be execut;
 */
#define linkIf linkIf
/** Refer to : linkIf */
#define linkElse linkElse
/** It is similar to linkIf.`YES` means @YES or !NSNull */
#define linkIf_YES linkIf_YES
/** It is similar to linkIf.`NO` means @NO or NSNull */
#define linkIf_NO linkIf_NO
/** It is similar to linkIf.`Null` means @NO or NSNull.It is the same as linkIf_NO */
#define linkIfNull linkIfNull
/** It is similar to linkIf.`NonNull` means @YES or !NSNull.It is the same as linkIf_YES */
#define linkIfNonNull linkIfNonNull

/**
 Return value immediately.Following block would not be execute.
 Then use `linkEnd` to get the result.
 id getValue = ...linkReturn...linkEnd;
 */
#define linkReturn linkReturn

/////////////////////////////////
//MARK: Link Indicate/链条指示
//Refer to `NSObject+LinkBlock.h`
/////////////////////////////////
#define whatSet                     whatSet
#define thisLinkObjs                thisLinkObjs
#define thisLinkObj                 thisLinkObj
#define thisValue                   thisValue
#define thisValues                  thisValues
#define thisNumber                  thisNumber
#define aBOOLValue                  aBOOLValue
#define aFloatNumber                aFloatNumber
#define aDoubleNumber               aDoubleNumber
#define anIntNumber                 anIntNumber
#define anIntegerNumber             anIntegerNumber
#define anUnsignedIntNumber         anUnsignedIntNumber
#define anUnsignedIntegerNumber     anUnsignedIntegerNumber
#define aLongNumber                 aLongNumber
#define aLongLongNumber             aLongLongNumber
#define aUnsignedLongNumber         aUnsignedLongNumber
#define aUnsignedLongLongNumber     aUnsignedLongLongNumber
#define aCGRectValue                aCGRectValue
#define aCGSizeValue                aCGSizeValue
#define aCGPointValue               aCGPointValue
#define aNSRangeValue               aNSRangeValue

////////////////////////////////////////////////
//MARK:Experimental DynamicLink/脚本解析-实验性
////////////////////////////////////////////////
/*
 *  DynamicLink/脚本解析:
 *  script.linkCodeEval(targetObject,argumentList....);
 *
 *
 *  DynamicLink used like linkBlock
 *  1."...actionName()..."The actionName wiil called as linkBlock
 *  2."...actionName...".The actionName will called as property > non-argument method > LinkBlock command
 
 *  LinkBlock command/命令:
 *  1.CreateCommand:"ClassName+New";
 *  2.LinkBlock macros,like 'NSNil','AttrDictNew'
 *
 *  note:DynamicLink did not suport the function that use argument list.If do it,system will recive only one agument,This will cause potential differences./不支持不定参数方法，否则只接收一个参数
 *
 *
 *  direct value/直接量：
 *  direct value used in '()'.Like:"actionName(3.1415926)"
 *  suport types:number||HexNumber,String,Boolean,c string,char,NSNumber,SEL,struct in NSValue,Class;
 *  Reference:DynamicLinkArgument.h
 *
 *  note:1.If set actionName or func as direct value,it must be non-argument func/方法的直接量必须是无惨的
 *  2.cannot have double quotes in a string/字符串中不再用双引号
 *
 *
 *  Entry order/入参顺序:
 *  One-to-one correspondence/一一对应关系
 *  script:"actionName($0 , 3.14 , $1)" => argument list:($0 , $1)
 *  Only suport set arguments to outer layer,to inner layer func should use direct value.
 *  In argument list use NSNil instead nil,or use direct value nil or NULL in script
 *
 *  return type:In dynamicLink all return type has been boxed./所有返回值都是装箱的
 */


/**
 *  execute script from any object and return value.
 *  anyObject.linkEvalCode(code , arg0 , arg1 , ...)
 *  note:any return value has been boxed
 */
#define linkEvalCode(code , args...)    \
    \
    linkEvalCode(code , ##args, nil, NSNotFound)

/**
 *  execute script with an object and return value.
 *  code.linkCodeEval( target , arg0 , arg1 , ...)
 *  note:any return value has been boxed
 */
#define linkCodeEval(obj , args...) \
    \
    linkCodeEval(obj, ##args, nil, NSNotFound)

/**
 *  only execute script and return value.
 *  EvalLinkBlock(script)
 *  note:any return value has been boxed
 */
#define EvalLinkBlock(code) \
    \
    (linkObj_id(code).linkCodeEval(NSNil, nil))
/**
 *  only execute script by a target object and return value.
 *  EvalLinkBlockWithTarget(target ,script)
 *  note:any return value has been boxed
 */
#define EvalLinkBlockWithTarget(target,code)    \
    \
    (linkObj_id(code).linkCodeEval(linkObj(target) , nil))



//////////////////////////////
//MARK: Configuration/配置
//////////////////////////////
/** Close the warning */
#define LinkBlockWarningClose   \
    \
    ([LinkInfo linkBlockWarningClose])

/** Allow warning (default) */
#define LinkBlockWarningOpen    \
    \
    ([LinkInfo linkBlockWarningOpen])

//////////////////////////////////
//MARK: Other function
/////////////////////////////////
/** Default value for object */
#define linkObjDefault(object,default)  \
    \
    ((typeof(object))_LB_DefaultObj(object,default))

#define linkObjNotNil(object)   \
    \
    ((typeof(object))_LB_NotNilObj(object))

#define objIsEqualToEach(obj, args...)  \
    \
    objIsEqualToEach(obj,##args,nil)

#define objIsEqualToEachAs(obj, args...)    \
    \
    objIsEqualToEachAs(obj,##args,nil)

#define objIsEqualToSomeone(obj, args...)   \
    \
    objIsEqualToSomeone(obj,##args,nil)

#define objIsEqualToSomeoneAs(obj, args...) \
    \
    objIsEqualToSomeoneAs(obj,##args,nil)

#define strAppendFormat(formatStr, args...) \
    \
    strAppendFormat(formatStr , ##args , nil)

#define numIsEqualToNum(...)    \
    \
    numIsEqualToNum(LBBoxValue((__VA_ARGS__)))

#define numIsEqualToNumAs(...)  \
    \
    numIsEqualToNumAs(LBBoxValue((__VA_ARGS__)))

#define numIsGreatThan(...) \
    \
    numIsGreatThanNum(LBBoxValue((__VA_ARGS__)))

#define numIsGreatThanNumAs(...)    \
    \
    numIsGreatThanNumAs(LBBoxValue((__VA_ARGS__)))

#define numIsGreatEqualNum(...) \
    \
    numIsGreatEqualNum(LBBoxValue((__VA_ARGS__)))

#define numIsGreatEqualNumAs(...)   \
    \
    numIsGreatEqualNumAs(__VA_ARGS__)

#define numIsLessThanNum(...)   \
    \
    numIsLessThanNum(LBBoxValue((__VA_ARGS__)))

#define numIsLessThanNumAs(...) \
    \
    numIsLessThanNumAs(LBBoxValue((__VA_ARGS__)))


#define numIsLessEqualNum(...)  \
    \
    numIsLessEqualNum(LBBoxValue((__VA_ARGS__)))

#define numIsLessEqualNumAs(...)    \
    \
    numIsLessEqualNumAs(LBBoxValue((__VA_ARGS__)))

#define objPerformSelectors(sel , args...)  \
    \
    objPerformSelectors(sel, ##args , nil)


#define objPerformsSelectorArguments(sel0,args0,args...)    \
    \
    objPerformsSelectorArguments(sel0,args0,##args,nil)

#define objPerformSelectorsAsWhatReturns(sel,args...)   \
    \
    objPerformSelectorsAsWhatReturns(sel,##args,nil)

#define objPerformsSelectorArgumentsAsWhatReturns(sel0,arg0,args...)    \
    \
    objPerformsSelectorArgumentsAsWhatReturns(sel0,arg0,##args,nil)

#define viewAddSubviews(view0,args...)  \
    \
    viewAddSubviews(view0,##args,nil)
