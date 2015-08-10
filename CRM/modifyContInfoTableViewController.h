//
//  modifyContInfoTableViewController.h
//  CRM
//
//  Created by Mac on 15/8/8.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "crmDelegate.h"

@interface modifyContInfoTableViewController : UITableViewController<crmDelegate,UITextFieldDelegate>

@property(strong,nonatomic)NSMutableDictionary *dicOfDepartment;//存取部门信息
@property(strong,nonatomic)NSMutableDictionary *dicOfcompanyName;//包涵一条客户(公司名称)姓名的信息
@property (strong,nonatomic) NSMutableDictionary *contactDic;
@end
