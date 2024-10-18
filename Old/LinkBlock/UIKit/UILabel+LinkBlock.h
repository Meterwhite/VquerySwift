//
//  UILabel+LinkBlock.h
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UILabelNew ([UILabel new])

@interface NSObject(UILabelLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK UILabel*         (^labAlignment)(NSTextAlignment alighment);
@property LB_BK UILabel*         (^labNumberOfLines)(NSInteger lines);
@property LB_BK UILabel*         (^labText)(NSString* txt);
@property LB_BK UILabel*         (^labTextColor)(UIColor* color);
@property LB_BK UILabel*         (^labFont)(UIFont* font);
@property LB_BK UILabel*         (^labFontSystemSizeSet)(CGFloat fontSize);
#pragma mark - Foundation Speed/速度
@property LB_BK UILabel*         (^labAlignmentCenter)(void);
@property LB_BK UILabel*         (^labAlignmentRight)(void);
@property LB_BK UILabel*         (^labAlignmentLeft)(void);
#pragma mark - Foundation Extend/补充
@property LB_BK CGFloat          (^labFontSystemSizeGet)(void);


#pragma mark - LinkBlock
/** 40% light than current titel */
@property LB_BK UILabel*         (^labHighlightedTextColorLightByTextColor)(void);
/** 40% darker than current titel */
@property LB_BK UILabel*         (^labHighlightedTextColorDarkByTextColor)(void);


@end

#pragma mark - LinkBlock
@interface UILabel(UILabelLinkBlock)
/**
 *  extend touch range
 */
@property LB_BK UILabel* (^labExtensionOfTouchSide)(UIEdgeInsets insets);
@property LB_BK UILabel* (^labExtensionOfTouchRects)(NSArray<NSString*>* rects);
@end
