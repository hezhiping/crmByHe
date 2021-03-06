//
//  LayoutViewController.m
//  CRM
//
//  Created by Mac on 15/8/6.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "LayoutViewController.h"
#import "AddContactViewController.h"
#import "softUser.h"
#import "crmSoap.h"

@interface LayoutViewController ()

@property (strong,nonatomic)crmSoap *soap;
@property (strong,nonatomic)NSMutableArray *arrayOfResult;//多条信息数据数组，每个数组都是字典
@property (strong,nonatomic)NSMutableDictionary *dataDic;
@property (strong,nonatomic)UIAlertView *myalertview;
@property (strong,nonatomic) softUser *user;



@end

@implementation LayoutViewController

#pragma -mark crmdelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat{
    if ([soapresult isEqualToString:@"失败"]) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"加载失败" message: soapresult delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
    }
    else{
        NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
        NSError *erro=nil;
        NSMutableDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&erro];
        if (dataDic) {
            _arrayOfResult=[dataDic objectForKey:@"result"];

            
            //将获取到的数据存到用户对象中去
            if ([self.getWhat isEqualToString:@"CompanyName"]) {
                _user.dicOfCompanyName=dataDic;
            }
            if ([self.getWhat isEqualToString:@"Department"]) {
                _user.dicOfDepartment=dataDic;
            }
            
            [self.tableView reloadData];
        }
        else{
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"" message:soapresult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        }
    }
    [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)doWhenHttpCollecttionFalil:(NSError *)error{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"加载失败,网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertview show];
    [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];
}

//显示push过来的界面内容并选择
//修改界面的选择信息
- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[softUser sharedLocaluserUserByDictionary:nil];
    
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate=self;
    //显示客户姓名
    if ([self.getWhat isEqualToString:@"CustomerName"]) {
        if (_user.dicOfCompanyName) {
            _arrayOfResult=[_user.dicOfCompanyName objectForKey:@"result"];
        }else{
            [_soap getAllCustomerNamegetWhatInfo:@"获取一个公司名称"];
        }
        
    }
    
    //显示部门
    if ([self.getWhat isEqualToString:@"Department"]) {
        if (_user.dicOfDepartment) {
            _arrayOfResult=[_user.dicOfDepartment objectForKey:@"result"];
        }
        else{
            [_soap getAllDepartmentgetWhatInfo:@"获取所有的部门"];
        }
    }
    
    if (!(_user.dicOfDepartment&&_user.dicOfCompanyName)) {
        self.myalertview=[[UIAlertView alloc]initWithTitle:@"" message:@"正在加载...." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [self.myalertview show];
        [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];

    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma -mark tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.getWhat isEqualToString:@"CustomerName"]) {
        NSDictionary *dic=[self.arrayOfResult objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Customer_Name" object:self userInfo:dic];
    }
    
    
    if ([self.getWhat isEqualToString:@"Department"]) {
        NSDictionary *dic=[self.arrayOfResult objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Department_Name" object:self userInfo:dic];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrayOfResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier ];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    if ([self.getWhat isEqualToString:@"CustomerName"])  {
        NSDictionary *dic=[self.arrayOfResult objectAtIndex:indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"Customer_Name"];
    }
    
    if ([self.getWhat isEqualToString:@"Department"]) {
        NSDictionary *dic=[self.arrayOfResult objectAtIndex:indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"Department_Name"];
    }

    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
