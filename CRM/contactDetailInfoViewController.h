//
//  contactDetailInfoViewController.h
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactDetailInfoViewController : UIView <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *detailInfoTableView;
- (IBAction)updateInfoBtn:(id)sender;

@property (strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)NSArray *arrayofSection;//dic中存放表节头的名字，和表中数据字段
@property(strong,nonatomic)NSDictionary *dicOfContactTable;//表中label标签所对应的字段，即tablecelll里对应哪个数据
@property(strong,nonatomic)NSMutableDictionary *dataDicOFContact;//接收网络传来的数据
@end
