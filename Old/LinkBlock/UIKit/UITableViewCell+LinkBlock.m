//
//  UITableViewCell+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 2019/1/22.
//  Copyright © 2019 NOVO. All rights reserved.
//

#import "LinkBlock.h"

@implementation NSObject(UITableViewCellLinkBlock)

#define lb_tab_cellSelectionStyle(symbol)\
\
- (UITableViewCell *(^)(void))tab_cellSelectionStyle##symbol\
{\
    return ^id(void){\
        LinkHandle_REF(UITableViewCell)\
        LinkGroupHandle_REF(tab_cellSelectionStyle##symbol)\
        \
        _self.selectionStyle = UITableViewCellSelectionStyle##symbol;\
        return _self;\
    };\
}

lb_tab_cellSelectionStyle(None)
lb_tab_cellSelectionStyle(Blue)
lb_tab_cellSelectionStyle(Gray)
lb_tab_cellSelectionStyle(Default)
@end
