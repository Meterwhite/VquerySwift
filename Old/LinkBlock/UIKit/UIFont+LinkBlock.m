//
//  UIFont+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/11/2.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UIFontLinkBlock)

- (CGFloat (^)(NSUInteger))fontHeightWithLine
{
    return ^CGFloat(NSUInteger line){
        LinkHandle_VAL_IFNOT(UIFont){
            return 0.0;
        }
        LinkGroupHandle_VAL(fontHeightWithLine,line);
        if(line == 0) return 0.0;
        return line*[[[NSAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName:_self}] size].height;
    };
}

- (UIFont *(^)(id))fontSetToControl
{
    return ^id(id asControl){
        LinkHandle_REF(UIFont)
        LinkGroupHandle_REF(fontSetToControl,asControl)
        
        if(![asControl isKindOfClass:NSArray.class]){
            asControl = [NSArray arrayWithObject:asControl];
        }
        
        [asControl enumerateObjectsUsingBlock:^(id ctrl,NSUInteger idx,BOOL* stop) {
            
            if([ctrl isKindOfClass:UIButton.class])
                ctrl = [ctrl titleLabel];
            if([ctrl respondsToSelector:@selector(setFont:)])
               [ctrl setFont:_self];
        }];
        
        return _self;
    };
}
@end
