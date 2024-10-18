//
//  ViewController.m
//
//  Created by NOVO on 15/8/18.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "ViewController.h"
#import "LinkBlock.h"
#import "Person.h"
#import "Man.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    @"arrAddObj(Man.alloc.init.copy.tall).arrAddObj().arrAddObj().arrAddObj()"
    .linkCodeEval(NSMutableArrayNew,@"ABC",[NSObject new]).nslog();
    //There is a missing parameter here, the console will report a warning
    //这里缺少一个参数，控制台会报警告
}
@end
