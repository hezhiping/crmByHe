//
//  loginViewController.m
//  CRM
//
//  Created by Mac on 15/8/3.
//  Copyright (c) 2015年 crmTeam. All rights reserved.
//

#import "loginViewController.h"
#import "softUser.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userIdText;
@property (weak, nonatomic) IBOutlet UITextField *userPwdText;
@property(strong,nonatomic)crmSoap *soap;
@property(strong,nonatomic)UIAlertView *myalrtview;
@property(nonatomic)BOOL isLogin;//判断是否登陆成功。yes为成功
@end

@implementation loginViewController
#pragma _mark BtnEventMothd
- (IBAction)loginIn:(id)sender {//登录
    _soap=[[crmSoap alloc]init];
    _soap.soapDelgate=self;
//    [_soap checkAccount:self.userIdText.text Pwd:self.userPwdText.text];
    [_soap checkAccount:@"123" Pwd:@"123"];
    _myalrtview=[[UIAlertView alloc]initWithTitle:nil message:@"正在登陆》》》" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [_myalrtview show];
}
#pragma -mark crmdelegate
-(void)doWhenEcardGetInfoFromWebServier:(NSString *)soapresult{
    if ([soapresult isEqualToString:@"成功"]) {
        [self performSegueWithIdentifier:@"signIn" sender:self];
      
        self.isLogin=YES;//设置登录成功
//        [self.soap getUserInfoByUserIdAndUserPWd:self.userIdText.text Pwd:self.userPwdText.text];//网络请求获取用户具体信息
        [self.soap getUserInfoByUserIdAndUserPWd:@"123" Pwd:@"123"];
    }
    else{
        if ([soapresult isEqualToString:@"失败"]&&!_isLogin) {//如果返回结果是失败而且还没有登录成功
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"登陆失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];

        }
        else{
            NSLog(@"%ssoapresult %@",__func__, soapresult);
            NSData *data=[soapresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            NSMutableDictionary *userDic=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            
            NSLog(@"userdic%@",[userDic description]);
            if (!error) {
                softUser *Localuser=[softUser sharedLocaluserUserByDictionary:userDic];
            }
        }
        
    }
      [self.myalrtview dismissWithClickedButtonIndex:0 animated:YES];
    
}
-(void)doWhenHttpCollecttionFalil:(NSError *)error{
    if(!_isLogin){//如果还没有登录成功则
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"登陆失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertview show];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isLogin=NO;
    // Do any additional setup after loading the view.
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userPwdText resignFirstResponder];
    [self.userIdText resignFirstResponder];
}


@end
