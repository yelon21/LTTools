//
//  ViewController.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSArray *listArray;
}

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    if (!self.key) {
        self.key = @"Root";
    }
    
    listArray = [LTPlistReader LT_getDictionary:@"ListKind" forKey:self.key];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [listArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    NSDictionary *dic = [listArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = [listArray objectAtIndex:indexPath.row];
    NSString *classString = dic[@"class"];
    
    if (classString) {
        
        Class class = NSClassFromString(classString);
        ViewController *viewCon = [[class alloc]init];
        if ([viewCon isKindOfClass:[ViewController class]]) {
            viewCon.key = dic[@"key"];
        }
        [self.navigationController pushViewController:viewCon animated:YES];
    }
}

@end
