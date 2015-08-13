//
//  EcardSoap.m
//  EX_EcardSoap
//
//  Created by learner on 15-6-12.
//  Copyright (c) 2015年 learner. All rights reserved.
//

#import "crmSoap.h"

@implementation crmSoap

@synthesize webData;
@synthesize soapResults;
@synthesize xmlParser;
@synthesize elementFound;
@synthesize matchingElement;
@synthesize conn;

-(void)checkAccount:(NSString *)loginCount Pwd:(NSString *)loginPwd getWhatInfo:(NSString *)getwhatinfo
{
    
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<checkAccount xmlns=\"xaiohu/CRM\">"
                         "<loginCount>%@</loginCount>"
                         "<loginPwd>%@</loginPwd>"
                         "</checkAccount>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",loginCount,loginPwd];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"checkAccountResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}

/*↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓___何志平联系人___↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓__↓___*/


//通过用户Id查询联系人姓名、id
-(void)getContactNameAndIdByUserId:(NSString *)userid getWhatInfo:(NSString *)getwhatinfo
{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getContactNameByuserID xmlns=\"xaiohu/CRM\">"
                         "<userId>%d</userId>"
                         "</getContactNameByuserID>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",userid.intValue];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"getContactNameByuserIDResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}

/*添加联系人
 
 error:服务器无法处理请求。 ---&gt; “soap”是未声明的命名空间。 行 1，位置 211。
 
 */
-(void)addContact:(int) contactId Name:(NSString *)name  customId:(int)customId  userId:(int)uId departmentId:(int)departmentId contactSex:(NSString *)contactSex contactBirth:(NSString *)contactBirth contactPosition:(NSString *)contactPosition contactPhone:(NSString *)contactPhone contactTel:(NSString *)contactTel   mail:(NSString *)mail  Addr:(NSString *)addr Remark:(NSString *)remark department:(NSString *)department   cDate:(NSString *  )cdate cPerson:(NSString *)cperson mDate:(NSString *)mdate mPerson:(NSString *)mPerson getWhatInfo:(NSString *)getwhatinfo
{
    
    NSString *soapMsg=[NSString stringWithFormat:
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                       "<soap12:Envelope "
                       "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                       "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                       "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                       "<soap12:Body>"
                       
                       "<addContact xmlns=\"xaiohu/CRM\" >"
                       "<contactId>%d</contactId>"
                       "<contactName>%@</contactName>"
                       "<userId>%d</userId>"
                       "<customId>%d</customId>"
                       "<departmentId>%d</departmentId>"
                       "<contactSex>%@</contactSex>"
                       "<contactBirth>%@</contactBirth>"
                       "<contactPosition>%@</contactPosition>"
                       "<contactPhone>%@</contactPhone>"
                       "<contactTel>%@</contactTel>"
                       "<mail>%@</mail>"
                       "<addr>%@</addr>"
                       "<remark>%@</remark>"
                       "<department>%@</department>"
                       "<createDate>%@</createDate>"
                       "<creatPerson>%@</creatPerson>"
                       "<modifyDate>%@</modifyDate>"
                       "<modifyPerson>%@</modifyPerson>"
                       "</addContact>"
                       "</soap12:Body>"
                       "</soap12:Envelope>",contactId,name,uId,customId,departmentId,contactSex,contactBirth,contactPosition,contactPhone,contactTel,mail,addr,remark,department,cdate,cperson,mdate,mPerson];
    
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"addContactResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}




-(void)updateContact:(int) contactId Name:(NSString *)name  customId:(int)customId  userId:(int)uId departmentId:(int)departmentId contactSex:(NSString *)contactSex contactBirth:(NSString *)contactBirth contactPosition:(NSString *)contactPosition contactPhone:(NSString *)contactPhone contactTel:(NSString *)contactTel   mail:(NSString *)mail  Addr:(NSString *)addr Remark:(NSString *)remark department:(NSString *)department   cDate:(NSString *  )cdate cPerson:(NSString *)cperson mDate:(NSString *)mdate mPerson:(NSString *)mPerson getWhatInfo:(NSString *)getwhatinfo
{
    
    NSString *soapMsg=[NSString stringWithFormat:
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                       "<soap12:Envelope "
                       "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                       "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                       "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                       "<soap12:Body>"
                       
                       "<updateContact xmlns=\"xaiohu/CRM\">"
                       "<contactId>%d</contactId>"
                       "<contactName>%@</contactName>"
                       "<userId>%d</userId>"
                       "<customId>%d</customId>"
                       "<departmentId>%d</departmentId>"
                       "<contactSex>%@</contactSex>"
                       "<contactBirth>%@</contactBirth>"
                       "<contactPosition>%@</contactPosition>"
                       "<contactPhone>%@</contactPhone>"
                       "<contactTel>%@</contactTel>"
                       "<mail>%@</mail>"
                       "<addr>%@</addr>"
                       "<remark>%@</remark>"
                       "<department>%@</department>"
                       "<createDate>%@</createDate>"
                       "<creatPerson>%@</creatPerson>"
                       "<modifyDate>%@</modifyDate>"
                       "<modifyPerson>%@</modifyPerson>"
                       
                       "</updateContact>"
                       
                       "</soap12:Body>"
                       "</soap12:Envelope>",contactId,name,uId,customId,departmentId,contactSex,contactBirth,contactPosition,contactPhone,contactTel,mail,addr,remark,department,cdate,cperson,mdate,mPerson];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"updateContactResult";
    self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
     
    
     
}






//查询所有的部门
-(void)getAllDepartmentgetWhatInfo:(NSString *)getwhatinfo{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getCustomerDepartMent xmlns=\"xaiohu/CRM\" />"
                         "</soap12:Body>"
                         "</soap12:Envelope>"];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"getCustomerDepartMentResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
    
}



