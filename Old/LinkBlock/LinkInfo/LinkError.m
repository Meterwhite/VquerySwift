//
//  LinkError.m
//
//  Created by NOVO on 15/8/20.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import "LinkHelper.h"
#import "NSNil.h"

@interface LinkError ()
@property (nonatomic,copy) NSString* customDescription;
@end

@implementation LinkError
- (NSString *)description
{
    if(self.customDescription){
        return [NSString stringWithFormat:@"[LinkError]:%@,throwCount=%@",self.customDescription,@(self.throwCount)];
    }
    return [NSString stringWithFormat:@"[LinkError]:调用方法\"%@\"时需要类型\"%@\"而不是类型\"%@\"，在链条的倒数第\"%@\"处发生",self.inFunc,self.needClass,self.errorClass,@(self.throwCount+1)];
}

- (NSString *)debugDescription
{
    if(self.customDescription){
        return [NSString stringWithFormat:@"[LinkError]:%@,throwCount=%@",self.customDescription,@(self.throwCount)];
    }
    return [NSString stringWithFormat:@"[LinkError]:throwCount=%@,needClass=%@,errorClass=%@,inFunc=%@",@(self.throwCount),self.needClass,self.errorClass,self.inFunc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _needClass = @"ObjectCType";
        _errorClass = @"nil";
        _inFunc = @"linkObj";
        _infoType = LinkInfoError;
    }
    return self;
}

- (instancetype)initWithCustomDescription:(NSString*)cDescription
{
    if(self = [self init]){
        _customDescription = cDescription;
    }
    return self;
}

+ (instancetype)errorWithCustomDescription:(NSString *)cDescription
{
    return [[LinkError alloc] initWithCustomDescription:cDescription];
}

- (instancetype)logError
{
    NSLog(@"%@", [self description]);
    return self;
}


- (id)forwardingTargetForSelector:(SEL)aSelector
{
    [self logError];
    return NSNil;
}
@end
