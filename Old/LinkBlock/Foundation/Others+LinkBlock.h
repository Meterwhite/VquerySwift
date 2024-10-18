//
//  Others+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/10/1.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"
/**
 Each change is retained for 6 months.
 The dprecated method more than 6 months will be deleted!
 */
@interface NSObject(OtherLinkBlock)
@property LB_BKG(arrContains) BOOL (^arrIsContainer)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to arrContain");

@property LB_BKG(attr_strDrawToImageAsWhatSet) UIImage* (^attr_strDrawImgRect)(UIImage* image, CGRect rect)
NS_DEPRECATED_IOS(2_0, 2_0, "use attr_strDrawToImgAsWhatSet instead");

@property LB_BK NSObject*    (^objValueRandom)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "use objSetRandom... instead");

@property LB_BK NSObject*    (^objSetDelegate)(id delegate)
NS_DEPRECATED_IOS(2_0, 2_0, "use objSetValueForKdelegate instead");

@property LB_BK UIImage*         (^imgBlur)(float percent)
NS_DEPRECATED_IOS(2_0, 2_0, "use imgBlurXXX instead");

@property LB_BK NSMutableArray*  (^arrInsertBehind)(id obj, id behindObj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrInsertNext");

@property LB_BKG(viewClipsToBounds) UIView*(^viewMasksToBounds)(BOOL b)
NS_DEPRECATED_IOS(2_0, 2_0, "use viewClipsToBounds instead");

@property LB_BK NSObject*    (^nslogTitle)(NSString* title)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(poDetail) NSObject*    (^poNoDeep)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "use po() instead；dol po() rename to poDetail()");

@property LB_BK NSObject*    (^logInfo)(NSString* info)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(strUILinesCount) NSInteger    (^strLinesCountAboutView)(CGFloat maxWidth,NSDictionary<NSAttributedStringKey,id>* attrDict)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to strUILinesCount");

@property LB_BKG(strSubToUILine) NSString*    (^strSubToLineAboutView)(NSInteger toLine, CGFloat maxWidth,NSDictionary<NSAttributedStringKey,id>* attrDict)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to strSubToUILine");

@property LB_BKG(strSubRangeToMaxUILineIfAppendStr) NSRange (^strSubRangeToMaxLineIfAppendStrAboutView )(NSUInteger maxLine , CGFloat maxWidth, NSString* ifAppendStr ,NSDictionary<NSAttributedStringKey,id>* attrDict , BOOL* isFullOfLines)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to strSubRangeToMaxUILineIfAppendStr");

@property LB_BK NSValue* (^valueCGSizeSetToViews)(NSArray* views)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BK NSValue* (^valueCGPointSetToViews)(NSArray* views)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(viewSetFrameVal) UIView*      (^viewSetFrameOfCGRect)(CGRect frame)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewSetFrameVal");

@property LB_BKG(viewSetOriginVal) UIView*      (^viewSetOriginOfCGPoint)(CGPoint origin)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewSetOriginVal");

@property LB_BKG(viewSetCenterVal) UIView*      (^viewSetCenterOfCGPoint)(CGPoint center)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewSetCenterVal");

@property LB_BKG(viewSetSizeVal) UIView*      (^viewSetSizeOfCGSize)(CGSize size)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewSetSizeVal");

@property LB_BKG(viewConvertSuperviewTo) UIView*      (^viewConvertSuperverTo)(UIView* aView , BOOL isKeep)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to viewConvertSuperviewTo");

@property LB_BKG(viewFindSubviewsOfClass) NSMutableArray*      (^viewFindSubviews)(Class clazz)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewFindSubviewsOfClass");

@property LB_BKG(m_strAppend) NSMutableString*(^m_strAppenStr)(NSString* str)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to m_strAppend");

@property LB_BKG(objIsMutable)  BOOL(^objIsMutableType)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to objIsMutable");

@property LB_BKG(m_strReplace) NSMutableString*     (^m_strReplaceStr)(NSString* replaceStr, NSString* withStr)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to m_strReplace");

@property LB_BKG(objMutableCopyEnumerate) NSObject*    (^objMutableCopyDeep)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to objMutableCopyEnumerate");

@property LB_BK NSObject*    (^objValuesRandom)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "use objSetRandom... instead");
@property LB_BKG(objSetAllValuesBlank) NSObject*    (^objValuesClean)(void);

