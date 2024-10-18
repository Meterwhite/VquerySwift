//
//  NSString+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(NSStringLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK NSString*    (^strAppend)(NSString* str);
/** <^(NSString* replace, NSString* with)> */
@property LB_BK NSString*    (^strReplace)(NSString* replace, NSString* with);
@property LB_BK NSMutableString* (^strMutableCopy)(void);
@property LB_BK BOOL         (^strIsEqualStr)(NSString* str);
@property LB_BK NSNumber*    (^strIsEqualStrAs)(NSString* str);
@property LB_BK NSNumber*    (^strLengthAs)(void);
@property LB_BK NSString*    (^strAppendFormat)(NSString* formatStr , ...);
@property LB_BK NSString*    (^strReplaceInRange)(NSString* str, NSRange range);
@property LB_BK BOOL         (^strContains)(id obj);
@property LB_BK NSNumber*    (^strContainsAs)(id obj);
@property LB_BK NSRange      (^strRangeOfStr)(NSString* str);
@property LB_BK NSComparisonResult (^strCompare)(NSString* str);
@property LB_BK NSArray<NSString*>*     (^strSplitWithStr)(NSString* splitStr);
@property LB_BK NSArray<NSString*>*     (^strSplitWithCharsStr)(NSString* splitStr);
@property LB_BK BOOL         (^strHasPrefix)(NSString* prefix);
@property LB_BK NSNumber*    (^strHasPrefixAs)(NSString* prefix);
@property LB_BK BOOL         (^strHasSuffix)(NSString* suffix);
@property LB_BK NSNumber*    (^strHasSuffixAs)(NSString* suffix);
@property LB_BK NSString*    (^strSubFrom)(NSUInteger from);
@property LB_BK NSString*    (^strSubTo)(NSUInteger to);
@property LB_BK NSString*    (^strSubFromTo)(NSUInteger from , NSUInteger to);
@property LB_BK NSString*    (^strSubWithRange)(NSRange range);
@property LB_BK CGRect               (^strToCGRect)(void);
@property LB_BK CGVector             (^strToCGVector)(void);
@property LB_BK CGSize               (^strToCGSize)(void);
@property LB_BK CGPoint              (^strToCGPoint)(void);
@property LB_BK CGAffineTransform    (^strToCGAffineTransform)(void);
@property LB_BK UIEdgeInsets         (^strToUIEdgeInsets)(void);
@property LB_BK UIOffset             (^strToUIOffset)(void);



#pragma mark - Foundation Speed/速度
@property LB_BK NSString*    (^strAt)(NSUInteger index);
/** compose string at */
@property LB_BK NSString*    (^strComposeAt)(NSUInteger index);
@property LB_BK NSString*    (^strDeleteStr)(NSString* str);
/** true mutable string */
@property LB_BK NSNumber*    (^strIsMutableAs)(void);
@property LB_BK NSString*    (^strAppendTo)(NSString* str);
@property LB_BK NSInteger    (^strIndexOfStr)(NSString* str);

@property LB_BK CGSize       (^strSizeWithFont)(UIFont* font);
@property LB_BK NSValue*     (^strSizeWithFontAs)(UIFont* font);
@property LB_BK CGSize       (^strSizeWithFontAndMaxWidth)(UIFont* font , CGFloat maxWidth);
@property LB_BK NSValue*     (^strSizeWithFontAndMaxWidthAs)(UIFont* font , CGFloat maxWidth);
@property LB_BK CGSize       (^strSizeWithFontAndMaxSize)(UIFont* font, CGSize maxSize);
@property LB_BK NSValue*     (^strSizeWithFontAndMaxSizeAs)(UIFont* font, CGSize maxSize);
@property LB_BK CGFloat      (^strHeight)(NSDictionary<NSAttributedStringKey,id>* attrDict);
@property LB_BK CGFloat      (^strLineHeight)(NSDictionary<NSAttributedStringKey,id>* attrDict);
/** Reverse string */
@property LB_BK NSString*    (^strReversed)(void);





