//
//  LinkGroup.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/7/12.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

typedef NS_OPTIONS(NSUInteger, LinkGroupHandleType) {
    LinkGroupHandleTypeNone                 = 0,
};

@interface LinkGroup : LinkInfo
@property (nonatomic,strong) NSMutableArray<NSObject*>* linkObjects;

+ (LinkGroup*)group;
+ (LinkGroup*)groupWithObjs:(id)obj,...;
+ (LinkGroup*)groupWithObjs:(id)obj0 args:(va_list)args;
+ (LinkGroup*)groupWithArr:(NSArray*)obj;
@end