@property LB_BK NSObject*    (^objMustType)(Class clazz)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSObject*    (^objAddToArr)(NSMutableArray* arr)
NS_DEPRECATED_IOS(2_0, 2_0, "can be instead");
@property LB_BK NSObject*    (^objRemoveFromArr)(NSMutableArray* arr)
NS_DEPRECATED_IOS(2_0, 2_0, "can be instead");
@property LB_BKG(objGetPrevItemFromObjs) NSObject*    (^objBeforeInArr)(NSArray* inArr)
NS_DEPRECATED_IOS(2_0, 2_0, "use objGetPrevItemFromObjs");
@property LB_BKG(objGetNextItemFromObjs) NSObject*    (^objNextInArr)(NSArray* inArr)
NS_DEPRECATED_IOS(2_0, 2_0, "use objGetNextItemFromObjs");
@property LB_BKG(objIsSubitemOfObjs) BOOL         (^objIsInArr)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use objIsSubitemOfObjs");
@property LB_BKG(objIsSubitemOfObjs) BOOL         (^objIsInDictValues)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use objIsSubitemOfObjs");
@property LB_BKG(objIsSubitemOfObjsAs) NSNumber*    (^objIsInDictValues_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use objIsSubitemOfObjsAs");
@property LB_BKG(objIsSubitemOfObjsAs) NSNumber*    (^objIsInArr_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use objIsSubitemOfObjsAs");
@property LB_BKG(objIsKeyOfObjs) BOOL         (^objIsInDictKeys)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use objIsKeyOfObjs");
@property LB_BKG(objIsKeyOfObjsAs) NSNumber*    (^objIsInDictKeys_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use objIsKeyOfObjsAs");

@property LB_BKG(objSetValueForKdelegate) NSObject*    (^objSetValueForKey_delegate)(id value)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to objSetValueForKdelegate");
@property LB_BKG(objSetValueForKdataSource) NSObject*    (^objSetValueForKey_dataSource)(id value)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to objSetValueForKdataSource");
@property LB_BKG(objSetValueForKtext) NSObject*    (^objSetValueForKey_text)(id value)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to objSetValueForKtext");

@property LB_BK NSObject*    (^objSetToDict)(NSMutableDictionary* dict, id<NSCopying> key)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(dateToStrAstrologyzh_CN) NSString*        (^dateAstrology)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to dateToStrAstrologyzh_CN");//

@property LB_BKG(objIsKindOfNSStringAs) NSNumber*    (^objIsKindOfNSString)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "Add suffix 'As':As");
@property LB_BKG(objIsKindOfNSArrayAs) NSNumber*    (^objIsKindOfNSArray)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "Add suffix 'As':As");
@property LB_BKG(objIsKindOfNSDictionaryAs) NSNumber*    (^objIsKindOfNSDictionary)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "Add suffix 'As':As");
@property LB_BKG(objIsKindOfUIViewAs) NSNumber*    (^objIsKindOfUIView)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "Add suffix 'As':As");
@property LB_BKG(objIsKindOfNSValueAs) NSNumber*    (^objIsKindOfNSValue)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "Add suffix 'As':As");
@property LB_BKG(objIsKindOfNSNumberAs) NSNumber*    (^objIsKindOfNSNumber)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "Add suffix 'As':As");

#pragma mark - subffix change
@property LB_BKG(attr_strSizeWithOptionsAs) NSValue* (^attr_strSizeWithOptions_n)(CGFloat maxWidth, NSStringDrawingOptions optoins)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(arrContainsIndexAs) NSNumber*                (^arrContainIndex_n)(NSUInteger idx)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(attr_strSizeAs) NSValue* (^attr_strSize_n)(CGFloat maxWidth)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsKindOfAs) NSNumber*    (^objIsKindOf_n)(Class clazz)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsSubClassOfAs) NSNumber*    (^objIsSubClassOf_n)(Class clazz)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsMemberOfClassAs) NSNumber*    (^objIsMemberOfClass_n)(Class clazz)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsRespondsSELAs) NSNumber*    (^objIsRespondsSEL_n)(SEL sel)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsEqualToEachAs) NSNumber*    (^objIsEqualToEach_n)(id obj,...)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsEqualToSomeoneAs) NSNumber*    (^objIsEqualToSomeone_n)(id obj,...)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strIszh_CNInRangeAs) NSNumber*    (^strIszh_CNInRange_n)(NSRange range)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strSizeWithFontAndMaxWidthAs) NSValue*     (^strSizeWithFontAndMaxWidth_n)(UIFont* font , CGFloat maxWidth)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strSizeWithFontAndMaxSizeAs) NSValue*     (^strSizeWithFontAndMaxSize_n)(UIFont* font, CGSize maxSize)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");

