//
//  UITextField+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/1/29.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UITextFieldLinkBlock)

- (UITextField* (^)(UIColor *))txtFieldPlaceholdColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldPlaceholdColor,color)
        [_self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        return _self;
    };
}

- (UITextField *(^)(NSRange))txtFieldSelectRangeSet
{
    return ^id(NSRange range){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldSelectRangeSet,range)
        UITextPosition* beginning = _self.beginningOfDocument;
        UITextPosition* startPosition = [_self positionFromPosition:beginning offset:range.location];
        UITextPosition* endPosition = [_self positionFromPosition:beginning offset:range.location + range.length];
        UITextRange* selectionRange = [_self textRangeFromPosition:startPosition toPosition:endPosition];
        [_self setSelectedTextRange:selectionRange];
        return _self;
    };
}

- (NSRange (^)(void))txtFieldSelectRangeGet
{
    return ^NSRange(){
        LinkHandle_VAL_IFNOT(UITextField){
            return NSMakeRange(NSNotFound, 0);
        }
        LinkGroupHandle_VAL(txtFieldSelectRangeGet)
        
        UITextPosition* beginning = _self.beginningOfDocument;
        UITextRange* selectedRange = _self.selectedTextRange;
        UITextPosition* selectionStart = selectedRange.start;
        UITextPosition* selectionEnd = selectedRange.end;
        
        const NSInteger location = [_self offsetFromPosition:beginning toPosition:selectionStart];
        const NSInteger length = [_self offsetFromPosition:selectionStart toPosition:selectionEnd];
        
        return NSMakeRange(location, length);
    };
}

- (UITextField *(^)(NSString *))txtFieldText
{
    return ^id(NSString* text){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldText,text)
        _self.text = text;
        return _self;
    };
}

- (UITextField *(^)(NSAttributedString *))txtFieldAttributedText
{
    return ^id(NSAttributedString* attributedText){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldAttributedText,attributedText)
        _self.attributedText = attributedText;
        return _self;
    };
}

- (UITextField *(^)(UIColor *))txtFieldTextColor
{
    return ^id(UIColor* textColor){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldTextColor,textColor)
        _self.textColor = textColor;
        return _self;
    };
}

-(UITextField *(^)(UIFont *))txtFieldFont
{
    return ^id(UIFont* font){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldFont,font)
        _self.font = font;
        return _self;
    };
}

- (UITextField *(^)(NSTextAlignment))txtFieldTextAlignment
{
    return ^id(NSTextAlignment alignment){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldTextAlignment,alignment)
        _self.textAlignment = alignment;
        return _self;
    };
}

- (UITextField *(^)(NSString *))txtFieldPlaceholder
{
    return ^id(NSString* placeholder){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldPlaceholder,placeholder)
        _self.placeholder = placeholder;
        return _self;
    };
}

- (UITextField *(^)(NSAttributedString *))txtFieldAttributedPlaceholder
{
    return ^id(NSAttributedString* attributedPlaceholder){
        LinkHandle_REF(UITextField)
        LinkGroupHandle_REF(txtFieldAttributedPlaceholder,attributedPlaceholder)
        _self.attributedPlaceholder = attributedPlaceholder;
        return _self;
    };
}

@end
