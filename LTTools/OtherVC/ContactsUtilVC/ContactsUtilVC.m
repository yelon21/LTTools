//
//  ViewController.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "ContactsUtilVC.h"
#import "LTContactsUtil.h"
#import "LTLocation.h"

@interface ContactsUtilVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *listArray;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)LTContactsUtil *contactsUtil;
@end

@implementation ContactsUtilVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [LTLocation sharedLocation];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    listArray = [self.contactsUtil contactsArray];
    [self.tableView reloadData];
}

-(LTContactsUtil *)contactsUtil{

    if (!_contactsUtil) {
        
        _contactsUtil = [[LTContactsUtil alloc]init];
    }
    return _contactsUtil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [listArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LTContactsInfo *info = listArray[section];
    return [info.tels count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    LTContactsInfo *info = listArray[section];
    return [info name];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    LTContactsInfo *info = listArray[indexPath.section];
    
    cell.textLabel.text = info.tels[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