// one
@property LB_BKG(arrContainsAs) NSNumber*    (^arrContain_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "arrContainsAs");
@property LB_BKG(arrIndexOfObjAs) NSNumber*    (^arrIndexOfObj_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "arrIndexOfObjAs");
@property LB_BKG(dictGetBOOLAs) NSNumber*    (^dictGetBOOL_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsGreatThanNumAs) NSNumber*    (^numIsGreatThanNum_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsGreatEqualNumAs) NSNumber*    (^numIsGreatEqualNum_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsLessThanNumAs) NSNumber*    (^numIsLessThanNum_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsLessEqualNumAs) NSNumber*    (^numIsLessEqualNum_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsEqualAs) NSNumber*    (^objIsEqual_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsEqualToEachInArrayAs) NSNumber*    (^objIsEqualToEachInArray_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsEqualToSomeoneInArrayAs) NSNumber*    (^objIsEqualToSomeoneInArray_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strIsEqualStrAs) NSNumber*    (^strIsEqualStr_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strContainsAs) NSNumber*    (^strContain_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "strContainsAs");
@property LB_BKG(strSizeWithFontAs) NSValue*     (^strSizeWithFont_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strHasPrefixAs) NSNumber*    (^strHasPrefix_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "strHasPrefixAs");
@property LB_BKG(strHasSuffixAs) NSNumber*    (^strHasSuffix_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "strHasSuffixAs");
@property LB_BKG(strRegexIsMatchAs) NSNumber*    (^strRegexIsMatch_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "strRegexIsMatchAs");
@property LB_BKG(numAsIndexToGetValueFromObj) NSNumber*(^numIndexIsInStringRange_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use numAsIndexToGetValueFromObj");
@property LB_BKG(strPredicateEvaluateAs) NSNumber*    (^strPredicateEvaluate_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");

@property LB_BKG(arrContainsKeyValueAs) NSNumber*                (^arrKeyValueContain_n)(NSString* key,id eqValue)
NS_DEPRECATED_IOS(2_0, 2_0, "arrContainsKeyValueAs");


// none
@property LB_BKG(dateTimeIntervalSince1970As) NSNumber*(^dateTimeIntervalSince1970_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateYearAs) NSNumber*(^dateYear_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateMonthAs) NSNumber*(^dateMonth_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateDayAs) NSNumber*(^dateDay_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateHourAs) NSNumber*(^dateHour_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateMinutAs) NSNumber*(^dateMinut_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateSecAs) NSNumber*(^dateSec_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateIsLeapYearAs) NSNumber*(^dateIsLeapYear_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateIsInTodayAs) NSNumber*(^dateIsInToday_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(dateIsInMonthAs) NSNumber*(^dateIsInMonth_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numHasDecimalValueAs) NSNumber*(^numHasDecimalValue_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsOddAs) NSNumber*(^numIsOdd_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsEvenAs) NSNumber*(^numIsEven_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsNegativeAs) NSNumber*(^numIsNegative_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(numIsZeroAs) NSNumber*(^numIsZero_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(objIsNSNullAs) NSNumber*(^objIsNSNull_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strContainszh_CNAs) NSNumber*    (^strContainzh_CN_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "strContainszh_CNAs");
@property LB_BKG(strIsBlankAs) NSNumber*(^strIsBlank_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strIsEmojiAs) NSNumber*(^strIsEmoji_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strLengthAs) NSNumber*(^strLength_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strIsNumberAs) NSNumber*(^strIsNumber_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");
@property LB_BKG(strContainsEmojiAs) NSNumber*(^strContainEmoji_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "strContainsEmojiAs");
@property LB_BKG(strPathFileExistsAs) NSNumber*    (^strPathFileExists_n)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix _n changed to As");

@property LB_BKG(attr_strSetToControlAsWhatSet) NSObject*  (^attr_strSetToLabel_linkTo)(id lab)
NS_DEPRECATED_IOS(2_0, 2_0, "attr_strSetToControlAsWhatSet");
@property LB_BKG(m_attr_strSetToControlAsWhatSet) NSObject* (^m_attr_strSetToLabel_linkTo)(id lab)
NS_DEPRECATED_IOS(2_0, 2_0, "m_attr_strSetToControlAsWhatSet");
@property LB_BKG(objAddToAsWhatSet) NSObject*     (^objAddTo_linkTo)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "objAddToAsWhatSet");


@property LB_BKG(imgSetToControlAsWhatSet) NSObject*(^imgSetToImgView_linkTo)(id imgView)
NS_DEPRECATED_IOS(2_0, 2_0, "imgSetToControlAsWhatSet");

@property LB_BKG(objRemoveFromAsWhatSet) NSObject* (^objRemoveFrom_linkTo)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "objRemoveFromAsWhatSet");


@property LB_BKG(objInsertToAsWhatSet) NSObject*     (^objInsertTo_linkTo)(id obj , NSUInteger idx)
NS_DEPRECATED_IOS(2_0, 2_0, "objInsertToAsWhatSet");

@property LB_BKG(imgSetToControlAsWhatSet) NSObject*     (^imgSetToBtnBGImg_linkTo)(id btn)
NS_DEPRECATED_IOS(2_0, 2_0, "imgSetToControlAsWhatSet");
@property LB_BKG(imgSetToControlAsWhatSet) NSObject*(^imgSetToBtn_linkTo)(id btn)
NS_DEPRECATED_IOS(2_0, 2_0, "imgSetToControlAsWhatSet");

@property LB_BKG(strPathUnarchiveObjectAsWhatReturn) NSObject* (^strPathUnarchiveObject_linkTo)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "strPathUnarchiveObjectAsWhatReturn");
@property LB_BKG(attr_strDrawToImageAsWhatSet)UIImage*(^attr_strDrawToImg_linkTo)(id image, CGRect rect)
NS_DEPRECATED_IOS(2_0, 2_0, "suffix name_linkTochanged to AsWhatSet");

@property LB_BKG(objPerformSelectorAsWhatReturn) NSObject*    (^objPerformSelector_linkToReturnValue)(SEL sel)
NS_DEPRECATED_IOS(2_0, 2_0, "use objPerformSelectorAsWhatReturn");
@property LB_BKG(objPerformSelectorArgumentAsWhatReturn) NSObject*    (^objPerformSelectorWithArg_linkToReturnValue)(SEL sel , id arg)
NS_DEPRECATED_IOS(2_0, 2_0, "use objPerformSelectorArgumentAsWhatReturn");
#ifndef objPerformSelectors_linkToReturnValues
#define objPerformSelectors_linkToReturnValues(sel,args...) objPerformSelectors_linkToReturnValues(sel,##args,nil)
#endif
@property LB_BKG(objPerformSelectorsAsWhatReturns) NSArray*     (^objPerformSelectors_linkToReturnValues)(SEL sel0 , ...)
NS_DEPRECATED_IOS(2_0, 2_0, "use objPerformSelectorsAsWhatReturns");
#ifndef objPerformSelectorsWithArgs_linkToReturnValues
#define objPerformSelectorsWithArgs_linkToReturnValues(sel,args...) objPerformSelectorsWithArgs_linkToReturnValues(sel,##args,nil)
#endif
@property LB_BKG(objPerformsSelectorArgumentsAsWhatReturns) NSArray*     (^objPerformSelectorsWithArgs_linkToReturnValues)(SEL sel0 , NSArray* args0 , ...)
NS_DEPRECATED_IOS(2_0, 2_0, "use objPerformsSelectorArgumentsAsWhatReturns");

@property LB_BKG(objPerformSelectorArgument) NSObject*    (^objPerformSelectorWithArg)(SEL sel,id arg)
NS_DEPRECATED_IOS(2_0, 2_0, "use objPerformSelectorArgument");

#ifndef objPerformSelectorsWithArgs
#define objPerformSelectorsWithArgs(sel,args...) objPerformSelectorsWithArgs(sel,##args,nil)
#endif
@property LB_BKG(objPerformsSelectorArguments) NSObject*    (^objPerformSelectorsWithArgs)(SEL sel0,NSArray* args0,...)
NS_DEPRECATED_IOS(2_0, 2_0, "use objPerformsSelectorArguments");

#pragma mark - 2018.10
@property LB_BKG(strSetToControlTextAsWhatSet)NSObject*(^strSetToTxtField_linkTo)(id txtField)
NS_DEPRECATED_IOS(2_0, 2_0, "strSetToControlContentAsWhatSet");
@property LB_BKG(strSetToControlTextAsWhatSet) NSObject*(^strSetToTxtView_linkTo)(id txtView)
NS_DEPRECATED_IOS(2_0, 2_0, "strSetToControlContentAsWhatSet");
@property LB_BKG(strSetToControlTextAsWhatSet) NSObject*(^strSetToBtn_linkTo)(id btn)
NS_DEPRECATED_IOS(2_0, 2_0, "strSetToControlContentAsWhatSet");
@property LB_BKG(strSetToControlTextAsWhatSet) NSObject*(^strSetToLab_linkTo)(id lab)
NS_DEPRECATED_IOS(2_0, 2_0, "strSetToControlTextAsWhatSet");
@property LB_BKG(viewIsInView) BOOL         (^viewIsSubviewTo)(UIView* view)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewIsInView");
@property LB_BKG(viewContainsView) BOOL(^viewIsSuperviewTo)(UIView* view)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewContainsView");


@property LB_BKG(viewBringFrontInSuperview) UIView* (^viewBringFrontInView)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewBringFrontInSuperview");

@property LB_BKG(viewSendBackInSuperview) UIView*(^viewSendBackInView)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewSendBackInSuperview");

@property LB_BKG(viewPrevIndexView) UIView* (^viewBeforeIndexView)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to viewPrevIndexView");

@property LB_BKG(strContains) BOOL(^strContain)(NSString* str)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to strContains");

@property LB_BKG(strContainsEmoji) BOOL(^strContainEmoji)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to strContainsEmoji");

@property LB_BK NSUInteger(^strLength)(void)
NS_DEPRECATED_IOS(2_0, 2_0, ".length");

@property LB_BKG(viewSubviewsExclusiveTouch) UIView*(^viewSubiewsExclusiveTouch)(BOOL b)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to viewSubviewsExclusiveTouch");

@property LB_BKG(arrContains) BOOL(^arrContain)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to arrContains");

@property LB_BKG(arrAddToArrAsWhatSet) NSMutableArray*(^arrAddToArr)(NSMutableArray* arr)
NS_DEPRECATED_IOS(2_0, 2_0, "arrAddToArrAsWhatSet");

@property LB_BKG(arrContainsIndex) BOOL(^arrContainIndex)(NSUInteger idx)
NS_DEPRECATED_IOS(2_0, 2_0, "use arrContainsIndex");

@property LB_BK NSDictionary*            (^arrToDictByKeyNumber)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "use arrContainsIndexAs");
@property LB_BK NSDictionary*            (^arrToDictByKeyString)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(arrGetValuesIndexForValue) NSIndexSet*(^arrIndexSetOfValue)(id value)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrGetValuesIndexWithValue");

@property LB_BK NSMutableArray*          (^arrObjsValueRandom)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "depracated");

@property LB_BKG(arrObjsWithKindOfClass) NSMutableArray*(^arrObjsOfType)(Class typeClass)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrObjsWithKindOfClass");

@property LB_BKG(arrGetPrevItemForObj) NSObject*(^arrBefore)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrGetPrevItemForObj");
@property LB_BKG(arrGetNextItemForObj) NSObject*(^arrNext)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrGetNextItemForObj");

@property LB_BKG(arrContainsKeyValue) BOOL(^arrKeyValueContain)(NSString* key,id eqValue)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrKeyValueMatchedObjs");
@property LB_BKG(arrKeyValueMatchedObjs) NSMutableArray*(^arrKeyValueMatchObjs)(NSString* key,id value)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrKeyValueMatchedObjs");
@property LB_BKG(arrKeyValuesMatchedObjs) NSMutableArray*(^arrKeyValuesMatchObjs)(NSDictionary<NSString*,id>* kv)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrKeyValuesMatchedObjs");
@property LB_BK NSArray*                 (^arrSetValueForKey)(id value, NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "can be instead");

@property LB_BKG(arrReplaceItemKeyForDictionaryItemDepth) NSMutableArray*(^arrReplaceKeyInDict)(id replaceKey,id withKey)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrReplaceKeyForDictionaryItemDepth");
@property LB_BKG(arrReplaceItemKeyForDictionaryItem) NSMutableArray*(^arrReplaceKeyInDictWithoutDeep)(id replaceKey,id withKey)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrReplaceKeyForDictionaryItem");

@property LB_BKG(arrAddOrReplaceItemCaseValueForKey) NSMutableArray*(^arrAddOrReplaceObjByKey)(id obj , NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrAddOrReplaceWhenObjValueMatchedForKey");

@property LB_BKG(arrInsertOrReplaceItemCaseValueForKeyAt) NSMutableArray*(^arrInsertOrReplaceObjByKeyAt)(id obj , NSString* key, NSUInteger idx)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrInsertOrReplaceWhenObjValueMatchedForKeyAt");

@property LB_BKG(arrReplaceItemCaseValueForKey) NSMutableArray*(^arrTryReplaceObjByKey)(id obj , NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrReplaceWhenObjValueMatchedForKey");

@property LB_BKG(arrReplaceItemsCaseValueForKey) NSMutableArray*(^arrTryReplaceObjsByKey)(NSArray* objs , NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrReplaceWhenObjsValueMatchedForKey");

@property LB_BK NSDictionary*        (^dictObjsValueRandom)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BK NSArray*     (^dictAllKeys)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSArray*     (^dictAllValues)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK BOOL         (^dictGetBOOL)(id<NSCopying> key)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK id           (^dictGetNoNSNull)(id key)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSTimeInterval   (^dateTimeIntervalSince1970)(void)
NS_DEPRECATED_IOS(2_0, 2_0, ".timeIntervalSince1970");

@property LB_BKG(dictAddEntries) NSMutableDictionary* (^dictUnionDict)(NSDictionary* dict)
NS_DEPRECATED_IOS(2_0, 2_0, "dictAddEntries");

@property LB_BKG(dictObjectForKeyAsLinkObj) NSObject*    (^dictGet)(id key)
NS_DEPRECATED_IOS(2_0, 2_0, "dictObjectForKeyAsLinkObj");
@property LB_BKG(dictSetWithKeyObject) NSMutableDictionary* (^dictSetValue)(id key , id value)
NS_DEPRECATED_IOS(2_0, 2_0, "dictSetWithKeyObject");
@property LB_BKG(dictReplaceForKeyDepth) NSMutableDictionary* (^dictReplaceKey)(id key, id newKey)
NS_DEPRECATED_IOS(2_0, 2_0, "dictReplaceForKeyDepth");
@property LB_BKG(dictReplaceForKey) NSMutableDictionary* (^dictReplaceKeyWithoutDeep)(id key, id newKey)
NS_DEPRECATED_IOS(2_0, 2_0, "dictReplaceForKey");
@property LB_BKG(dictContainsKey) BOOL(^dictContainKey)(id key)
NS_DEPRECATED_IOS(2_0, 2_0, "dictContainsKey");
@property LB_BKG(dictContainsValue) BOOL(^dictContainValue)(id value)
NS_DEPRECATED_IOS(2_0, 2_0, "dictContainsValue");

@property LB_BKG(dictContainsKey) BOOL         (^dictContaineKey)(id<NSCopying> key)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to dictContainKey");
@property LB_BKG(dictContainsValue) BOOL         (^dictContaineValue)(id value)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to dictContainValue");
@property LB_BKG(dictContainsKeyAs) NSNumber*    (^dictContaineKey_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to dictContainAsWhatSet");
@property LB_BKG(dictContainsValueAs) NSNumber*    (^dictContaineValue_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "fixed to dictContainValue_n");


@property LB_BKG(numToStrByMaxDecimalWidth) NSString*    (^numToStrMaxDigit)(NSUInteger maxDigit)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to numToStringByMaxDecimalWidth");

@property LB_BK CGSize(^labTextSize)(NSNumber* maxWidth)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(img_viewImageWithName) UIImageView*(^img_viewImageStr)(NSString* imageStr)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to img_viewImageWithName");

@property LB_BKG(imgSetToControlAsWhatSet) UIImageView*(^imgSetToImageViewAsWhatSet)(UIImageView* imgView)
NS_DEPRECATED_IOS(2_0, 2_0, "imgSetToImageViewAsWhatSet");



@property LB_BKG(colorSetToUIBackground) UIColor*(^colorSetToViewBG)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorSetToUIForBackground");
@property LB_BKG(colorSetToUIBackground) UIColor*(^colorSetToViewsBG)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorSetToUIForBackground");
@property LB_BKG(colorSetToUIText) UIColor*(^colorSetToLabText)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorSetToUIForText");
@property LB_BKG(colorSetToUIText) UIColor*(^colorSetToTxtViewText)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorSetToUIForText");
@property LB_BKG(colorSetToUIText) UIColor*(^colorSetToTxtFieldText)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorSetToUIForText");
@property LB_BKG(colorSetToUIText) UIColor*(^colorSetToBtnTitle)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorSetToUIForText");

@property LB_BKG(colorToHexStringWithPrefix) NSString*(^colorToHexStrByPrefix)(NSString* prefix)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to colorToHexStringWithPrefix");

@property LB_BKG(strCustomComposedLength) NSUInteger(^strLengthComposedAndCustom)(NSString* customReg)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to strCustomComposedLength");

@property LB_BK NSString*(^strPredicateFilterMutable)(id collection)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSArray*(^strPredicateFilteredArray)(NSArray* arr)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK BOOL(^strPredicateEvaluate)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BK NSObject*            (^strKeyForValueWith)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSObject*            (^strKeyPathForValueWith)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(viewFindFirstResponderSubViewOfTextInput) UIView*      (^viewFirstResponderSubViewForInput)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "viewFindFirstResponderSubViewOfTextInput");

@property LB_BK NSObject*      (^linkTo)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(linkPush) NSObject*      (^linkAnd)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "use linkPush");
@property LB_BK NSObject*      (^linkOut)(NSUInteger idx)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_FN NSObject*      linkFirstObj
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_FN NSObject*      linkLastObj
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(arrInsertObjsAt) NSMutableArray*(^arrInsertArrayAt)(id arr,NSUInteger index)
NS_DEPRECATED_IOS(2_0, 2_0, "arrInsertObjsAt");
@property LB_BKG(arrRemoveObjsFromIndexTo) NSMutableArray*(^arrRemoveObjsFromTo)(NSUInteger from,NSUInteger andTo)
NS_DEPRECATED_IOS(2_0, 2_0, "arrRemoveObjsFromIndexTo");
@property LB_BK NSMutableArray*  (^arrInsertToArrayAt)(NSMutableArray* arr, NSUInteger index)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BKG(arrInsertObjsAt) NSMutableArray*(^m_arrInsertArrayAt)(id arr, NSUInteger index)
NS_DEPRECATED_IOS(2_0, 2_0, "arrInsertObjsAt");
@property LB_BKG(arrAddObj) NSMutableArray*(^m_arrAddObj)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "arrAddObj");
@property LB_BKG(arrAddObjs) NSMutableArray*(^m_arrAddObjs)(NSArray* array)
NS_DEPRECATED_IOS(2_0, 2_0, "arrAddObjs");
@property LB_BKG(arrInsertObjAt) NSMutableArray*(^m_arrInsertObjAt)(id obj,NSUInteger index)
NS_DEPRECATED_IOS(2_0, 2_0, "arrInsertObjAt");
@property LB_BKG(arrRemoveObj) NSMutableArray*(^m_arrRemoveObj)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "arrRemoveObj");
@property LB_BKG(arrRemoveAt) NSMutableArray*(^m_arrRemoveAt)(NSUInteger index)
NS_DEPRECATED_IOS(2_0, 2_0, "arrRemoveAt");
@property LB_BKG(arrRemoveObjsFromIndexTo) NSMutableArray*(^m_arrRemoveObjsFromTo)(NSUInteger fromIndex,NSUInteger toIndex)
NS_DEPRECATED_IOS(2_0, 2_0, "arrRemoveObjsFromIndexTo");
@property LB_BKG(arrRemoveAll) NSMutableArray*(^m_arrRemoveAll)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "arrRemoveAll");
@property LB_BKG(arrSort) NSMutableArray*(^m_arrSort)(BOOL ascending)
NS_DEPRECATED_IOS(2_0, 2_0, "arrSort");
@property LB_BKG(arrSortByKey)NSMutableArray*(^m_arrSortByKey)(NSString* key, BOOL ascending)
NS_DEPRECATED_IOS(2_0, 2_0, "arrSortByKey");
@property LB_BKG(arrFilter)NSMutableArray*(^m_arrFilter)(NSString* predicateFormat,...)
NS_DEPRECATED_IOS(2_0, 2_0, "arrFilter");
@property LB_BKG(arrReversed)NSMutableArray*(^m_arrReversed)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "arrReversed");
@property LB_BKG(arrReplaceObjWith)NSMutableArray*(^m_arrReplaceObjWith)(id obj,id withObj)
NS_DEPRECATED_IOS(2_0, 2_0, "arrReplaceObjWith");
@property LB_BKG(arrSortRange)NSMutableArray<NSValue*>*(^m_arrSortRange)(BOOL ascending, BOOL isCombine)
NS_DEPRECATED_IOS(2_0, 2_0, "arrSortRange");
@property LB_BKG(arrInsertObjNextTo)NSMutableArray*(^arrInsertNext)(id obj, id nextTo)
NS_DEPRECATED_IOS(2_0, 2_0, "rename arrInsertObjNextTo");
@property LB_BKG(arrReplaceItemCaseValueForKey)NSMutableArray*(^m_arrTryReplaceObjByKey)(id obj,NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrReplaceItemCaseValueForKey");
@property LB_BKG(arrReplaceItemsCaseValueForKey)NSMutableArray*(^m_arrTryReplaceObjsByKey)(NSArray* objs,NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "rename to arrReplaceItemsCaseValueForKey");

@property LB_BKG(dictAddEntries) NSMutableDictionary* (^dictAddEntries)(NSDictionary* dict)
NS_DEPRECATED_IOS(2_0, 2_0, "m_dictAddEntries");
@property LB_BKG(dictSetWithKeyObject) NSMutableDictionary* (^m_dictSetValue)(id key , id value)
NS_DEPRECATED_IOS(2_0, 2_0, "dictSetWithKeyObject");

@property LB_BKG(dictReplaceForKeyDepth) NSMutableDictionary* (^m_dictReplaceKey)(id key, id newKey)
NS_DEPRECATED_IOS(2_0, 2_0, "dictReplaceForKeyDepth");
@property LB_BKG(dictReplaceForKey) NSMutableDictionary* (^m_dictReplaceKeyWithoutDeep)(id key, id newKey)
NS_DEPRECATED_IOS(2_0, 2_0, "dictReplaceForKey");

@property LB_BK NSMutableDictionary* (^dictSetWithKeyObject)(id key,id object)
NS_DEPRECATED_IOS(2_0, 2_0, "use dictSetObjectForKey instead and exchange key and object.");

@property LB_BKG(strInsertStrAt) NSString*(^strInsertAt)(NSString* str,NSUInteger index)
NS_DEPRECATED_IOS(2_0, 2_0, "strInsertStrAt");


- (NSObject*)linkFrom:(NSUInteger)fromIndex
                   to:(NSUInteger)toIndex
                block:(void(^)(NSUInteger idx , NSObject* obj))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

- (NSObject*)linkAt:(NSUInteger)idx
              block:(void(^)(NSObject* obj))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

- (NSObject*)linkAfterIn:(double)time block:(void(^)(NSObject* link))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
- (NSObject*)linkInBlock:(void(^)(NSObject* link))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
- (NSObject*)linkAsy_main_queue:(void(^)(NSObject* link))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
- (NSObject*)linkAsy_global_queue:(void(^)(NSObject* link))block
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
- (NSObject*)linkLoopIn:(NSUInteger)count block:(void(^)(NSObject* link, NSUInteger index))block
NS_DEPRECATED_IOS(2_0, 2_0, "use linkLoop(@,@?) instead");

@property LB_BK UIView*      (^viewCopyX)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*      (^viewCopyY)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*      (^viewCopyFrame)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*      (^viewCopySize)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*      (^viewCopyOrigin)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewCopyCenter)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewCopyCenterX)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewCopyCenterY)(UIView* fromView)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewTopTo)(UIView* toView, CGFloat margin)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewLeftTo)(UIView* toView, CGFloat margin)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewBottomTo)(UIView* toView, CGFloat margin)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK UIView*(^viewRightTo)(UIView* toView, CGFloat margin)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");

