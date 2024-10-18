//
//  LinkPropertyInvocation.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/26.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkPropertyInvocation.h"
#import "LinkHelper.h"
#import "LinkBlock.h"
#import "LinkError.h"
#import "NSNil.h"

@interface LinkPropertyInvocation()
@property (nonatomic,strong) NSInvocation* invocation;
@property (nonatomic,copy) NSString* code;
@end

@implementation LinkPropertyInvocation
+ (instancetype)invocationWithCode:(NSString*)code
{
    return [[self alloc] initWithCode:code];
}

- (instancetype)initWithCode:(NSString*)code
{
    self = [super init];
    if (self) {
        NSMethodSignature* sig = [self methodSignatureForSelector:@selector(commandInvoke:)];
        self.invocation = [NSInvocation invocationWithMethodSignature:sig];
        self.invocation.target = self;
        self.invocation.selector = @selector(commandInvoke:);
        self.code = code;
    }
    return self;
}

- (id)commandInvoke:(id)target
{
    
    NSAssert([self.code isKindOfClass:[NSString class]], @"DynamicLink script must be objc string.");
    
    //new 命令
    NSRegularExpression* regexOfNew = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z_]+\\d*New" options:0 error:0];
    NSRange rangeOfMatch = [regexOfNew rangeOfFirstMatchInString:self.code options:0 range:NSMakeRange(0, self.code.length)];
    if(rangeOfMatch.length){
        NSString* clzName = [self.code substringWithRange:rangeOfMatch];
        clzName = clzName.strTrimRight(@"New");
        Class clzz = NSClassFromString(clzName);
        if(clzz){
            return [[clzz alloc] init];
        }else if([[[self linkBlockCommandReflectList] allKeys] containsObject:self.code]){
            return [[self linkBlockCommandReflectList] objectForKey:self.code];
        }
    }
    
    //硬编码的字面量
    if([[LinkHelper help:self.code] isCodeLinkBlockEncoded]){
        return [[LinkHelper help:self.code] valueFromLinkBlockEncodingCodeAction];
    }
    
    //类名
    Class clzz = NSClassFromString(self.code);
    if(clzz){
        return [NSValue valueWithBytes:&clzz objCType:@encode(Class)];
    }
    
    SEL sel = NSSelectorFromString(self.code);
    NSMethodSignature* sig = [target methodSignatureForSelector:sel];
    
CODE_PROPERTY_TYPE:{
    //直接响应方法
    if([target respondsToSelector:sel]){
        
    CODE_CALL_SIGNATURE:
        if(sig.numberOfArguments > 2 && LinkHelper.link_block_configuration_get_is_show_warning){
            NSLog(@"DynamicLink Warning:%@ has no return value.",self.code);
        };
        NSInvocation* invok = [NSInvocation invocationWithMethodSignature:sig];
        invok.selector = sel;
        [invok invokeWithTarget:target];
        __block id reV;
        [LinkHelper helpSwitchObjcType:sig.methodReturnType caseVoid:nil caseId:^{
            
            [invok getReturnValue:&reV];//会操作返回值引用计数器+1
            if(sel == @selector(alloc) ||
               sel == @selector(new)   ||
               sel == @selector(copy)  ||
               sel == @selector(mutableCopy)){
                //方法已经操作过返回值引用计数器
                return;
            }
            //使self持有该返回值
            CFBridgingRetain(reV);
        } caseClass:^{
            Class val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithBytes:&val objCType:@encode(Class)];
        } caseIMP:^{
            IMP val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithBytes:&val objCType:@encode(IMP)];
        } caseSEL:^{
            SEL val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithBytes:&val objCType:@encode(SEL)];
        } caseDouble:^{
            double val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithDouble:val];
        } caseFloat:^{
            float val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithFloat:val];
        } casePointer:^{
            SEL val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithBytes:&val objCType:@encode(void*)];
        } caseCharPointer:^{
            char* val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithBytes:&val objCType:@encode(char*)];
        } caseUnsignedLong:^{
            unsigned long val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithUnsignedLong:val];
        } caseUnsignedLongLong:^{
            unsigned long long val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithUnsignedLongLong:val];
        } caseLong:^{
            long val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithLong:val];
        } caseLongLong:^{
            long long val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithLongLong:val];
        } caseInt:^{
            int val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithInt:val];
        } caseUnsignedInt:^{
            unsigned int val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithUnsignedInt:val];
        } caseBOOL_Char_xyShort:^{
            int val;
            [invok getReturnValue:&val];
            reV = [NSNumber numberWithInt:val];
        } caseCGRect:^{
            CGRect val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithCGRect:val];
        } caseNSRange:^{
            NSRange val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithRange:val];
        } caseCGSize:^{
            CGSize val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithCGSize:val];
        } caseCGPoint:^{
            CGPoint val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithCGPoint:val];
        } caseCGVector:^{
            CGVector val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithCGVector:val];
        } caseUIEdgeInsets:^{
            UIEdgeInsets val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithUIEdgeInsets:val];
        } caseUIOffset:^{
            UIOffset val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithUIOffset:val];
        } caseCATransform3D:^{
            CATransform3D val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithCATransform3D:val];
        } caseCGAffineTransform:^{
            CGAffineTransform val;
            [invok getReturnValue:&val];
            reV = [NSValue valueWithCGAffineTransform:val];
        } caseNSDirectionalEdgeInsets:^{
            if (@available(iOS 11.0, *)) {
                NSDirectionalEdgeInsets val;
                [invok getReturnValue:&val];
                reV = [NSValue valueWithDirectionalEdgeInsets:val];
            }
        } defaule:^{
            NSLog(@"DynamicLink Error:Structure or union type is not supported");
        }];
        return reV;
    }
}

    if([target isKindOfClass:[NSValue class]]){
        const char* objcType = [target objCType];
        if(strcmp(objcType, @encode(Class)) == 0){
            //装箱的Clss
            Class val;
            [target getValue:&val];
            clzz = val;
            if([val respondsToSelector:sel]){
                sig = [val methodSignatureForSelector:sel];
                target = val;
                goto CODE_CALL_SIGNATURE;
            }
        }else if (strcmp(objcType, @encode(id)) == 0){
            //装箱的对象
            id val;
            [target getValue:&val];
            target = val;
            goto CODE_PROPERTY_TYPE;
        }
    }

    
    NSLog(@"DynamicLink Error:Unrecognized %@."
          ,self.code);
    return nil;
}

static NSDictionary* _linkBlockCommandReflectList;
- (NSDictionary*)linkBlockCommandReflectList
{
    if(!_linkBlockCommandReflectList){
        _linkBlockCommandReflectList = @{
                                         @"AttrDictNew":NSMutableDictionaryNew,
                                         @"NSNil":NSNil
                                         };
    }
    return _linkBlockCommandReflectList;
}

static NSArray* _linkBlockUsingListOfva_list;
- (NSArray*)linkBlockUsingListOfva_list
{
    if(!_linkBlockUsingListOfva_list){
        _linkBlockUsingListOfva_list = @[];
    }
    return _linkBlockUsingListOfva_list;
}


#pragma mark - override
- (id)invokeWithTarget:(id)target
{
    if(!NSEqualNil(target)){
        [self.invocation setArgument:&target atIndex:2];
    }
    
    [self.invocation invoke];
    
    id reV;
    [self.invocation getReturnValue:&reV];
    CFBridgingRetain(reV);
    return reV;
}
@end
