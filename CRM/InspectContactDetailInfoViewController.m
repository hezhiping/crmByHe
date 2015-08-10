//
//  InspectContactDetailInfoViewController.m
//  CRM
//
//  Created by Mac on 15/8/7.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "InspectContactDetailInfoViewController.h"
#import "contactActivityView.h"
#import "contactDetailInfoViewController.h"
#import "crmSoap.h"
#import "softUser.h"
#import "modifyContInfoTableViewController.h"

@interface InspectContactDetailInfoViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
//空白的view，用来显示数据
@property (weak, nonatomic) IBOutlet UIView *blankDataView;
@property (strong,nonatomic) contactActivityView *activityView;//活动记录view
@property (strong,nonatomic) contactDetailInfoViewController *detailInfoView;//详细信息

@property (strong,nonatomic)NSMutableArray *activitiesArrary;
@property(strong,nonatomic)NSMutableDictionary *activitysDIc;
@property(strong,nonatomic)crmSoap *soap1;
@property(strong,nonatomic)crmSoap *soap2;
@property (strong,nonatomic)NSMutableDictionary *contactDic;

@end

@implementation InspectContactDetailInfoViewController

- (IBAction)changDataSegment:(UISegmentedControl *)sender {
    
    switch (self.mySegment.selectedSegmentIndex) {
        case 0:
        {
            _detailInfoView.hidden=YES;
            _activityView.hidden=NO;
            break;
        }
        case 1:
        {
            _detailInfoView.hidden=NO;
            _activityView.hidden=YES;
            
        }
        default:
            break;
    }
    CATransition *animation=[CATransition animation];
    
    animation.type=@"cube"; //cube rotate
    animation.duration=0.7;
    //把空白的view加入到动画中
    [self.blankDataView.layer addAnimation:animation forKey:nil];
}

//通知的方法
-(void)updateVCToModifyVC
{
    if (_contactDic)
    {
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        modifyContInfoTableViewController *updateVC=[mainStoryboard instantiateViewControllerWithIdentifier:@"updateVC"];
        updateVC.contactDic=_contactDic;
        softUser *localuser=[softUser sharedLocaluserUserByDictionary:nil];
        if (localuser.dicOfDepartment)
        {
            for (NSMutableDictionary *dic in [localuser.dicOfDepartment objectForKey:@"result"])
            {
                if ([[_contactDic objectForKey:@"Department_Id"] isEqualToString:[dic objectForKey:@"Department_Id"]])
                {
                    updateVC.dicOfDepartment=dic;
                }
            }
        }
        
        if (localuser.dicOfCompanyName)
        {
            for (NSMutableDictionary *dic in [localuser.dicOfCompanyName objectForKey:@"result"])
            {
                if ([[_contactDic objectForKey:@"Customer_Id"] isEqualToString:[dic objectForKey:@"Customer_Id"]])
                {
                    updateVC.dicOfcompanyName=dic;
                }
            }
        }
        
        [self.navigationController pushViewController:updateVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册通知：不仅指定一个观察者，指定通知中心发送给观察者的消息，还有接收通知的名字，以及指定的对象
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVCToModifyVC) name:@"updateVCToModifyVC" object:nil];
    
    _soap1=[[crmSoap alloc]init];
    _soap1.soapDelgate=self;
    _detailInfoView=[[[NSBundle mainBundle] loadNibNamed:@"contactDetailInfoView" owner:nil options:nil]lastObject];
    _detailInfoView.frame=_blankDataView.bounds;
    [_blankDataView addSubview:_detailInfoView];
    [_soap1 getContactInfoByContactId:_contactId  getWhatInfo:@"详细资料"];
    
    _soap2=[[crmSoap alloc]init];
    _soap2.soapDelgate=self;
    _activityView=[[[NSBundle mainBundle]loadNibNamed:@"contactActivityView" owner:nil options:nil]lastObject];
    _activityView.frame=_blankDataView.bounds;
    [_blankDataView addSubview:_activityView];
    [_soap2 getActivityRecordsByContactid:_contactId getWhatInfo:@"通过联系人id查询活动记录"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark crmdelegate
- (void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat
{
    if (![soapresult isEqualToString:@"失败"]) {
        if (![getwhat isEqualToString:@"通过联系人id查询活动记录"]) {
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            
            _contactDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            _detailInfoView.dataDicOFContact=_contactDic;
            [_detailInfoView.detailInfoTableView reloadData];
            
                   }
        
        if (![getwhat isEqualToString:@"详细资料"]) {
           
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            
            _activitysDIc=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@",[error localizedDescription]);
            }
            //活动记录xib中的字典数据=获取来的字典数据
            _activityView.dataDic=_activitysDIc;
            //活动记录xib中的数组数据=通过key获取到的数据
            _activityView.dataArray=[_activitysDIc objectForKey:@"result"];
            [_activityView.activityTableView reloadData];

 
        }
    }
    
}

- (void)doWhenHttpCollecttionFalil:(NSError *)error
{
    
}


@end
