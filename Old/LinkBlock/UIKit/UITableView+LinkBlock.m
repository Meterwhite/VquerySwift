//
//  UITableView+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/9/28.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UITableViewLinkBlock)
- (UITableView *(^)(id<UITableViewDelegate>))tab_viewDelegate
{
    return ^id(id<UITableViewDelegate> delegate){
        LinkHandle_REF(UITableView);
        LinkGroupHandle_REF(tab_viewDelegate,delegate);
        _self.delegate = delegate;
        return _self;
    };
}

- (UITableView *(^)(id<UITableViewDataSource>))tab_viewDataSource
{
    return ^id(id<UITableViewDataSource> dataSource){
        LinkHandle_REF(UITableView);
        LinkGroupHandle_REF(tab_viewDataSource,dataSource);
        _self.dataSource = dataSource;
        return _self;
    };
}

- (UITableView *(^)(BOOL))tab_viewShowsVertical
{
    return (id)self.scroll_viewShowsVertical;
}

- (UITableView *(^)(BOOL))tab_viewShowsHorizontal
{
    return (id)self.scroll_viewShowsHorizontal;
}

- (UITableView *(^)(void))tab_viewCellSeparatorStyleNone
{
    return ^id(void){
        LinkHandle_REF(UITableView);
        LinkGroupHandle_REF(tab_viewCellSeparatorStyleNone);
        _self.separatorStyle = UITableViewCellSeparatorStyleNone;
        return _self;
    };
}

- (UITableView *(^)(void))tab_viewCellSeparatorStyleSingleLine
{
    return ^id(void){
        LinkHandle_REF(UITableView);
        LinkGroupHandle_REF(tab_viewCellSeparatorStyleSingleLine);
        _self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return _self;
    };
}
@end
