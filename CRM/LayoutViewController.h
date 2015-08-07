//
//  LayoutViewController.h
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "crmDelegate.h"

@interface LayoutViewController : UITableViewController<crmDelegate>
@property(strong,nonatomic)NSString *getWhat;//判断该视图是显示那种类型数据


@end
