//
//  NSBlackHole.h
//  LinkBlockProgram
//
//  Created by NOVO on 2017/12/28.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *黑洞对象
 *该对象响应任何消息但不崩溃；是具有nil性质的对象；因此与同样是nil装箱形式的对象NSNull具有完全互补的性质；
 *由于objc不能重载"=="，所以注意"NSBlackHole.value == nil"返回的是NO；使用"isEqual:"方法才能返回YES
 */
@interface NSBlackHole : NSProxy
+ (id)value;
@end