#pragma mark - Foundation Extend/补充
@property LB_BK NSUInteger   (^strLengthASCII)(void);
@property LB_BK NSUInteger   (^strLengthUnicode)(void);
@property LB_BK NSUInteger   (^strLengthComposed)(void);
@property LB_BK NSString*    (^strAppendLine)(NSString* str);
/** set customRegex to find string as composed  */
@property LB_BK NSUInteger   (^strCustomComposedLength)(NSString* customRegex);

#pragma mark - LinkBlock
/** Delete first matching string from left */
@property LB_BK NSString*    (^strDeleteLeft)(NSString* str);
@property LB_BK NSString*    (^strDeleteRight)(NSString* str);
/** Delete all matching strings from left until not match */
@property LB_BK NSString*    (^strTrimLeft)(NSString* str);
@property LB_BK NSString*    (^strTrimRight)(NSString* str);
/** Delete specified string at start and end */
@property LB_BK NSString*    (^strTrim)(NSString* str);

@property LB_BK NSString*    (^strSubComposeFrom)(NSUInteger from);
@property LB_BK NSString*    (^strSubComposeTo)(NSUInteger to);
@property LB_BK NSString*    (^strSubComposeFromTo)(NSUInteger from , NSUInteger to);

/** Empty string and "<null>","(null)" */
@property LB_BK BOOL         (^strIsBlank)(void);
@property LB_BK NSNumber*    (^strIsBlankAs)(void);
/** Determine Integer string/整型字符串 */
@property LB_BK BOOL         (^strIsInteger)(void);
/** Determine Floating string/浮点数字符串 */
@property LB_BK BOOL         (^strIsFloating)(void);

@property LB_BK BOOL         (^strIsNumber)(void);
@property LB_BK NSNumber*    (^strIsNumberAs)(void);
/** 判断包含汉字 */
@property LB_BK BOOL         (^strContainszh_CN)(void);
@property LB_BK NSNumber*    (^strContainszh_CNAs)(void);
@property LB_BK BOOL         (^strContainsEmoji)(void);
@property LB_BK NSNumber*    (^strContainsEmojiAs)(void);
@property LB_BK BOOL         (^strIsEmoji)(void);
@property LB_BK NSNumber*    (^strIsEmojiAs)(void);
/** to unicode string: @"我" => @"\u6211" */
@property LB_BK NSString*    (^strToUnicoding)(void);
@property LB_BK NSString*    (^strFromUnicoding)(void);
/** 范围内是否是汉字 */
@property LB_BK BOOL         (^strIszh_CNInRange)(NSRange range);
@property LB_BK NSNumber*    (^strIszh_CNInRangeAs)(NSRange range);
@property LB_BK NSRange      (^strRange)(void);

@property LB_BK NSInteger    (^strIndexOfStrStartAt)(NSString* str, NSUInteger startIndex);

/** '\n' */
@property LB_BK NSUInteger   (^strLinesCount)(void);
/** '\n' */
@property LB_BK NSString*    (^strSubToLine)(NSUInteger toLine);

/** line count of UI(Half-fold)/折半查找 */
@property LB_BK NSInteger    (^strUILinesCount)(CGFloat maxWidth,NSDictionary<NSAttributedStringKey,id>* attrDict);
/** sub line of UI(Half-fold)/折半查找 */
@property LB_BK NSString*    (^strSubToUILine)(NSInteger toLine, CGFloat maxWidth,NSDictionary<NSAttributedStringKey,id>* attrDict);
/**
 计算反向挤压后的字符串可见范围
 ... ... ... ...
 ... ... ... ...
 ... ... ...more
 
 The return value use to sub string,then append "ifAppendStr"
 Not suport image
 @param isFullOfLines if YES.May do this "...+ifAppendStr",or not contain"..."
 
 */
