//
//  DynamicLinkArgument.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/15.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "DynamicLinkArgument.h"
#import "LinkHelper.h"
#import "NSNil.h"

@interface DynamicLinkArgument()

@end

@implementation DynamicLinkArgument

+ (instancetype)dynamicLinkArgumentFromVlueCode:(NSString *)code
{
    DynamicLinkArgument* _self = [[self alloc] initWithCode:code];
    if(!_self.validate) return nil;
    return _self;
}

- (instancetype)initWithCode:(NSString *)code
{
    self = [super init];
    if (self) {
        
        _stringValue = code;
        
        if(![code length] || [[code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
            //空白
            _validate = NO;
            _objcValue = nil;
        }else{
            
            _objcValue = [[LinkHelper help:code] valueFromValueCode];
            if(NSEqualNil(_objcValue)){
                NSLog(@"DynamicLink Error:unrecognized value %@！",code);
                _validate = NO;
            }else{
                _validate = YES;
            }
        }
    }
    return self;
}

- (const char *)objcType
{
    return _objcValue.objCType;
}

- (NSUInteger)index
{
    if(_indexPath.length == 2){
        return [_indexPath indexAtPosition:1];
    }
    return 0;
}



@end
