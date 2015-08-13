//
//  modifyContInfoTableViewController.m
//  CRM
//
//  Created by Mac on 15/8/8.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "modifyContInfoTableViewController.h"
#import "LayoutViewController.h"
#import "crmSoap.h"
#import "softUser.h"
#import "dateToString.h"

@interface modifyContInfoTableViewController ()


@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;//公司名称标签
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;//创建人部门标签
@property (weak, nonatomic) IBOutlet UITextField *nameText;     //姓名
@property (weak, nonatomic) IBOutlet UITextField *birthText;    //生日
@property (weak, nonatomic) IBOutlet UITextField *sexText;      //性别
@property (weak, nonatomic) IBOutlet UITextField *positionText; //职位
@property (weak, nonatomic) IBOutlet UITextField *phoneText;    //电话
@property (weak, nonatomic) IBOutlet UITextField *telText;      //手机
@property (weak, nonatomic) IBOutlet UITextField *emailText;    //邮箱
@property (weak, nonatomic) IBOutlet UITextField *addrText;     //地址
@property (weak, nonatomic) IBOutlet UITextView *remark;//备注


@property (strong,nonatomic) crmSoap *soap;
@property (strong,nonatomic) NSString *departmentId;
@property (strong,nonatomic) NSString *companyNameId;
@property (strong,nonatomic) NSString *customerName;


@property(strong,nonatomic)NSDictionary *departmentDic;//包涵一条部门的信息
@property(strong,nonatomic)NSDictionary *companyDic;//包涵一条公司名称
@end

@implementation modifyContInfoTableViewController

- (IBAction)updateContactInfo:(id)sender
{

    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate=self;
    
    NSString *dateTostr=[_contactDic objectForKey:@"Contact_Birth"];
    NSDate *birDate=[dateToString webDateToString:dateTostr];
    NSString *dateStr=[dateToString dateToString:birDate];
    
    NSString *contId=[_contactDic objectForKey:@"Contact_Id"];
    softUser *localuser=[softUser sharedLocaluserUserByDictionary:nil];
    int userid=localuser.userId.intValue;
    NSString *cdate=[dateToString dateToString:[NSDate date]];
    //更新数据的方法
    [_soap updateContact:contId.intValue Name:_nameText.text customId:_companyNameId.intValue userId:userid  departmentId:_departmentId.intValue  contactSex:_sexText.text contactBirth:dateStr contactPosition:_positionText.text contactPhone:_phoneText.text contactTel:_telText.text mail:_emailText.text Addr:_addrText.text Remark:_remark.text department:@"" cDate:cdate cPerson:localuser.userName  mDate:cdate mPerson:localuser.userName getWhatInfo:@"修改联系人"];
    
}