@property LB_BK NSRange (^strSubRangeToMaxUILineIfAppendStr)
(   NSUInteger maxLine ,
    CGFloat maxWidth,
    NSString* ifAppendStr ,
    NSDictionary<NSAttributedStringKey,id>* attrDict ,
    BOOL* isFullOfLines
 );

@property LB_BK NSString*    (^strClearSpaceAndWrap)(void);
/** 12.3 < 12.4 , Foo2.txt , Foo7.txt ; */
@property LB_BK NSComparisonResult (^strCompareNumberSensitive)(NSString* str);
/** copy to GeneralPasteboard */
@property LB_BK NSString*    (^strCopyToGeneralPasteboard)(void);
@property LB_BK NSString*    (^strAlertInCurrentViewController)(NSString* cancelButton);


#pragma mark - Weak coding/弱类型编码
/**
 *  This is compound strAppend.'self' may be mutable copy if it immutable.
 *  obj ∈ {__kindof NSString, NSObject};NSObject in strAppend will call description.
 */
@property LB_BK NSMutableString*(^strAppendObj)(id obj);
/** m_strInsertStrAt > strInsertStrAt;'self' may be mutable copy if it immutable. */
@property LB_BK NSMutableString*(^strInsertStrAt)(NSString* str,NSUInteger index);
/** m_strDeleteInRange > strDeleteInRange;'self' may be mutable copy if it immutable. */
@property LB_BK NSMutableString*(^strDeleteInRange)(NSRange range);

@property LB_BK UIView*              (^strSetToControlTextAsWhatSet)(UIView* textControl);
/** return NSNull is class did not exist */
@property LB_BK NSObject*            (^strToObjectFromName)(void);
/** 0xcccccc , #cccccc , cccccc */
@property LB_BK UIColor*             (^strToUIColorFromHex)(void);
@property LB_BK NSURL*               (^strToNSURL)(void);
@property LB_BK NSAttributedString*  (^strToNSAttributedString)(NSDictionary<NSAttributedStringKey,id>* attrbute);
@property LB_BK NSMutableAttributedString*  (^strToNSMutableAttributedString)(NSDictionary<NSAttributedStringKey,id>* attrbute);
@property LB_BK NSIndexPath*         (^strToNSIndexPathFromJsonArray)(NSStringEncoding encoding);

@property LB_BK UIImage*             (^strToUIImage)(void);
@property LB_BK NSNumber*            (^strToNSNumber)(void);
/** size is equal to UIImage */
@property LB_BK UIImageView*         (^strToUIImageView)(void);
@property LB_BK double               (^strToDoubleFromHex)(void);
@property LB_BK unsigned int         (^strToIntFromHex)(void);
@property LB_BK NSData*              (^strToNSDataWithContentsOfFile)(void);
@property LB_BK NSData*              (^strToNSDataUseEncoding)(NSStringEncoding encodeing);
@property LB_BK NSDate*              (^strToNSDateWithFormat)(NSString* formatStr);
@property LB_BK NSDate*              (^strToNSDateSince1970)(void);
@property LB_BK NSDictionary*        (^strToNSDictionary)(NSStringEncoding encoding);
@property LB_BK NSArray*             (^strToNSArrary)(NSStringEncoding encoding);
@property LB_BK NSPredicate*         (^strToPredicate)(void);
@property LB_BK NSPredicate*         (^strToPredicateWidthFormatArgs)(id obj1 , ...);
/** note:you should relase it */
@property LB_BK UInt32               (^strToSystemSoundID)(void);


#pragma mark - string as name
@property LB_BK UIView*     (^strLoadNibNamedAt)(NSUInteger index);
@property LB_BK UIView*     (^strLoadNibNamedFirst)(void);
@property LB_BK UIView*     (^strLoadNibNamedLast)(void);


#pragma mark - string as path
/** get file in bundle by name */
@property LB_BK NSString*    (^strPathByFileNameInBundle)(NSString* type);
@property LB_BK NSString*    (^strPathAppendingComponent)(NSString* component);