@property LB_BK NSNumber*(^arrMaxNumber)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSNumber*(^arrMinNumber)(void)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BKG(objIsEqual) BOOL(^attr_strIsEqualToAttrStr)(id attrStr)
NS_DEPRECATED_IOS(2_0, 2_0, "objIsEqual");

@property LB_BKG(objIsEqualAs) NSNumber*(^attr_strIsEqualToAttrStr_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "objIsEqualAs");
@property LB_BKG(objIsEqual) BOOL(^numIsEqualToNum)(id num)
NS_DEPRECATED_IOS(2_0, 2_0, "objIsEqualAs");
@property LB_BKG(objIsEqualAs) NSNumber*(^numIsEqualToNum_n)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "objIsEqualAs");

@property LB_BK NSNumber*    (^dictGetBOOLAs)(id<NSCopying> key)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BK NSNumber*(^strPredicateEvaluateAs)(id obj)
NS_DEPRECATED_IOS(2_0, 2_0, "deprecated");
@property LB_BKG(objIsEqualAs) NSNumber*(^attr_strIsEqualToAttrStrAs)(id attrStr)
NS_DEPRECATED_IOS(2_0, 2_0, "objIsEqualAs");

#pragma mark - 2018.11.15

+ (BOOL)classIsFoundation
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsFoundation");

