//
//  ContactViewController.m
//  CRM
//
//  Created by Mac on 15/8/4.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "ContactViewController.h"
#import "crmSoap.h"
#import "softUser.h"
#import "InspectContactDetailInfoViewController.h"

@interface ContactViewController ()
@property (strong,nonatomic) NSMutableArray *dataOfContact;
@property (strong,nonatomic) NSMutableDictionary *contactOfDic;
@property (strong,nonatomic) crmSoap *soap;
@property (strong,nonatomic) UIAlertView *myalertview;

@property(strong,nonatomic)NSString *deleteContactID;//删除联系人时联系人的id
@property(nonatomic,assign)int deleteTimes;//记录删除一条联系人信息供经过多少次，因为删除数据失败时会再次调用删除

@end

@implementation ContactViewController

-(void)deleteContactById:(NSString *)contact_Id
{
    crmSoap *soap=[[crmSoap alloc]init];
    soap.soapDelgate=self;
    [soap deleteContactById:contact_Id getWhatInfo:@"删除客户信息"];
    
}

-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat{
    if ([soapresult isEqualToString:@"失败"]) {
        if ([getwhat isEqualToString:@"获取联系人姓名和id"]) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"加载失败%@",soapresult] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
        }
    }
    if ([getwhat isEqualToString:@"删除联系人信息"]) {
        {//如果删除失败重新删除
#warning //设置删除失败多少次后应该做什么
            if (_deleteTimes>2) {//删除两次后还失败vaijiu取消删除
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"删除失败%@",soapresult] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
                [self getTableviewData];//重新获取数据，刷新tableview
            }
            else{
                [self deleteContactById:_deleteContactID];
                _deleteTimes++;//重新调用删除，所以调用次数加一
            }
        }
    }
    else
    {
        if ([getwhat isEqualToString:@"获取联系人姓名和id"])
        {
        
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *erro=nil;
            NSMutableDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&erro];
            if (dataDic)
            {
                 NSArray *dataA=[dataDic objectForKey:@"result"];
                _dataOfContact=[NSMutableArray arrayWithArray:dataA];
                [self.tableView reloadData];
            
            }
            else
            {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"" message:soapresult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
            }
        }
        if ([getwhat isEqualToString:@"删除客户信息"])
        {//删除成功
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"删除成功" message:soapresult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
        }
    }
    [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];
    

}

-(void)doWhenHttpCollecttionFalil:(NSError *) error{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"加载失败,网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertview show];
    [self.myalertview dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)getTableviewData
{
    softUser *localuser=[softUser sharedLocaluserUserByDictionary:nil];
    [_soap getContactNameAndIdByUserId:localuser.userId getWhatInfo:@"获取联系人姓名和id"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate =self;
    [self getTableviewData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //返回tableView的行数总数
    return self.dataOfContact.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        //设置cell的样式
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //定义一个字典，存放获取该行的信息
    NSDictionary *dataDic=[self.dataOfContact objectAtIndex:indexPath.row];
    
    //设置cell文本中的内容从数组中获取，在通过字典的key获取
    cell.textLabel.text=[dataDic objectForKey:@"Contact_Name"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //设置cell文本字体的大小
    // Configure the cell...
    
    return cell;
}

//选中的行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InspectContactDetailInfoViewController *inspectVC=[mainstoryboard instantiateViewControllerWithIdentifier:@"inspectVC"];
    NSDictionary *dic=[self.dataOfContact objectAtIndex:indexPath.row];
    NSString *contactid=[dic objectForKey:@"Contact_Id"];
    inspectVC.contactId=contactid.intValue;
    
    [self.navigationController pushViewController:inspectVC animated:YES];

}



//添加编辑模式
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
       return YES;
}


//删除测试
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSInteger row=indexPath.row;
        _deleteContactID=[[_dataOfContact objectAtIndex:indexPath.row]objectForKey:@"Contact_Id"];
        [self.dataOfContact removeObjectAtIndex:row];//先删除数组中数据，再删除行
        //调用删除数据方法
        [self deleteContactById:_deleteContactID];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}




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
