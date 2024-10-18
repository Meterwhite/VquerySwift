//
//  Person.m
//  LinkBlockProgram
//
//  Created by NOVO on 16/8/24.
//  Copyright © 2016年 NOVO. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize sex = _sex;

- (instancetype)initWithSex:(BOOL)sex
{
    if(self = [self init]){
        self->_sex = sex;
    }
    return self;
}

- (NSNumber *)tall
{
    if(!_tall){
        _tall = @170;
    }
    return _tall;
}

- (void)say
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
}
- (void)say2
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
}
- (NSString*)myNameIs
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
    return NSStringFromSelector(_cmd);
}
- (NSString*)answerQuestion:(NSString*)question
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
    return [NSString stringWithFormat:@"I dont konw %@",question];
}
- (NSString*)answerQuestion:(NSString*)question question2:(NSString*)question2
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
    return [NSString stringWithFormat:@"I dont konw %@ + %@ ",question,question2];
}

- (NSString*)answerQuestion:(NSString*)question question2:(NSString*)question2 question3:(NSString*)question3
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
    return [NSString stringWithFormat:@"I dont know %@ + %@ + %@",question,question2,question3];
}
- (double)compute:(double)num1 num2:(double)num2
{
    NSLog(@"call %@", NSStringFromSelector(_cmd));
    return num1+num2;
}
@end
