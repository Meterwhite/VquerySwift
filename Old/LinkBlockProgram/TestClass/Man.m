//
//  Man.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/8/24.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "Man.h"
#import "LinkBlock.h"

@implementation Man

- (void)dealloc
{
    @"Man call dealloc".nslog();
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[[self class] alloc] init];
//    return self;
}

//- (id)copy
//{
//    @"Man call copy".nslog();
//    return [super copy];
//}
@end
