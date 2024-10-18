//
//  NSIndexPath+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/8.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define NSIndexPathNew(idx) ([NSIndexPath indexPathWithIndex:idx])

@interface NSObject(NSIndexPathLinkBlock)

#pragma mark - Foundation Mirror/镜像
@property LB_BK NSIndexPath*      (^idxPathAdding)(NSUInteger idx);
@property LB_BK NSIndexPath*      (^idxPathRemovingLast)(void);
@property LB_BK NSUInteger        (^idxPathIndexAtPosition)(NSUInteger position);

#pragma mark - Foundation Speed/速度
@property LB_BK BOOL              (^idxPathIsEqualSection)(NSInteger section);
@property LB_BK BOOL              (^idxPathIsEqualRow)(NSInteger row);
@property LB_BK BOOL              (^idxPathIsEqualItem)(NSInteger item);

#pragma mark - LinkBlock
@property LB_BK NSArray*          (^idxPathToNSArray)(void);
@property LB_BK NSString*         (^idxPathToNSStringUsingJson)(void);


@end
