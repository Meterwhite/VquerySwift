//
//  UITextView+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/8/16.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UITextViewLinkBlock)
- (UITextView *(^)(NSTextAlignment))txtViewTextAlignment
{
    return ^id(NSTextAlignment alignment){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewTextAlignment,alignment)
        _self.textAlignment = alignment;
        return _self;
    };
}
- (UITextView *(^)(NSRange))txtViewSelectRangeSet
{
    return ^id(NSRange range){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewSelectRangeSet,range)
        
        UITextPosition* beginning = _self.beginningOfDocument;
        UITextPosition* startPosition = [_self positionFromPosition:beginning offset:range.location];
        UITextPosition* endPosition = [_self positionFromPosition:beginning offset:range.location + range.length];
        UITextRange* selectionRange = [_self textRangeFromPosition:startPosition toPosition:endPosition];
        [_self setSelectedTextRange:selectionRange];
        return _self;
    };
}

- (NSRange (^)(void))txtViewSelectRangeGet
{
    return ^NSRange(){
        LinkHandle_VAL_IFNOT(UITextView){
            return NSMakeRange(NSNotFound, 0);
        }
        LinkGroupHandle_VAL(txtViewSelectRangeGet)
        
        UITextPosition* beginning = _self.beginningOfDocument;
        UITextRange* selectedRange = _self.selectedTextRange;
        UITextPosition* selectionStart = selectedRange.start;
        UITextPosition* selectionEnd = selectedRange.end;
        
        const NSInteger location = [_self offsetFromPosition:beginning toPosition:selectionStart];
        const NSInteger length = [_self offsetFromPosition:selectionStart toPosition:selectionEnd];
        return NSMakeRange(location, length);
    };
}

- (UITextView *(^)(BOOL))txtViewEditable
{
    return ^id(BOOL b){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewEditable,b)
        _self.editable = b;
        return _self;
    };
}

- (UITextView *(^)(BOOL))txtViewSelectable
{
    return ^id(BOOL b){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewSelectable,b)
        _self.selectable = b;
        return _self;
    };
}

- (UITextView *(^)(NSString *))txtViewText
{
    return ^id(NSString* text){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewText,text)
        _self.text = text;
        return _self;
    };
}

- (UITextView *(^)(NSAttributedString *))txtViewAttributedText
{
    return ^id(NSAttributedString* attributedText){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewAttributedText,attributedText)
        _self.attributedText = attributedText;
        return _self;
    };
}

- (UITextView *(^)(UIColor *))txtViewTextColor
{
    return ^id(UIColor* textColor){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewTextColor,textColor)
        _self.textColor = textColor;
        return _self;
    };
}

-(UITextView *(^)(UIFont *))txtViewFont
{
    return ^id(UIFont* font){
        LinkHandle_REF(UITextView)
        LinkGroupHandle_REF(txtViewFont,font)
        _self.font = font;
        return _self;
    };
}

@end
