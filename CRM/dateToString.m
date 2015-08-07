//
//  dateToString.m
//  CRM
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "dateToString.h"
#import "AddContactViewController.h"

@implementation dateToString
+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestring=[dateformat stringFromDate:date];
    return datestring;
}


 
@end
