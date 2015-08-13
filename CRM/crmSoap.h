//
//  EcardSoap.h
//  EX_EcardSoap
//
//  Created by learner on 15-6-12.
//  Copyright (c) 2015年 learner. All rights reserved.
//



#import "crmDelegate.h"
#import <Foundation/Foundation.h>


@interface crmSoap : NSObject<NSXMLParserDelegate,NSURLConnectionDelegate>

@property(strong,nonatomic)NSString *getWhatInfo;//字符串代表着去网络上获取什么数据
@property(strong,nonatomic)id<crmDelegate> soapDelgate;
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSURLConnection *conn;

//验证用户账号密码
-(void)checkAccount:(NSString *)loginCount  Pwd:(NSString *)LooginPwd getWhatInfo:(NSString *)getwhatinfo;
//通过账号密码获取用户信息
-(void)getUserInfoByUserIdAndUserPWd:(NSString *)userId Pwd:(NSString *)pwd getWhatInfo:(NSString *)getwhatinfo;;
//通过用户id获取客户的姓名
-(void)getCustomerNameAndIdByUserId:(NSString *)userid getWhatInfo:(NSString *)getwhatinfo;

//通过用户id获取联系人的姓名
-(void)getContactNameAndIdByUserId:(NSString *)userid getWhatInfo:(NSString *)getwhatinfo;

//获取所有的部门
-(void)getAllDepartmentgetWhatInfo:(NSString *)getwhatinfo;

//获取所有的联系人姓名
-(void)getAllCustomerNamegetWhatInfo:(NSString *)getwhatinfo;

//联系人id获取联系人活动记录
-(void)getActivityRecordsByContactid:(int)contactId getWhatInfo:(NSString *)getwhatinfo;

//联系人id获取联系人信息
-(void)getContactInfoByContactId:(int)contactid getWhatInfo:(NSString *)getwhatinfo;

//通过id删除联系人
-(void)deleteContactById:(NSString *)contactId getWhatInfo:(NSString *)getwhatinfo;

//添加联系人的方法
-(void)addContact:(int) contactId Name:(NSString *)name  customId:(int)customId  userId:(int)uId departmentId:(int)departmentId contactSex:(NSString *)contactSex contactBirth:(NSString *)contactBirth contactPosition:(NSString *)contactPosition contactPhone:(NSString *)contactPhone contactTel:(NSString *)contactTel   mail:(NSString *)mail  Addr:(NSString *)addr Remark:(NSString *)remark department:(NSString *)department   cDate:(NSString *  )cdate cPerson:(NSString *)cperson mDate:(NSString *)mdate mPerson:(NSString *)mPerson getWhatInfo:(NSString *)getwhatinfo;

//修改联系人
-(void)updateContact:(int) contactId Name:(NSString *)name  customId:(int)customId  userId:(int)uId departmentId:(int)departmentId contactSex:(NSString *)contactSex contactBirth:(NSString *)contactBirth contactPosition:(NSString *)contactPosition contactPhone:(NSString *)contactPhone contactTel:(NSString *)contactTel   mail:(NSString *)mail  Addr:(NSString *)addr Remark:(NSString *)remark department:(NSString *)department   cDate:(NSString *  )cdate cPerson:(NSString *)cperson mDate:(NSString *)mdate mPerson:(NSString *)mPerson getWhatInfo:(NSString *)getwhatinfo;

//通过id查找部门
-(void)getdepartmentById:(NSString *)dId getWhatInfo:(NSString *)getwhatinfo;
//通过客户id查找客户姓名
-(void)getCustomerNameByid:(NSString *)cId getWhatInfo:(NSString *)getwhatinfo;












@end
