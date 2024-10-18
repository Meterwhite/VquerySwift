//
//  NSIndexPath+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/8.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(NSIndexPathLinkBlock)

- (NSIndexPath *(^)(NSUInteger))idxPathAdding
{
    return ^id(NSUInteger idx){
        LinkHandle_REF(NSIndexPath)
        LinkGroupHandle_REF(idxPathAdding,idx)
        [_self indexPathByAddingIndex:idx];
        return _self;
    };
}

- (NSIndexPath *(^)(void))idxPathRemovingLast
{
    return ^id(){
        LinkHandle_REF(NSIndexPath)
        LinkGroupHandle_REF(idxPathRemovingLast)
        [_self indexPathByRemovingLastIndex];
        return _self;
    };
}

- (NSUInteger (^)(NSUInteger))idxPathIndexAtPosition
{
    return ^NSUInteger(NSUInteger position){
        LinkHandle_VAL_IFNOT(NSIndexPath)
        LinkGroupHandle_VAL(idxPathIndexAtPosition,position){
            return 0;
        }
        return [_self indexAtPosition:position];
    };
}

- (NSArray *(^)(void))idxPathToNSArray
{
    return ^(){
        LinkHandle_REF(NSIndexPath)
        LinkGroupHandle_REF(idxPathToNSArray)
        
        NSMutableArray* re = [NSMutableArray new];
        for (NSUInteger i = 0; i < _self.length; i++) {
            [re addObject:@([_self indexAtPosition:i])];;
        }
        return re.copy;
    };
}

- (NSString *(^)(void))idxPathToNSStringUsingJson
{
    return self.idxPathToNSArray().objToJsonString;
}

- (BOOL (^)(NSInteger))idxPathIsEqualRow
{
    return ^BOOL(NSInteger row){
        LinkHandle_VAL_IFNOT(NSIndexPath)
        LinkGroupHandle_VAL(idxPathIsEqualRow,row){
            return NO;
        }
        return _self.row == row;
    };
}
- (BOOL (^)(NSInteger))idxPathIsEqualSection
{
    return ^BOOL(NSInteger section){
        LinkHandle_VAL_IFNOT(NSIndexPath)
        LinkGroupHandle_VAL(idxPathIsEqualSection,section){
            return NO;
        }
        return _self.section == section;
    };
}
- (BOOL (^)(NSInteger))idxPathIsEqualItem
{
    return ^BOOL(NSInteger item){
        LinkHandle_VAL_IFNOT(NSIndexPath)
        LinkGroupHandle_VAL(idxPathIsEqualItem,item){
            return NO;
        }
        return _self.item == item;
    };
}
@end
