//
//  LinkBlockProgramTests.m
//  LinkBlockProgramTests
//
//  Created by NOVO on 15/8/18.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LinkBlock.h"
#import "Person.h"
#import "Man.h"

@interface LinkBlockProgramTests : XCTestCase

@end

@implementation LinkBlockProgramTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
//    XCTAssert(YES, @"Pass");
    
    Man* m0 = Man.new;m0.name=@"AAA";m0.nickName=@"A";
    Man* m1 = Man.new;m1.name=@"BBB";m1.nickName=@"B";
    Man* m2 = Man.new;m2.name=@"CCC";m2.nickName=@"C";
    Man* m3 = Man.new;m3.name=@"DDD";m3.nickName=@"D";

    m0.objSetValueForFullPath(LBBoxValue(CGSizeMake(10, 12)), @"frame->size");
    m0.objSetScreenValueForFullPath(@"frame->size->width");
    
    m0.po();
    @"END".nslog();
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.

    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
    
}

@end


//        int i = 10000000;
//        while (i--) {
//            man.objSetValueForFullPath(@"AAA" , @"nickName");//7.070
//            man.objSetValueForKey(@"AAA" , @"nickName");//5.232
//            [man setValue:@"AAA" forKey:@"nickName"];//0.708
//            man.nickName = @"AAA";//0.141
//        }
