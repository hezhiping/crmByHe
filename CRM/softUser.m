//
//  softUser.m
//  CRM
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "softUser.h"

@implementation softUser
static softUser *LocalUser=nil;
+(softUser *)sharedLocalUseruser:(NSString *)userId Name:(NSString *)name  Account:(NSString *)account Pwd:(NSString *)pwd PhotoUrl:(NSString *)photoUrl Email:(NSString *)email Phone:(NSString *)phone Department:(NSString *)department Position:(NSString *)position{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        LocalUser=[[softUser alloc]init];
        LocalUser.userId=userId;
        LocalUser.userName=name;
        LocalUser.userAccount=account;
        LocalUser.userPwd=pwd;
        LocalUser.userPhotoUrl=photoUrl;
        LocalUser.userEmail=email;
        LocalUser.userPhone=phone;
        LocalUser.userDepartment=department;
        LocalUser.userPosition=position;
    });
    
    return LocalUser;
}
+(softUser *)sharedLocaluserUserByDictionary:(NSDictionary *)userDic{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        LocalUser=[[softUser alloc]init];
        LocalUser.userId=[userDic objectForKey:@"User_Id"];
        LocalUser.userAccount=[userDic objectForKey:@"Login_Count"];
        LocalUser.userName=[userDic objectForKey:@"User_Name"];
        LocalUser.userPwd=[userDic objectForKey:@"Login_Password"];
        LocalUser.userPhotoUrl=[userDic objectForKey:@"User_Photo"];
        LocalUser.userEmail=[userDic objectForKey:@"Email"];
        LocalUser.userPhone=[userDic objectForKey:@"Phone_Number"];
        LocalUser.userDepartment=[userDic objectForKey:@"Department_Id"];
        LocalUser.userPosition=[userDic objectForKey:@"Position"];
    });
    
    return LocalUser;

}
@end
