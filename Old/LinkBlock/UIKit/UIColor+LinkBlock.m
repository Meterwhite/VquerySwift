//
//  UIColor+LinkBlock.m

//
//  Created by NOVO on 15/8/18.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//
#import "LinkBlock.h"

@implementation NSObject(UIColorLinkBlock)
- (NSString *(^)(NSString *))colorToHexStringWithPrefix
{
    return ^id(NSString* prefix){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorToHexStringWithPrefix,prefix)
        NSMutableString* reStr = [NSMutableString string];
        if([prefix isKindOfClass:[NSString class]]) [reStr appendString:prefix];
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            
            [reStr appendFormat:@"%02x",(int)(r*255.0)];
            [reStr appendFormat:@"%02x",(int)(g*255.0)];
            [reStr appendFormat:@"%02x",(int)(g*255.0)];
        }else{
            return [[LinkError errorWithCustomDescription:[NSString stringWithFormat:@"%@获取颜色时出错",_self]] logError];
        }
        return reStr.copy;
    };
}

- (UIImage *(^)(CGSize))colorToUIImage
{
    return ^id(CGSize size){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorToUIImage,size)
        UIGraphicsBeginImageContext(size);
        CGContextRef content = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(content, _self.CGColor);
        CGContextFillRect(content, CGRectMake(0, 0, size.width, size.height));
        UIImage* re = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return re;
    };
}

- (CGFloat (^)(void))colorRed
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorRed)
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            return r;
        }else{
            return 0.0;
        }
    };
}

- (CGFloat (^)(void))colorGreen
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorGreen)
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            return g;
        }else{
            return 0.0;
        }
    };
}

- (CGFloat (^)(void))colorBlue
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorBlue)
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            return b;
        }else{
            return 0.0;
        }
    };
}

- (CGFloat (^)(void))colorAlpha
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorAlpha)
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            return a;
        }else{
            return 1.0;
        }
    };
}

- (CGFloat (^)(void))colorHue
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorHue)
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat a;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&a]){
            return hue;
        }else{
            return 1.0;
        }
    };
}

- (CGFloat (^)(void))colorSaturation
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorSaturation)
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat a;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&a]){
            return saturation;
        }else{
            return 1.0;
        }
    };
}

- (CGFloat (^)(void))colorBrightness
{
    return ^CGFloat(){
        LinkHandle_VAL_IFNOT(UIColor){
            return 0.0;
        }
        LinkGroupHandle_VAL(colorBrightness)
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat a;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&a]){
            return brightness;
        }else{
            return 1.0;
        }
    };
}

- (UIColor* (^)(CGFloat))colorRedSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorRedSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            _self = [UIColor colorWithRed:value green:g blue:b alpha:a];
            return _self;
        }else{
            return _self;
        }
    };
}

- (UIColor* (^)(CGFloat))colorGreenSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorGreenSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            _self = [UIColor colorWithRed:r green:value blue:b alpha:a];
            return _self;
        }else{
            return _self;
        }
    };
}

- (UIColor* (^)(CGFloat))colorBlueSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorBlueSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            _self = [UIColor colorWithRed:r green:g blue:value alpha:a];
            return _self;
        }else{
            return _self;
        }
    };
}

- (UIColor* (^)(CGFloat))colorAlphaSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorAlphaSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat r;CGFloat g;CGFloat b;CGFloat a;
        if([_self getRed:&r green:&g blue:&b alpha:&a]){
            return [UIColor colorWithRed:r green:g blue:b alpha:value];
        }else{
            return _self;
        }
    };
}

- (UIColor *(^)(CGFloat))colorHueSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorHueSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat a;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&a]){
            return [UIColor colorWithHue:value saturation:saturation brightness:brightness alpha:a];
        }else{
            return _self;
        }
    };
}

- (UIColor *(^)(CGFloat))colorSaturationSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorSaturationSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat a;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&a]){
            return [UIColor colorWithHue:hue saturation:saturation brightness:value alpha:a];
        }else{
            return _self;
        }
    };
}

- (UIColor *(^)(CGFloat))colorBrightnessSet
{
    return ^id(CGFloat value){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorBrightnessSet,value)
        value = (value<0||value>1) ? 0.0 : value;
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat a;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&a]){
            return [UIColor colorWithHue:hue saturation:saturation brightness:value alpha:a];
        }else{
            return _self;
        }
    };
}


- (UIColor *(^)(id))colorSetToUIBackground
{
    return ^id(id obj){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorSetToUIBackground,obj)
        
        if([obj respondsToSelector:@selector(setBackgroundColor:)]){
            
            [obj setBackgroundColor:_self];
        }else if([obj respondsToSelector:@selector(objectEnumerator)]){
            
            NSEnumerator* enumerator = [obj objectEnumerator];
            id item;
            while ((item = enumerator.nextObject)) {
                [_self colorSetToUIBackground](item);
            }
        }
        
        return _self;
    };
}

- (UIColor *(^)(id))colorSetToUIText
{
    return ^id(id obj){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorSetToUIText,obj)
        
        if([obj respondsToSelector:@selector(setTextColor:)]){
            
            [obj setBackgroundColor:_self];
        }else if([obj respondsToSelector:@selector(setTitleColor:forState:)]){
            
            [obj setTitleColor:_self forState:UIControlStateNormal];
        }else if([obj respondsToSelector:@selector(objectEnumerator)]){
            
            NSEnumerator* enumerator = [obj objectEnumerator];
            id item;
            while ((item = enumerator.nextObject)) {
                [_self colorSetToUIText](item);
            }
        }
        
        return _self;
    };
}



- (UIColor *(^)(double))colorBrightnessPercent
{
    return ^id(double percent){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorBrightnessPercent,percent)
        CGFloat hue;CGFloat saturation;CGFloat brightness;CGFloat alpha;
        if([_self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]){
            
            brightness *= (1.0+percent);
            if(percent>0.0){//变亮
                
                brightness = brightness>1 ? 1.0 : brightness;
            }else if(percent <0.0){//变暗
                
                brightness = brightness<0.0 ? 0.0 : brightness;
            }else{
                
                return _self;
            }
            return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        }else{
            
            return _self;
        }
    };
}

- (UIColor *(^)(void))colorHighlightDarkColor
{
    return ^id(){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorHighlightDarkColor)
        return _self.colorBrightnessPercent(-0.4);
    };
}

- (UIColor *(^)(void))colorHighlightLightColor
{
    return ^id(){
        LinkHandle_REF(UIColor)
        LinkGroupHandle_REF(colorHighlightLightColor)
        return _self.colorBrightnessPercent(0.4);
    };
}

@end