@property LB_BK BOOL         (^strPathFileExists)(void);
@property LB_BK NSNumber*    (^strPathFileExistsAs)(void);
/** 
 Play sound and release
 exp:@"/System/Library/Audio/UISounds/Tock.caf".strPathSoundPlay();
 */
@property LB_BK NSString*    (^strPathSoundPlay)(void);

@property LB_BK NSString*    (^strPathArchiveObject)(id<NSCoding>obj);
/** ...strPathUnarchiveObjectAsWhatReturn().thisValue... */
@property LB_BK NSObject*    (^strPathUnarchiveObjectAsWhatReturn)(void);


#pragma mark - string as regex
@property LB_BK BOOL                 (^strRegexIsMatch)(NSString* regex);
@property LB_BK NSNumber*            (^strRegexIsMatchAs)(NSString* regex);
/** return matched objects */
@property LB_BK NSMutableArray<NSString*>* (^strRegexMatchs)(NSString* regex);
/**
 *  regex : "http://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?".
 *  replaceTemplate : "<a href=\"$0\">$0</a>".
 */
@property LB_BK NSString*            (^strRegexReplace)(NSString* regex, NSString* replaceTemplate);
/** Find first number in string */
@property LB_BK double               (^strFindNumber)(void);

#pragma mark - As URL string
/** <^(NSString* key)>字符串进行URL编码 */
@property LB_BK NSString*            (^strByAddingPercentEncodingWithURLQueryAllowedCharacterSet)(void);
/** Try get BaseURL.Get string before '?',but do not check out. */
@property LB_BK NSString*            (^strURLBeforeKeyValues)(void);
/** get value from URL */
@property LB_BK NSString*            (^strURLValueForKey)(NSString* key);
@property LB_BK NSString*            (^strURLSetValueForKey)(NSString* value,NSString* key);
@property LB_BK NSString*            (^strURLSetKeyValueWithDict)(NSDictionary<NSString*,NSString*>* keyValues);
@property LB_BK NSDictionary*        (^strURLKeyValues)(void);
@property LB_BK NSArray*             (^strURLAllKeys)(void);
@property LB_BK NSArray*             (^strURLAllValues)(void);
@property LB_BK NSString*            (^strURLRemoveValueForKey)(NSString* key);
@property LB_BK NSString*            (^strURLReplaceKeyWithKey)(NSString* replaceKey,NSString* withKey);
@property LB_BK NSString*            (^strURLReplaceKeyWithDict)(NSDictionary<NSString*,NSString*>* replaceKey_withKey);
@property LB_BK NSString*            (^strURLEncodeUTF8)(void);
@property LB_BK NSString*            (^strURLDecodeUTF8)(void);
@property LB_BK NSString*            (^strURLEncode)(NSStringEncoding encode);
@property LB_BK NSString*            (^strURLDecode)(NSStringEncoding encode);

@end

@interface NSString (NSStringLinkBlock)

- (void)strEnumerateScanIntegerUsingBlock:(void (^)(NSInteger num, NSUInteger idx, BOOL * stop))block;

- (void)strEnumerateScanFloatingUsingBlock:(void(^)(double num, NSUInteger idx, BOOL *stop))block;

- (void)strEnumerateScanNumberUsingBlock:(void(^)(double num, NSUInteger idx, BOOL *stop))block;

- (void)strEnumerateComposedUsingBlock:(void(^)(NSString* string,NSRange range,BOOL *stop))block;

- (NSMutableString*)strEnumerateComposedModifiedUsingBlock:(void(^)(NSString** string,NSRange range,BOOL *stop))block;

- (void)strEnumerateCustomComposed:(NSString*)regex
                        usingBlock:(void(^)(NSString* string,NSRange range,BOOL isCustom,BOOL *stop))block;

- (NSString *)strEnumerateURLUsingBlock:(void(^)(NSString** urlBeforeKeyValue , NSString** key , NSString** value , BOOL* stop))block;
@end
