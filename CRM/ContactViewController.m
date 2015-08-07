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

@interface ContactViewController ()
@property (strong,nonatomic) NSMutableArray *dataOfContact;
@property (strong,nonatomic) NSMutableDictionary *contactOfDic;
@property (strong,nonatomic) crmSoap *soap;


@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate =self;
    softUser *localUser=[softUser sharedLocaluserUserByDictionary:nil];
#warning 通过用户id找到联系人的姓名
    [_soap getContactNameAndIdByUserId:localUser.userId];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult
{
    if ([soapresult isEqualToString:@"失败"]) {
         NSLog(@"我去");
        
    }else {
         NSLog(@"我去");
        //数据的编码格式
        NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        //解析数据
        NSMutableDictionary *contactOfDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        //把解析的数据给数组
        if (contactOfDic) {
            _dataOfContact=[contactOfDic objectForKey:@"result"];
            [self.tableView reloadData];
        }
    }
    
#warning 检查数据
}

-(void)doWhenHttpCollecttionFalil:(NSError *) error
{
     NSLog(@"我去111111");
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
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
