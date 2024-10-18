//
//  NSValue+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/7.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import "LinkHelper.h"

@implementation NSObject(NSValueLinkBlock)

- (BOOL (^)(void))valueIsBlank
{
    
    if([self isKindOfClass:[NSNumber class]]){
        return self.numIsZero;
    }
    
    return ^BOOL(){
        
        __block BOOL result = NO;
        LinkHandle_VAL_IFNOT(NSValue){
            return result;
        }
        LinkGroupHandle_VAL(valueIsBlank)
        
        const char* ocType = _self.objCType;
        result = YES;
        [LinkHelper helpSwitchObjcType:ocType caseVoid:nil caseId:^{
            void* val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseClass:^{
            Class val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseIMP:^{
            IMP val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseSEL:^{
            SEL val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseDouble:^{
            double val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseFloat:^{
            float val;
            [_self getValue:&val];
            if(val) result = NO;
        } casePointer:^{
            CGPoint val;
            [_self getValue:&val];
            if(CGPointEqualToPoint(val, CGPointZero)) result = NO;
        } caseCharPointer:^{
            char* val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseUnsignedLong:^{
            unsigned long val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseUnsignedLongLong:^{
            unsigned long long val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseLong:^{
            long val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseLongLong:^{
            long long val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseInt:^{
            int val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseUnsignedInt:^{
            unsigned int val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseBOOL_Char_xyShort:^{
            int val;
            [_self getValue:&val];
            if(val) result = NO;
        } caseCGRect:^{
            CGRect val;
            [_self getValue:&val];
            if(!CGRectEqualToRect(val, CGRectZero)) result = NO;
        } caseNSRange:^{
            NSRange val;
            [_self getValue:&val];
            if(!NSEqualRanges(val, NSMakeRange(0, 0))) result = NO;
        } caseCGSize:^{
            CGSize val;
            [_self getValue:&val];
            if(!CGSizeEqualToSize(val, CGSizeZero)) result = NO;
        } caseCGPoint:^{
            CGPoint val;
            [_self getValue:&val];
            if(!CGPointEqualToPoint(val, CGPointZero)) result = NO;
        } caseCGVector:^{
            CGVector val;
            [_self getValue:&val];
            if(val.dx || val.dy) result = NO;
        } caseUIEdgeInsets:^{
            UIEdgeInsets val;
            [_self getValue:&val];
            if(!UIEdgeInsetsEqualToEdgeInsets(val, UIEdgeInsetsZero)) result = NO;
        } caseUIOffset:^{
            UIOffset val;
            [_self getValue:&val];
            if(!UIOffsetEqualToOffset(val, UIOffsetZero)) result = NO;
        } caseCATransform3D:^{
            CATransform3D val;
            [_self getValue:&val];
            if(!CATransform3DEqualToTransform(val, CATransform3DIdentity)) result = NO;
        } caseCGAffineTransform:^{
            CGAffineTransform val;
            [_self getValue:&val];
            if(!CGAffineTransformEqualToTransform(val, CGAffineTransformIdentity)) result = NO;
        } caseNSDirectionalEdgeInsets:^{
            if (@available(iOS 11.0, *)) {
                
                NSDirectionalEdgeInsets val;
                [_self getValue:&val];
                if(!NSDirectionalEdgeInsetsEqualToDirectionalEdgeInsets(val, NSDirectionalEdgeInsetsZero)) result = NO;
            }
        } defaule:nil];
        
        return result;
    };
}

- (NSNumber *(^)(void))valueIsNumberAs
{
    return ^id(){
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(objIsNumberAs)
        
        if([self isKindOfClass:[NSNumber class]]){
            return @YES;
        }
        const char* objcType = _self.objCType;
        
        if(strcmp(objcType, @encode(double)) == 0 ||
           strcmp(objcType, @encode(float)) == 0 ||
           strcmp(objcType, @encode(unsigned long)) == 0 ||
           strcmp(objcType, @encode(unsigned long long)) == 0 ||
           strcmp(objcType, @encode(long)) == 0 ||
           strcmp(objcType, @encode(long long)) == 0 ||
           strcmp(objcType, @encode(int)) == 0 ||
           strcmp(objcType, @encode(unsigned int)) == 0 ||
           strcmp(objcType, @encode(BOOL)) == 0 ||
           strcmp(objcType, @encode(bool)) == 0 ||
           strcmp(objcType, @encode(char)) == 0 ||
           strcmp(objcType, @encode(short)) == 0 ||
           strcmp(objcType, @encode(unsigned char)) == 0 ||
           strcmp(objcType, @encode(unsigned short)) == 0
           ){
            return @YES;
        }
        
        return @NO;
    };
}

- (NSNumber *(^)(void))valueIsStructAs
{
    return ^id(){
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueIsStructAs)
        
        if([self isKindOfClass:[NSNumber class]]){
            return @NO;
        }
        
        //{structName=typeOfContents}
        const char* objcType = _self.objCType;
        unsigned long len = strlen(objcType);
        
        //Class = #
        if(len==1 && objcType[0]=='#') return @YES;
        //limit {*=*}
        if(len<5) return @NO;
        //check {*}
        if(objcType[0]!='{' || objcType[len-1]!='}') return @NO;
        //check *=*
        unsigned long idxOfEq = 0;
        for (unsigned long i=1; i<len-1; i++) {
                
            if(objcType[i] == '='){
                idxOfEq = i;
                break;
            }
        }
        return [NSNumber numberWithBool:(idxOfEq>1 && idxOfEq<len-2)];
    };
}

- (NSValue *(^)(NSString *))valueStructValueForKeyPath
{
    return ^id(NSString* keyPath){
        
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueStructValueForKeyPath,keyPath)
        
        NSArray* pathNodes = [keyPath componentsSeparatedByString:@"."];
        
        if(pathNodes.count == 0) {//only key
            
        CALL_RET_NSNULL:
            
            return NSNull.null;
        }
        
        NSDictionary* pathMap = [LinkHelper link_block_struct_value_path_get_map];
        NSDictionary* currentMap = pathMap[@(_self.objCType)];
        
        if(!currentMap) goto CALL_RET_NSNULL;//wrong path
        
        NSString* currentPath = pathNodes.firstObject;
        
        NSValue*(^worker)(NSValue* value)  = currentMap[currentPath];
        
        NSValue* newValue = worker(_self);
        
        if(pathNodes.count == 1)    return newValue;
        
        NSUInteger dotIdx = [keyPath rangeOfString:@"."].location + 1;
        
        if(dotIdx >= keyPath.length) goto CALL_RET_NSNULL;///next path wrong
        
        NSString* nextPath = [keyPath substringFromIndex:dotIdx];
        return newValue.valueStructValueForKeyPath(nextPath);
    };
}

- (NSValue *(^)(id, NSString *))valueStructSetValueForKeyPath
{
    return ^id(id value,NSString* keyPath){
        
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueStructSetValueForKeyPath,value,keyPath)
        
        NSArray* pathNodes = [keyPath componentsSeparatedByString:@"."];
        if(pathNodes.count == 0) return _self;
        
        NSString* currentPath = pathNodes.firstObject;
        NSDictionary* pathMapOfGet = [LinkHelper link_block_struct_value_path_get_map];
        NSDictionary* currentMapOfGet = pathMapOfGet[@(_self.objCType)];
        
        if(!currentMapOfGet) return _self;//next path is wrong
        ///worker of get current path value
        NSValue*(^workerOfGet)(NSValue* value)  = currentMapOfGet[currentPath];
        NSValue* currentPathValue = workerOfGet(_self);
        
        ///worker of modify value for self
        NSDictionary* pathMapOfSet = [LinkHelper link_block_struct_value_path_set_map];
        NSDictionary* currentMapOfSet = pathMapOfSet[@(_self.objCType)];
        NSValue*(^workerOfSet)(NSValue* _self,id value)  = currentMapOfSet[currentPath];
        
        NSUInteger dotIdx = [keyPath rangeOfString:@"."].location;
        if(dotIdx == NSNotFound){
            ///It means in the last.
            return workerOfSet(_self,value);
        }
        
        ///Need modify struct value,will modify by traversal
        if(dotIdx >= keyPath.length-1) return _self;///next path wrong like
        
        NSString* nextPath = [keyPath substringFromIndex:dotIdx + 1];
        NSValue* newValue = currentPathValue.valueStructSetValueForKeyPath(value, nextPath);
        return workerOfSet(_self,newValue);
    };
}

- (NSUInteger (^)(void))valueNSRangeLocation
{
    return ^NSUInteger(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0;
        }
        LinkGroupHandle_VAL(valueNSRangeLocation)
        return [_self rangeValue].location;
    };
}

- (NSUInteger (^)(void))valueNSRangeLength
{
    return ^NSUInteger(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0;
        }
        LinkGroupHandle_VAL(valueNSRangeLength)
        return [_self rangeValue].length;
    };
}

- (CGFloat (^)(void))valueCGPointX
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGPointX)
        return [_self CGPointValue].x;
    };
}

- (CGFloat (^)(void))valueCGPointY
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGPointY)
        return [_self CGPointValue].y;
    };
}

#ifndef defineValueCGRect
#define defineValueCGRect(suffix)\
- (CGFloat (^)(void))valueCGRect##suffix\
{\
    return ^CGFloat(){\
        LinkHandle_VAL_IFNOT(NSValue){\
            return 0.0;\
        }\
        LinkGroupHandle_VAL(valueCGRect##suffix)\
        return CGRectGet##suffix([_self CGRectValue]);\
    };\
}
#endif

defineValueCGRect(MinX)
defineValueCGRect(MidX)
defineValueCGRect(MaxX)
defineValueCGRect(MinY)
defineValueCGRect(MidY)
defineValueCGRect(MaxY)
defineValueCGRect(Width)
defineValueCGRect(Height)

- (NSNumber *(^)(CGRect))valueCGRectContainsRect
{
    return ^id(CGRect rect){
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueCGRectContainsRect,rect)
        return @(CGRectContainsRect([_self CGRectValue], rect));
    };
}

- (NSNumber *(^)(CGPoint))valueCGRectContainsPoint
{
    return ^id(CGPoint point){
        LinkHandle_REF(NSValue)
        LinkGroupHandle_REF(valueCGRectContainsPoint,point)
        return @(CGRectContainsPoint([_self CGRectValue], point));
    };
}

- (CGFloat (^)(void))valueCGRectX
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGRectX)
        return [_self CGRectValue].origin.x;
    };
}

- (CGFloat (^)(void))valueCGRectY
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGRectY)
        return [_self CGRectValue].origin.y;
    };
}

- (CGFloat (^)(void))valueCGSizeWidth
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGSizeWidth)
        return [_self CGSizeValue].width;
    };
}

- (CGFloat (^)(void))valueCGSizeHeight
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGSizeHeight)
        return [_self CGSizeValue].height;
    };
}

- (CGPoint (^)(void))valueCGRectOrigin
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSValue){
            return CGPointZero;
        }
        LinkGroupHandle_VAL(valueCGRectOrigin)
        return [_self CGRectValue].origin;
    };
}

- (CGSize (^)(void))valueCGRectSize
{
    return ^(){
        LinkHandle_VAL_IFNOT(NSValue){
            return CGSizeZero;
        }
        LinkGroupHandle_VAL(valueCGRectSize)
        return [_self CGRectValue].size;
    };
}

- (CGFloat (^)(void))valueCGVectorX
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGVectorX)
        return [_self CGVectorValue].dx;
    };
}

- (CGFloat (^)(void))valueCGVectorY
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(NSValue){
            return 0.0;
        }
        LinkGroupHandle_VAL(valueCGVectorY)
        return [_self CGVectorValue].dy;
    };
}

@end
