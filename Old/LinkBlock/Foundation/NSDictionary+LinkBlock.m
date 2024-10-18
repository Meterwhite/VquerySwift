//
//  NSDictionary+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSDictionaryLinkBlock)

- (NSObject* (^)(id))dictObjectForKeyAsLinkObj
{
    return ^id(id key){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictObjectForKeyAsLinkObj,key)
        return linkObjNotNil(_self[key]);
    };
}

- (BOOL (^)(id))dictContainsKey
{
    return ^(id key){
        return self.dictContainsKeyAs(key).boolValue;
    };
}

- (NSNumber* (^)(id))dictContainsKeyAs
{
    return ^id(id key){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictContainsKeyAs,key)
        return @([[_self allKeys] containsObject:key]);
    };
}

- (BOOL (^)(id))dictContainsValue
{
    return ^(id value){
        return self.dictContainsValueAs(value).boolValue;
    };
}

- (NSNumber* (^)(id))dictContainsValueAs
{
    return ^id(id value){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictContainsValueAs,value)
        return @([[_self allValues] containsObject:value]);
    };
}

- (NSArray *(^)(id))dictKeysForValue
{
    return ^id(id value){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictKeysForValue,value)
        id ret = [_self allKeysForObject:value];
        if([ret count] == 0) return [NSArray new];
        return ret;
    };
}



- (NSMutableDictionary *(^)(id, id))dictReplaceForKeyDepth
{
    return ^id(id replaceKey, id withKey){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictReplaceForKeyDepth,replaceKey,withKey)
        NSMutableDictionary* ret = [NSMutableDictionary dictionaryWithDictionary:_self];
        
        [[ret allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            
            id value = ret[key];
            if([value isKindOfClass:[NSDictionary class]]){//层次遍历字典
                
                ret[key] = ((NSDictionary*)value).dictReplaceForKeyDepth(replaceKey , withKey);
            }
            if([value isKindOfClass:[NSArray class]]){//层次遍历数组
                
                ret[key] = ((NSArray*)value).arrReplaceItemKeyForDictionaryItemDepth(replaceKey, withKey);
            }
            
            if([[ret allKeys] containsObject:replaceKey]){//替换键
                
                ret[withKey] = ret[replaceKey];
                [ret removeObjectForKey:replaceKey];
            }
        }];
        
        return ret;
    };
}

- (NSMutableDictionary *(^)(id, id))dictReplaceForKey
{
    return ^id(id replaceKey, id withKey){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictReplaceForKey,replaceKey,withKey)
        NSMutableDictionary* result = [NSMutableDictionary dictionaryWithDictionary:_self];
        [[result allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([[result allKeys] containsObject:replaceKey]){
                result[withKey] = result[replaceKey];
                [result removeObjectForKey:replaceKey];
            }
        }];
        return result;
    };
}


- (NSMutableDictionary *(^)(id, id))dictSetObjectForKey
{
    return ^id(id obj,id key){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictSetObjectForKey,obj,key)
        
        if(!LB_IsKindOfClass(_self, NSMutableDictionary)){
            LB_MCopy_VAR(_self);
        }
        
        if(obj && key){
            [_self setObject:obj forKey:key];
        }
        return _self;
    };
}

- (NSMutableDictionary *(^)(NSDictionary *))dictAddEntries
{
    return ^id(NSDictionary* dict){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictAddEntries,dict)
        
        if(!LB_IsKindOfClass(_self, NSMutableDictionary)){
            LB_MCopy_VAR(_self);
        }
        
        [_self addEntriesFromDictionary:dict];
        return _self;
    };
}
- (NSObject *(^)(void))dictForid
{
    return ^id(){
        LinkHandle_REF(NSDictionary)
        LinkGroupHandle_REF(dictForid)
        return _self[@"id"];
    };
}
#define dictForUIImageXXX(enumName)\
- (UIImage *(^)(void))dictFor##enumName\
{\
    return ^id(){\
        LinkHandle_REF(NSDictionary)\
        LinkGroupHandle_REF(dictFor##enumName)\
        return _self[enumName];\
    };\
}

dictForUIImageXXX(UIImagePickerControllerMediaType)
dictForUIImageXXX(UIImagePickerControllerLivePhoto)
dictForUIImageXXX(UIImagePickerControllerMediaMetadata)
dictForUIImageXXX(UIImagePickerControllerReferenceURL)
dictForUIImageXXX(UIImagePickerControllerMediaURL)
dictForUIImageXXX(UIImagePickerControllerCropRect)
dictForUIImageXXX(UIImagePickerControllerEditedImage)
dictForUIImageXXX(UIImagePickerControllerOriginalImage)
@end
