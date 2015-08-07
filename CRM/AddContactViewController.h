//
//  AddContactViewController.h
//  CRM
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "crmDelegate.h"

@interface AddContactViewController : UITableViewController <UITextFieldDelegate,crmDelegate>
@property(strong,nonatomic)NSDictionary *customerNameDic;//包涵一条客户(公司名称)姓名的信息
@property (weak, nonatomic) IBOutlet UITextField *birthText;    //生日
@end
