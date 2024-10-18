//
//  LinkReturn.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/9/23.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkInfo.h"

typedef enum LinkReturnType{
    LinkReturnLink,//Force interruption/硬中断
    LinkReturnCondition,//Conditional interruption/软中断
}LinkReturnType;

typedef enum LinkConditionType{
    LinkConditionNon,
    LinkConditionIF,
    LinkConditionELSE,
}LinkConditionType;

@interface LinkReturn : LinkInfo
@property (nonatomic,strong) id returnValue;
@property (nonatomic,assign) LinkReturnType returnType;
@property (nonatomic,assign,readonly) LinkConditionType condition;


/**
 Case LinkReturnCondition Default condition is LinkConditionIF
 */
- (instancetype)initWithReturnValue:(id)returnValue;

/**
 Case LinkReturnCondition Default condition is LinkConditionIF
 */
- (instancetype)initWithReturnValue:(id)returnValue returnType:(LinkReturnType)returnType;

- (instancetype)initWithReturnValue:(id)returnValue returnType:(LinkReturnType)returnType conditionType:(LinkConditionType)conditionType;
@end
