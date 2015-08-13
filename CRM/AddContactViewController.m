//
//  AddContactViewController.m
//  CRM
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "AddContactViewController.h"
#import "LayoutViewController.h"
#import "crmSoap.h"
#import "softUser.h"
#import "dateToString.h"

@interface AddContactViewController ()


@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;//公司名称标签
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;//创建人部门标签
@property (weak, nonatomic) IBOutlet UITextField *nameText;     //姓名

@property (weak, nonatomic) IBOutlet UITextField *sexText;      //性别
@property (weak, nonatomic) IBOutlet UITextField *companyText;  //公司
@property (weak, nonatomic) IBOutlet UITextField *positionText; //职位
@property (weak, nonatomic) IBOutlet UITextField *phoneText;    //电话
@property (weak, nonatomic) IBOutlet UITextField *telText;      //手机
@property (weak, nonatomic) IBOutlet UITextField *emailText;    //邮箱
@property (weak, nonatomic) IBOutlet UITextField *addrText;     //地址
@property (weak, nonatomic) IBOutlet UITextView  *remark;        //备注


@property (nonatomic,assign)int id;

@property (strong,nonatomic)crmSoap *soap;
@property(strong,nonatomic)NSDictionary *customerNameDic;//包涵一条客户(公司名称)姓名的信息
@property(strong,nonatomic)NSDictionary *departmentDic;//包涵一条部门的信息


- (IBAction)saveOfAddContactBtn:(id)sender;

@end


@implementation AddContactViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注册通知，当在detailVc中选择某个值时将发送这些通知，这边注册通知，接受传过来的数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetcustomerNameLabelValue:) name:@"Customer_Name" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SetDepartmentLabelLabelValue:) name:@"Department_Name" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    //    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"!" message:soapresult delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
    
    
}
-(void)doWhenHttpCollecttionFalil:(NSError *) error
{
    UIAlertView *alrtview=[[UIAlertView alloc]initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alrtview show];
}


-(void)SetcustomerNameLabelValue:(NSNotification *) notification
{
    _customerNameDic=(NSMutableDictionary *)[notification userInfo];
    self.customerNameLabel.text=[_customerNameDic objectForKey:@"Customer_Name"];
    
}

-(void)SetDepartmentLabelLabelValue:(NSNotification *) notification
{
    _departmentDic=(NSMutableDictionary *)[notification userInfo];
    self.departmentLabel.text=[_departmentDic objectForKey:@"Department_Name"];
}

#pragma -mark viewMethod
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}





//部门和公司有问题  生日是datetime还是string 职位也是
- (IBAction)saveOfAddContactBtn:(id)sender {
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate=self;
    //获取当前用户
    softUser *localUser=[softUser sharedLocaluserUserByDictionary:nil];
    NSString *departId=[_departmentDic objectForKey:@"Department_Id"];
    NSString *customerId=[_customerNameDic objectForKey:@"Customer_Id"];
    
    int uid=localUser.userId.intValue;
    NSString *uName=localUser.userName;
    NSString *cDate=[dateToString dateToString:[NSDate date]];
    //添加联系人的方法
    [_soap addContact:nil Name:_nameText.text customId:customerId.intValue userId:uid departmentId:departId.intValue  contactSex:_sexText.text contactBirth:_birthText.text contactPosition:_positionText.text contactPhone:_phoneText.text contactTel:_telText.text mail:_emailText.text Addr:_addrText.text Remark:_remark.text department:@"" cDate:cDate cPerson:uName mDate:cDate mPerson:uName getWhatInfo:@"添加联系人"];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LayoutViewController *layoutView=[mainstoryboard instantiateViewControllerWithIdentifier:@"layoutVC"];
        if (indexPath.row==3)
        {
            layoutView.getWhat=@"CustomerName";
        }
        [self.navigationController pushViewController:layoutView animated:YES];
        
    }
    if (indexPath.section==3) {
        LayoutViewController *deVc=[[LayoutViewController alloc]init];
        if (indexPath.row==0) {
            deVc.getWhat=@"Department";
        }
        [self.navigationController pushViewController:deVc animated:YES];
    }

}



#pragma -mark textfieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

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
