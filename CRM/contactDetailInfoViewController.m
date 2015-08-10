//
//  contactDetailInfoViewController.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "contactDetailInfoViewController.h"
#import "softUser.h"

@implementation contactDetailInfoViewController

- (void)awakeFromNib
{
    //contactTableList.pilst中的value值对应数据库中的字段
    _arrayofSection=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"contactSection" ofType:@"plist"]];
    
    NSLog(@"%lu",(unsigned long)_arrayofSection.count);
    
    _dicOfContactTable=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"contactTableList" ofType:@"plist" ]];
}

- (IBAction)updateContactInfoBtn:(id)sender {
    //发送一个名字为updateVCToModifyVC的通知到InspectContactDetailInfoViewController界面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateVCToModifyVC" object:nil userInfo:nil];
  
}

#pragma tableview协议的required方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic=[_arrayofSection objectAtIndex:section];
    NSString *headerTitle=[dic objectForKey:@"sectionName"];
    return headerTitle;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _arrayofSection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic=[_arrayofSection objectAtIndex:section];
    NSArray *array=[dic objectForKey:@"sectionData"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *dic=[_arrayofSection objectAtIndex:indexPath.section];
    NSArray *array=[dic objectForKey:@"sectionData"];
    NSString *mainStr=[array objectAtIndex:indexPath.row];
    cell.textLabel.text=mainStr;
    
    NSString *search=[_dicOfContactTable objectForKey:mainStr];
    if ([mainStr isEqualToString:@"负责人"]) {
        softUser *localuser=[softUser sharedLocaluserUserByDictionary:nil];
        cell.detailTextLabel.text=localuser.userName;
        return cell;
    }
    
    NSString *str=[_dataDicOFContact objectForKey:[_dicOfContactTable objectForKey:mainStr]];
    cell.detailTextLabel.text=str;
    return cell;
}



@end