@property LBC_BKG(lb_classGetIvarList)NSArray<NSString*>* classGetIvarList
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");
@property LBC_BKG(lb_classGetPropertyList)NSArray<NSString*>* classGetPropertyList
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");
@property LB_BKG(lb_objGetInstanceMethodList)NSArray<NSString*>* objGetInstanceMethodList
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");
@property LBC_BKG(lb_classGetClassMethodList)NSArray<NSString*>* classGetClassMethodList
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");
@property LBC_BKG(lb_classGetProtocolList)NSArray<NSString*>* classGetProtocolList
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");

+ (BOOL)classContainProperty:(NSString*)property
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");

+ (BOOL)classContainIvar:(NSString*)ivarName
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");

+ (NSString*)classGetPropertyType:(NSString*)key
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");

+ (NSArray<NSString*>*)classGetAllPropertyList:(BOOL)includeFoundation
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");


+ (void)classEnumerateUsingBlock:(void(^)(Class clazz , BOOL* stop))block
               includeFoundation:(BOOL)includeFoundation
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");

+ (void)classPropertysEnumerateUsingBlock:(void(^)(Class clazz,NSString* propertyName,NSString* propertyType,BOOL* stop))block includeFoundation:(BOOL)includeFoundation
NS_DEPRECATED_IOS(2_0, 2_0, "lb_classIsBasic");

#pragma mark - 2019.02
@property LB_BKG(nslogValueForKeyPath) NSObject* (^nslogValueForKey)(NSString* key)
NS_DEPRECATED_IOS(2_0, 2_0, "nslogValueForKeyPath");
@end

