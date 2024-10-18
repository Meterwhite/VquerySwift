//
//  UIFont+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/11/2.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UIFontNew(size) ([UIFont systemFontOfSize:size])

@interface NSObject(UIFontLinkBlock)

#pragma mark - Weak coding/弱类型编码

@property LB_BK UIFont*       (^fontSetToControl)(id asControl);

#pragma mark - LinkBlock
@property LB_BK CGFloat       (^fontHeightWithLine)(NSUInteger line);

@end
