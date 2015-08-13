//
//  dateToString.h
//  CRM
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class modifyContInfoTableViewController;


@interface dateToString : NSObject
+(NSString *)dateToString:(NSDate *)date;
+(NSDate *)webDateToString:(NSString *)dateString;
@end
