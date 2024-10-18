//
//  NSDictionary+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(NSDictionaryLinkBlock)

#pragma mark - Foundation Mirror/镜像
/** nil->NSNull.if need nil please to use foundation API */
@property LB_BK NSObject*    (^dictObjectForKeyAsLinkObj)(id key);

#pragma mark - Foundation Speed/速度
@property LB_BK BOOL         (^dictContainsKey)(id key);
@property LB_BK NSNumber*    (^dictContainsKeyAs)(id key);
@property LB_BK BOOL         (^dictContainsValue)(id value);
@property LB_BK NSNumber*    (^dictContainsValueAs)(id value);
@property LB_BK NSArray*     (^dictKeysForValue)(id value);
/// get object ,self[@"id"];
@property LB_BK NSObject*    (^dictForid)(void);
/// get object ,self[dictForUIImagePickerControllerMediaType];
@property LB_BK UIImage*     (^dictForUIImagePickerControllerMediaType)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerOriginalImage)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerEditedImage)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerCropRect)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerMediaURL)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerReferenceURL)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerMediaMetadata)(void);
@property LB_BK UIImage*     (^dictForUIImagePickerControllerLivePhoto)(void);

#pragma mark - Weak coding/弱类型编码
@property LB_BK NSMutableDictionary* (^dictSetObjectForKey)(id obj,id key);
@property LB_BK NSMutableDictionary* (^dictAddEntries)(NSDictionary* dict);

#pragma mark - LinkBlock

@property LB_BK NSMutableDictionary* (^dictReplaceForKeyDepth)(id key, id newKey);
@property LB_BK NSMutableDictionary* (^dictReplaceForKey)(id key, id newKey);

@end
