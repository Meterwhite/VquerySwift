//
//  LinkGroup.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/7/12.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation LinkGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        _infoType = LinkInfoGroup;
    }
    return self;
}

- (NSMutableArray<NSObject*> *)linkObjects
{
    if(!_linkObjects){
        _linkObjects = [NSMutableArray new];
    }
    return _linkObjects;
}

+ (LinkGroup *)groupWithObjs:(id)obj, ...
{
    
    LinkGroup* re = [LinkGroup new];
    if(!obj) return re;
    
    NSMutableArray* objs = [NSMutableArray new];
    [objs addObject:obj];
    
    va_list args;
    va_start(args, obj);
    id parmObj;
    while ((parmObj = va_arg(args, id))) {
        [objs addObject:parmObj];
    }
    va_end(args);
    
    [re.linkObjects addObjectsFromArray:objs];
    return re;
}

+ (LinkGroup*)groupWithObjs:(id)obj0 args:(va_list)args
{
    NSMutableArray* objs = [NSMutableArray new];
    id parmObj = obj0;
    [objs addObject:parmObj];
    while ((parmObj = va_arg(args, id))) {
        [objs addObject:parmObj];
    }
    return [self groupWithArr:objs];
}

+ (LinkGroup *)groupWithArr:(NSArray *)obj
{
    LinkGroup* re = [LinkGroup new];
    [re.linkObjects addObjectsFromArray:obj];
    return re;
}

+ (LinkGroup*)group
{
    return [LinkGroup new];
}
@end
