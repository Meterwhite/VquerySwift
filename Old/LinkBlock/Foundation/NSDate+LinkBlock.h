//
//  NSDate+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 15/9/3.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#ifndef NSDateNew
#define NSDateNew ([NSDate date])
#endif
@interface NSObject(NSDateLinkBlock)
#pragma mark - Foundation Mirror/镜像

@property LB_BK NSNumber*        (^dateTimeIntervalSince1970As)(void);
@property LB_BK NSDateComponents*(^dateComponentsAll)(void);

#pragma mark - Foundation Speed/速度
@property LB_BK NSInteger      (^dateYear)(void);
@property LB_BK NSNumber*      (^dateYearAs)(void);
@property LB_BK NSInteger      (^dateMonth)(void);
@property LB_BK NSNumber*      (^dateMonthAs)(void);
@property LB_BK NSInteger      (^dateDay)(void);
@property LB_BK NSNumber*      (^dateDayAs)(void);
@property LB_BK NSInteger      (^dateHour)(void);
@property LB_BK NSNumber*      (^dateHourAs)(void);
@property LB_BK NSInteger      (^dateMinut)(void);
@property LB_BK NSNumber*      (^dateMinutAs)(void);
@property LB_BK NSInteger      (^dateSec)(void);
@property LB_BK NSNumber*      (^dateSecAs)(void);
/// Calculate the time difference/计算时间差
/** self-date */
@property LB_BK NSInteger      (^dateMinusYear)(NSDate* date);
@property LB_BK NSInteger      (^dateMinusMonth)(NSDate* date);
@property LB_BK NSInteger      (^dateMinusDay)(NSDate* date);
@property LB_BK NSInteger      (^dateMinusHour)(NSDate* date);
@property LB_BK NSInteger      (^dateMinusMinut)(NSDate* date);
@property LB_BK NSInteger      (^dateMinusSec)(NSDate* date);
/// modify date/修改时间
@property LB_BK NSDate*        (^dateAddTimeInterval)(NSTimeInterval timeInterval);
@property LB_BK NSDate*        (^dateAddYear)(NSInteger year);
@property LB_BK NSDate*        (^dateAddMonth)(NSInteger month);
@property LB_BK NSDate*        (^dateAddDay)(NSInteger day);
@property LB_BK NSDate*        (^dateAddHour)(NSInteger hour);
@property LB_BK NSDate*        (^dateAddMinut)(NSInteger minut);
@property LB_BK NSDate*        (^dateAddSec)(NSInteger sec);

@property LB_BK NSDate*        (^dateSetYear)(NSInteger year);
@property LB_BK NSDate*        (^dateSetMonth)(NSInteger month);
@property LB_BK NSDate*        (^dateSetDay)(NSInteger day);
@property LB_BK NSDate*        (^dateSetHour)(NSInteger hour);
@property LB_BK NSDate*        (^dateSetMinut)(NSInteger minut);
@property LB_BK NSDate*        (^dateSetSec)(NSInteger sec);


#pragma mark - Foundation Extend/补充

#pragma mark - Weak coding/弱类型编码
/** formatStr=yyyy-MM-dd */
@property LB_BK NSString*        (^dateToStrWithFormat)(NSString* formatStr);

#pragma mark - LinkBlock
/** 中文的星座描述 */
@property LB_BK NSString*        (^dateToStrAstrologyzh_CN)(void);
/** get start time of day from the date.GMT,24-Hour */
@property LB_BK NSDate*          (^dateDayAtStart)(void);
/** get end time of day from the date.GMT,24-Hour */
@property LB_BK NSDate*          (^dateDayAtEnd)(void);
/** get current zone date by added difference from GMT/补充了相对GMT的时区差的日期 */
@property LB_BK NSDate*          (^dateCurrentZone)(void);
/** 闰年 */
@property LB_BK BOOL             (^dateIsLeapYear)(void);
@property LB_BK NSNumber*        (^dateIsLeapYearAs)(void);

@property LB_BK BOOL             (^dateIsInToday)(void);
@property LB_BK NSNumber*        (^dateIsInTodayAs)(void);

@property LB_BK BOOL             (^dateIsInMonth)(void);
@property LB_BK NSNumber*        (^dateIsInMonthAs)(void);

@end
