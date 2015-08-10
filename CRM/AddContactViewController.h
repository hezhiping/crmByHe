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

@property (weak, nonatomic) IBOutlet UITextField *birthText;    //生日
@end