//查询所有客户名称
-(void)getAllCustomerNamegetWhatInfo:(NSString *)getwhatinfo
{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<getCustomerName xmlns=\"xaiohu/CRM\" />"
                         "</soap12:Body>"
                         "</soap12:Envelope>"];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"getCustomerNameResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}


//通过联系人id查询联系人的活动记录
-(void)getActivityRecordsByContactid:(int)contactId getWhatInfo:(NSString *)getwhatinfo{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getActivitsByContactId xmlns=\"xaiohu/CRM\">"
                         "<contactId>%d</contactId>"
                         "</getActivitsByContactId>"
                         
                         "</soap12:Body>"
                         "</soap12:Envelope>",contactId];
    matchingElement = @"getActivitsByContactIdResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}

//通过联系人id查询联系人的详细信息
-(void)getContactInfoByContactId:(int)contactid getWhatInfo:(NSString *)getwhatinfo
{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getContactInfoByContactId xmlns=\"xaiohu/CRM\">"
                         "<contactId>%d</contactId>"
                         "</getContactInfoByContactId>"
                         
                         "</soap12:Body>"
                         "</soap12:Envelope>",contactid];
    matchingElement = @"getContactInfoByContactIdResult";
    self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}

//通过客户id查询客户姓名
-(void)getCustomerNameByid:(NSString *)cId getWhatInfo:(NSString *)getwhatinfo
{
    
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getCustomerInfo xmlns=\"xaiohu/CRM\">"
                         "<customerId>%@</customerId>"
                         "</getCustomerInfo>"
                         
                         "</soap12:Body>"
                         "</soap12:Envelope>",cId];
    matchingElement = @"getCustomerLevelByIdResult";
    self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
    
}


//通过id查询部门
-(void)getdepartmentById:(NSString *)dId getWhatInfo:(NSString *)getwhatinfo{
    
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getCustomerDepartMentByID xmlns=\"xaiohu/CRM\">"
                         "<Department_Id>%@</Department_Id>"
                         "</getCustomerDepartMentByID>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",dId];
    matchingElement = @"getCustomerDepartMentByIDResult";
    self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
    
}


//通过id删除联系人
-(void)deleteContactById:(NSString *)contactId getWhatInfo:(NSString *)getwhatinfo
{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         " <deleteContact xmlns=\"xaiohu/CRM\">"
                         "<contactId>%d</contactId>"
                         "</deleteContact>"
                         
                         "</soap12:Body>"
                         "</soap12:Envelope>",contactId.intValue];
    matchingElement = @"deleteContactResult";
    self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}



/*__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑____何志平联系人___↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑__↑*/



-(void)getCustomerNameAndIdByUserId:(NSString *)userid getWhatInfo:(NSString *)getwhatinfo
{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getCustomerNameByuserID xmlns=\"xaiohu/CRM\">"
                         "<userId>%d</userId>"
                         "</getCustomerNameByuserID>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",userid.intValue];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"getCustomerNameByuserIDResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}
-(void)getUserInfoByUserIdAndUserPWd:(NSString *)userId Pwd:(NSString *)pwd getWhatInfo:(NSString *)getwhatinfo
{
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         
                         "<getuserInfo xmlns=\"xaiohu/CRM\">"
                         "<loginCount>%@</loginCount>"
                         "<loginPwd>%@</loginPwd>"
                         "</getuserInfo>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",userId,pwd];
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    matchingElement = @"getuserInfoResult";
     self.getWhatInfo=getwhatinfo;
    [self runWithsoapXml:soapMsg];
}

-(void)runWithsoapXml:(NSString *)soapWithXml{

    NSString *soapMsg=soapWithXml;
    NSLog(@"%s%@",__func__,soapMsg);
    // 将这个XML字符串打印出来
   //NSLog(@"将这个XML字符串打印出来%@", soapMsg);
    // 创建URL，内容是前面的请求报文报文中第二行主机地址加上第一行URL字段
    NSURL *url = [NSURL URLWithString: @"http://192.168.50.56:8089"];
    // 根据上面的URL创建一个请求
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    // 添加请求的详细信息，与请求报文前半部分的各字段对应
    [req addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    // 设置请求行方法为POST，与请求报文第一行对应
    [req setHTTPMethod:@"POST"];
    // 将SOAP消息加到请求中
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    // 创建连接
    req.timeoutInterval=12;
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (conn) {
        webData = [NSMutableData data];
    }
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [webData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    conn = nil;
    webData = nil;
    [self.soapDelgate doWhenHttpCollecttionFalil:error];
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    NSLog(@"打印出得到的XML%@", theXML);
    // 使用NSXMLParser解析出我们想要的结果
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
}

#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:matchingElement]) {
        if (!soapResults) {
            soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
    
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        [soapResults appendString: string];
    }
    
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:matchingElement]) {

        [self.soapDelgate doWhenEcardGetInfoFromWebServier:soapResults getWhatInfo:_getWhatInfo];
        elementFound = FALSE;
        // 强制放弃解析
        // [xmlParser abortParsing];
    }

}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (elementFound) {

        [self.soapDelgate doWhenHttpCollecttionFalil:nil];
       
    }
    if (soapResults) {
        soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
}

@end
