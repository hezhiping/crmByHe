//
//  softUser.h
//  CRM
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface softUser : NSObject
@property(strong,nonatomic)NSString *userId;
@property(strong,nonatomic)NSString *userName;
@property(strong,nonatomic)NSString *userAccount;
@property(strong,nonatomic)NSString *userPwd;
@property(strong,nonatomic)NSString *userPhotoUrl;
@property(strong,nonatomic)NSString *userEmail;
@property(strong,nonatomic)NSString *userPhone;
@property(strong,nonatomic)NSString *userDepartment;
@property(strong,nonatomic)NSString *userPosition;

//存取部门信息
@property(strong,nonatomic)NSMutableDictionary *dicOfDepartment;
//存储公司信息
@property(strong,nonatomic)NSMutableDictionary *dicOfCompanyName;



+(softUser *)sharedLocalUseruser:(NSString *)userId Account:(NSString *)account Pwd:(NSString *)pwd PhotoUrl:(NSString *)photoUrl Email:(NSString *)email Phone:(NSString *)phone Department:(NSString *)department Position:(NSString *)positon;
+(softUser *)sharedLocaluserUserByDictionary:(NSDictionary *) userDic;
@end
