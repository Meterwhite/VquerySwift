//
//  LinkReturn.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/9/23.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkReturn.h"

@implementation LinkReturn
- (instancetype)init
{
    self = [super init];
    if (self) {
        _infoType = LinkInfoReturn;
        _returnType = LinkReturnLink;
        _condition = LinkConditionNon;
    }
    return self;
}
- (instancetype)initWithReturnValue:(id)returnValue
{
    if(self = [self init]){
        _returnValue = returnValue;
    }
    return self;
}
- (instancetype)initWithReturnValue:(id)returnValue returnType:(LinkReturnType)returnType
{
    if(self = [self initWithReturnValue:returnValue]){
        _returnType = returnType;
        if(returnType == LinkReturnCondition){
            _condition = LinkConditionIF;
        }
    }
    return self;
}

- (instancetype)initWithReturnValue:(id)returnValue returnType:(LinkReturnType)returnType conditionType:(LinkConditionType)conditionType
{
    if(self = [self initWithReturnValue:returnValue]){
        _returnType = returnType;
        _condition = conditionType;
    }
    return self;
}
@end
