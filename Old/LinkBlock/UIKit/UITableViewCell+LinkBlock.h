//
//  UITableViewCell+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 2019/1/22.
//  Copyright © 2019 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

@interface NSObject(UITableViewCellLinkBlock)
#pragma mark - Foundation Speed/速度
@property LB_BK UITableViewCell* (^tab_cellSelectionStyleNone)(void);
@property LB_BK UITableViewCell* (^tab_cellSelectionStyleBlue)(void);
@property LB_BK UITableViewCell* (^tab_cellSelectionStyleGray)(void);
@property LB_BK UITableViewCell* (^tab_cellSelectionStyleDefault)(void);
@end
