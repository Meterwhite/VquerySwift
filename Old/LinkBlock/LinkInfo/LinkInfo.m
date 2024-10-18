//
//  LinkInfo.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/7/12.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "LinkBlock.h"
#import "LinkHelper.h"

@implementation LinkInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        _throwCount=0;
        _infoType = LinkInfoNone;
    }
    return self;
}

- (NSMutableDictionary *)userInfo
{
    if(!_userInfo){
        _userInfo = [NSMutableDictionary new];
    }
    return _userInfo;
}

- (void)cleanUserInfo
{
    [self.userInfo removeAllObjects];
}

+ (void)linkBlockWarningClose
{
    [LinkHelper link_block_configuration_set_is_show_warning:NO];
}
+ (void)linkBlockWarningOpen
{
    [LinkHelper link_block_configuration_set_is_show_warning:YES];
}
@end