#pragma -mark crmdelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat
{
    if (![soapresult isEqualToString:@"失败"])
    {
        if ([getwhat isEqualToString:@"更新数据"])
        {
            if ([soapresult isEqualToString:@"成功"])
            {
                UIAlertView *alrtview=[[UIAlertView alloc]initWithTitle:nil message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alrtview show];
            }
            else{
                UIAlertView *alrtview=[[UIAlertView alloc]initWithTitle:@"修改失败" message:soapresult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alrtview show];
            }

        }
        if ([getwhat isEqualToString:@"获取一个公司名称"])
        {
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            _dicOfcompanyName=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
           
            _companyNameLabel.text=[_dicOfcompanyName objectForKey:@"Customer_Name"];
            _companyNameId=[_dicOfcompanyName objectForKey:@"Custom_Id"];
            [self displayView:_contactDic];
            
        }
        if ([getwhat isEqualToString:@"获取一个部门名称"]) {
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            _dicOfDepartment=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            _departmentLabel.text=[_dicOfDepartment objectForKey:@"Department_Name"];
            _departmentId=[_dicOfDepartment objectForKey:@"Department_Id"];
            [self displayView:_contactDic];
        }

    }
}
-(void)doWhenHttpCollecttionFalil:(NSError *) error
{
    NSString *str=[error localizedDescription];
    UIAlertView *alrtview=[[UIAlertView alloc]initWithTitle:@"修改失败" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alrtview show];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _departmentId=[_contactDic objectForKey:@"Department_Id"];
#warning <#message#>
    _companyNameId=[_contactDic objectForKey:@"Custom_Id"];
    _customerName=[_dicOfcompanyName objectForKey:@"Customer_Name"];

    //判断本地用户对象中的部门信息是否为空，若为空则取网络上请求，若不为空则不请求
    if (!_companyNameId)
    {
        crmSoap *soap1=[[crmSoap alloc]init];
        soap1.soapDelgate=self;
        NSString *str1=[_contactDic objectForKey:@"Custom_Id"];
        NSLog(@"%@",[_contactDic description]);
        _companyNameId=str1;
        [soap1 getCustomerNameByid:str1 getWhatInfo:@"获取一个公司名称"];
    }
    
    
    if (!_departmentId)
    {
        crmSoap *soap2=[[crmSoap alloc]init];
        soap2.soapDelgate=self;
        NSString *str2=[_contactDic objectForKey:@"Custom_Id"];
        _departmentId=str2;
        [soap2 getCustomerNameByid:str2 getWhatInfo:@"获取一个部门名称"];
    }
    
    //注册通知，接收LayoutViewController发送过来的通知=接收通知,当选择某个值时将发送这些通知，这边注册通知，接受传过来的数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetcompanyNameLabelValue:) name:@"Customer_Name" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetDepartmentLabelLabelValue:) name:@"Department_Name" object:nil];
    [self displayView:_contactDic];
}

#pragma -mark 设置公司名称，部门label的值
-(void)SetcompanyNameLabelValue:(NSNotification *) notification
{
//    _dicOfcompanyName=(NSMutableDictionary *)[notification userInfo];
    _companyNameLabel.text=[[notification userInfo]  objectForKey:@"Customer_Name"];
    NSLog(@"%@",[_dicOfcompanyName description]);
    _companyNameId=[[notification userInfo] objectForKey:@"Customer_Id"];
    
   
    
}

-(void)SetDepartmentLabelLabelValue:(NSNotification *) notification
{

//    _dicOfDepartment=(NSMutableDictionary *)[notification userInfo];
    _departmentLabel.text=[[notification userInfo] objectForKey:@"Department_Name"];
    _departmentId=[[notification userInfo] objectForKey:@"Department_Id"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//将详细资料界面的联系人资料展示到tableview 上
-(void)displayView:(NSMutableDictionary *)dic
{
    if (_companyNameId) {
        _companyNameLabel.text=_companyNameId;
    }
    
    //_companyNameLabel.text=[_dicOfcompanyName objectForKey:@"Customer_Id"];
    if (_departmentId) {
        _departmentLabel.text=_departmentId;
    }
//    _departmentLabel.text=[_dicOfDepartment objectForKey:@"Department_Id"];
    _nameText.text=[dic objectForKey:@"Contact_Name"];
    _birthText.text=[dic objectForKey:@"Contact_Birth"];
    _sexText.text=[dic objectForKey:@"Contact_Sex"];
    _positionText.text=[dic objectForKey:@"Contact_Position"];
    _phoneText.text=[dic objectForKey:@"Contact_Phone"];
    _telText.text=[dic objectForKey:@"Contact_Tel"];
    _emailText.text=[dic objectForKey:@"Contact_mail "];
    _addrText.text=[dic objectForKey:@"Contact_Addr"];
    _remark.text=[dic objectForKey:@"Remark"];
    
}

#pragma -mark table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        LayoutViewController *layoutVC=[[LayoutViewController alloc]init];
        if (indexPath.row==3) {
            layoutVC.getWhat=@"CustomerName";
            [self.navigationController pushViewController:layoutVC animated:YES];
        }
    }
    if (indexPath.section==3) {
        LayoutViewController *layoutVC=[[LayoutViewController alloc]init];
        if (indexPath.row==0) {
            layoutVC.getWhat=@"Department";
            [self.navigationController pushViewController:layoutVC animated:YES];
        }    }
}


#pragma -mark  textFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
