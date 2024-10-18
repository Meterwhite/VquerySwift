//
//  UIScrollView+LinkBlock.h
//
//  Created by NOVO on 15/8/29.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"


#define UIScrollViewNew ([UIScrollView new])

@interface NSObject(UIScrollViewLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK UIScrollView*        (^scroll_viewContentSize)(CGFloat w , CGFloat h);
@property LB_BK UIScrollView*        (^scroll_viewContentInserts)(CGFloat top , CGFloat left , CGFloat bottom , CGFloat right);
@property LB_BK UIScrollView*        (^scroll_viewContentOffset)(CGFloat w , CGFloat h);
@property LB_BK UIScrollView*        (^scroll_viewDelegate)(id<UIScrollViewDelegate> delegate);
@property LB_BK UIScrollView*        (^scroll_viewShowsHorizontal)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewShowsVertical)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewBounce)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewPagingEnabled)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewScrollEnabled)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewDelaysContentTouches)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewCanCancelContentTouches)(BOOL b);
@property LB_BK UIScrollView*        (^scroll_viewDirectionalLockEnabled)(BOOL b);


@end
