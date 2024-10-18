//
//  UIStackView+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 2019/1/15.
//  Copyright © 2019 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UIStackViewNew ([UIStackView new])

@interface NSObject(UIStackViewLinkBlock)


#pragma mark Foundation Mirror/镜像


@property LB_BK UIStackView*       (^stackViewAxis)(UILayoutConstraintAxis axis);
@property LB_BK UIStackView*       (^stackViewDistribution)(UIStackViewDistribution distribution);
@property LB_BK UIStackView*       (^stackViewAlignment)(UIStackViewAlignment alignment);
@property LB_BK UIStackView*       (^stackViewSpacing)(CGFloat spacing);
/**
 asSubview ∈ {UIView* , NSArray*<UIView*>}
 */
@property LB_BK UIStackView*       (^stackViewAddArrangedSubview)(id asSubview);


#pragma mark - Foundation Speed/速度


@property LB_BK UIStackView*       (^stackViewAxisUILayoutConstraintAxisVertical)(void);
@property LB_BK UIStackView*       (^stackViewAxisUILayoutConstraintAxisHorizontal)(void);

/**
 'UIStackViewDistributionFill' - 'UI' ==> 'stackViewDistributionFill'
 */
@property LB_BK UIStackView*       (^stackViewDistributionFill)(void);
@property LB_BK UIStackView*       (^stackViewDistributionFillEqually)(void);
@property LB_BK UIStackView*       (^stackViewDistributionFillProportionally)(void);
@property LB_BK UIStackView*       (^stackViewDistributionEqualSpacing)(void);
@property LB_BK UIStackView*       (^stackViewDistributionEqualCentering)(void);

@property LB_BK UIStackView*       (^stackViewAlignmentFill)(void);
@property LB_BK UIStackView*       (^stackViewAlignmentLeadingOrTop)(void);
@property LB_BK UIStackView*       (^stackViewAlignmentFirstBaseline)(void);
@property LB_BK UIStackView*       (^stackViewAlignmentCenter)(void);
@property LB_BK UIStackView*       (^stackViewAlignmentTrailingOrBottom)(void);
@property LB_BK UIStackView*       (^stackViewAlignmentLastBaseline)(void);



#pragma mark - LinkBlock

#define stackViewAddArrangedSubviews(view0 , args...) \
    \
    (stackViewAddArrangedSubviews(view0 , ##args , nil))
@property LB_BK UIStackView*       (^stackViewAddArrangedSubviews)(UIView* view0 , ...);


@end
