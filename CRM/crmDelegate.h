//
//  crmDelegate.h
//  CRM
//
//  Created by Mac on 15/8/3.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol crmDelegate <NSObject>
@required
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat;
-(void)doWhenHttpCollecttionFalil:(NSError *) error;

@end

