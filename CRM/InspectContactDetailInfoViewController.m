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

@interface InspectContactDetailInfoViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
//空白的view，用来显示数据
@property (weak, nonatomic) IBOutlet UIView *blankDataView;
@property (strong,nonatomic) contactActivityView *activityView;
@property (strong,nonatomic) contactDetailInfoViewController *detailInfoView;

@property (strong,nonatomic)NSMutableArray *activitiesArrary;
@property(strong,nonatomic)NSMutableDictionary *activitysDIc;
@property(strong,nonatomic)crmSoap *soap1;
@property(strong,nonatomic)crmSoap *soap2;

@end

@implementation InspectContactDetailInfoViewController

- (IBAction)changDataSegment:(UISegmentedControl *)sender {
    
    switch (self.mySegment.selectedSegmentIndex) {
        case 0:
            _activityView.hidden=NO;
            _detailInfoView.hidden=YES;
            break;
        case 1:
            _activityView.hidden=YES;
            _detailInfoView.hidden=NO;
            
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
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册通知：不仅指定一个观察者，指定通知中心发送给观察者的消息，还有接收通知的名字，以及指定的对象
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVCToModifyVC) name:@"updateVCToModifyVC" object:nil];
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark crmdelegate
- (void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult getWhatInfo:(NSString *)getwhat
{
    if (![soapresult isEqualToString:@"失败"]) {
        if (![getwhat isEqualToString:@"活动记录"]) {
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            
            _activitysDIc=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@",[error localizedDescription]);
            }
            _activityView.dataDic=_activitysDIc;
            _activityView.dataArray=[_activitysDIc objectForKey:@"result"];
            [_activityView.activityTableView reloadData];
        }
        
        if (![getwhat isEqualToString:@"详细资料"]) {
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            
            NSMutableDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            _detailInfoView.dataDicOFContact=dic;
            [_detailInfoView.detailInfoTableView reloadData];
 
        }
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
