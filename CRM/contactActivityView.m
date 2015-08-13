//
//  contactActivityView.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "contactActivityView.h"

@implementation contactActivityView


#pragma tableview的基本属性(数据源协议)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //有几个group就return几
    return 1;
}

//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //section里面的行数等于数组中的总数
    if (_dataArray) {
        return _dataArray.count;
    }
    return 1;
}

//请求时提供一个单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //给cell定义个标识符
    static NSString *identifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //取数组中的字典
    NSMutableDictionary *dic=[_dataArray objectAtIndex:indexPath.row];
    //在字典中取的活动记录的文本
    cell.textLabel.text=[dic objectForKey:@"Activity_Content"];
    
    return cell;
    
}


@end
