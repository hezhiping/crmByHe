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

//当nib文件被加载的时候，会发送一个awakeFromNib的消息到xib文件中的每个对象
- (void)awakeFromNib
{
    //contactTableList.pilst中的value值对应数据库中的字段
    //加载plist列表的数据
    _arrayofSection=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"contactSection" ofType:@"plist"]];
    
   // NSLog(@"%lu",(unsigned long)_arrayofSection.count);
    
    _dicOfContactTable=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"contactTableList" ofType:@"plist" ]];
}

- (IBAction)updateContactInfoBtn:(id)sender {
    //发送一个名字为updateVCToModifyVC的通知到InspectContactDetailInfoViewController界面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateVCToModifyVC" object:nil userInfo:nil];
  
}

#pragma tableview协议的required方法
//group的头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //获取数组中secion的行放到一个字典中
    NSDictionary *dic=[_arrayofSection objectAtIndex:section];
    //再把字典中是sectionName的行取出来
    NSString *headerTitle=[dic objectForKey:@"sectionName"];
    return headerTitle;
}

//返回行
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _arrayofSection.count;
}
//返回secion中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic=[_arrayofSection objectAtIndex:section];
    NSArray *array=[dic objectForKey:@"sectionData"];
    return array.count;
}
//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //标识符
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSDictionary *dic=[_arrayofSection objectAtIndex:indexPath.section];
    NSArray *array=[dic objectForKey:@"sectionData"];
    //定义个字符串对象等于数组该行的数据
    NSString *mainStr=[array objectAtIndex:indexPath.row];
    cell.textLabel.text=mainStr;
    
    //自动获取负责人的姓名
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
