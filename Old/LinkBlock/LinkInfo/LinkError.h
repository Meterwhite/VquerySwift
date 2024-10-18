//
//  LinkError.h
//
//  Created by NOVO on 15/8/20.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

/**
 LinkError can response to unknown method and not crash.This feature make linkBlock more safe.When unknown method called it will do noting but log itself./
 可以响应未知方法而不崩溃，响应未知方法时会打印错误信息
 */
@interface LinkError : LinkInfo
@property (nonatomic,copy) NSString* needClass;
@property (nonatomic,copy) NSString* errorClass;
@property (nonatomic,copy) NSString* inFunc;

- (instancetype)initWithCustomDescription:(NSString*)cDescription;
+ (instancetype)errorWithCustomDescription:(NSString*)cDescription;
- (NSString *)description;
- (NSString *)debugDescription;
- (instancetype)logError;
@end
