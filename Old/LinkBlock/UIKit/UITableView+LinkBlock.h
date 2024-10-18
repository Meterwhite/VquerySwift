//
//  UITableView+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 16/9/28.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UITableViewNew ([UITableView new])
@interface NSObject(UITableViewLinkBlock)

#pragma mark - Foundation Mirror/镜像

@property LB_BK UITableView*       (^tab_viewDelegate)(id<UITableViewDelegate> delegate);
@property LB_BK UITableView*       (^tab_viewDataSource)(id<UITableViewDataSource> datasource);
@property LB_BK UITableView*       (^tab_viewShowsHorizontal)(BOOL b);
@property LB_BK UITableView*       (^tab_viewShowsVertical)(BOOL b);

#pragma mark - Foundation Speed/速度
@property LB_BK UITableView*       (^tab_viewCellSeparatorStyleNone)(void);
@property LB_BK UITableView*       (^tab_viewCellSeparatorStyleSingleLine)(void);

@end
