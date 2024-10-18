//
//  DynamicLink.m
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/15.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkObject.h"
#import "DynamicLink.h"
#import "DynamicLinkAction.h"
#import "DynamicLinkArgument.h"
#import "LinkHelper.h"
#import "NSNil.h"

@interface DynamicLink()
@property (nonatomic,strong) NSMutableArray<DynamicLinkAction*>* items;
@end

@implementation DynamicLink

- (id)invoke:(id)origin args:(va_list*)list
{
    //无code返回对象本身
    if(!self.code) return origin;
    
    //包装起始对象
    origin = _LB_MakeObj(origin);
    
    BOOL isEnd = NO;
    id currentOrigin = origin;
    for (NSUInteger idx_action = 0; idx_action < self.countOfItems; idx_action++) {
        
        DynamicLinkAction* action = self.items[idx_action];
        currentOrigin = [action invoke:currentOrigin args:list end:&isEnd];
        if(NSEqualNil(currentOrigin) && idx_action<self.countOfItems-1){
            //void返回值类型或未知返回值类型后不能再调用
            currentOrigin = [LinkError errorWithCustomDescription:[NSString stringWithFormat:@"DynamicLink Error:%@不可接受的返回类型；动态链条的解析在第%@处断裂，其后无法调用！",self.items[idx_action].actionName,@(idx_action+1)]];
            break;
        }
    }
    
    return currentOrigin;
}

#pragma mark - 构造
- (instancetype)initWithCode:(NSString*)code
{
    self = [super init];
    if (self) {
        
        _code = [[LinkHelper help:code] linkBlockEncodingNSStringAndNSNumberFromCode];
        
        NSArray* actionStrings = [[LinkHelper help:_code] actionCommandSplitFromLinkCode];
        [actionStrings enumerateObjectsUsingBlock:^(NSString*  _Nonnull blockString, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //构造block
            DynamicLinkAction* dyLinkBlock = [DynamicLinkAction dynamicLinkBlockWithCode:blockString index:idx];
            if(NSEqualNil(dyLinkBlock)){
                
                if(LinkHelper.link_block_configuration_get_is_show_warning){
                    NSLog(@"DynamicLink Warning:Unable to parse %@; the parsing of the dynamic link breaks at index %@, and the call will stop.",blockString,@(idx+1));
                }
                *stop = YES;
                return;
            }
            [self.items addObject:dyLinkBlock];
        }];
    }
    return self;
}
+ (instancetype)dynamicLinkWithCode:(NSString *)code
{
    return [[self alloc] initWithCode:code];
}
- (NSUInteger)countOfItems
{
    return self.items.count;
}
- (DynamicLinkAction *)blockAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger idx = [indexPath indexAtPosition:0];
    if(idx > self.items.count-1 ) return nil;
    return self.items[idx];
}
- (DynamicLinkArgument *)argumentAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicLinkAction* block = [self blockAtIndexPath:indexPath];
    if(NSEqualNil(block)) return nil;
    return  [block argumentAtIndexPath:indexPath];
}
- (NSMutableArray<DynamicLinkAction *> *)items
{
    if(!_items){
        _items = [NSMutableArray new];
    }
    return _items;
}
@end
