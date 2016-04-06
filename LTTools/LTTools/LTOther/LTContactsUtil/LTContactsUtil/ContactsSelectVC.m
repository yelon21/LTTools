//
//  ContactsSelectVC.m
//  YJNew
//
//  Created by yelon on 16/3/1.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "ContactsSelectVC.h"
#import "LTContactsUtil.h"

@interface ContactsSelectVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
    NSMutableArray *listArray;
    NSMutableArray *allListArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

//@property (nonatomic, strong) LTContactsUtil *contactsUtil;
@end

@implementation ContactsSelectVC

+ (void)presentFrom:(UIViewController *)fromVC
selectedContactMobileNo:(void(^)(NSString *mobileNo))mobileNoBlock{

    if (!fromVC||![fromVC isKindOfClass:[UIViewController class]]) {
        
        return;
    }
    ContactsSelectVC *viewCon = [[ContactsSelectVC alloc]init];
    viewCon.mobileNoSelectedBlock = mobileNoBlock;
    UINavigationController *navCon = [[UINavigationController alloc]initWithRootViewController:viewCon];
    [fromVC presentViewController:navCon animated:YES completion:nil];
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    UIView *superView = self.view;
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(superView);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.right.bottom.equalTo(superView);
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择联系人";
    [self lt_setPresentedVCBackItem];
    
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem item:@"邀请"
    //                                                             color:[UIColor whiteColor]
    //                                                            target:self
    //                                                               sel:@selector(sendMessageAction)];
    
    allListArray   = [[NSMutableArray alloc]init];
    listArray   = [[NSMutableArray alloc]init];
    
    LTContactsUtil *contactsUtil = [[LTContactsUtil alloc]init];
    [allListArray setArray:[contactsUtil allMobileNoArray]];
    
    [listArray setArray:allListArray];
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.searchBar.barStyle = UIBarStyleBlack;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.returnKeyType = UIReturnKeyDone;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    self.tableView.separatorColor = UIColorRGB(51, 51, 51);
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIView *clearView = [UIView new];
    clearView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:clearView];
    [self.view addSubview:self.tableView];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([searchText length]>0) {
        
        //        NSString *str = [NSString stringWithFormat:@""];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ OR tel CONTAINS[cd] %@",searchText,searchText];
        
        NSArray *array = [allListArray filteredArrayUsingPredicate:predicate];
        [listArray setArray:array];
    }
    else{
        
        [listArray setArray:allListArray];
    }
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [listArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
//        cell.backgroundColor = [UIColor clearColor];
//        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cell.textLabel.textColor = [UIColor blackColor];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ContactsInfo *info = listArray[indexPath.row];
    
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = info.tel;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactsInfo *info = listArray[indexPath.row];
    if (self.mobileNoSelectedBlock) {
        
        self.mobileNoSelectedBlock(info.tel);
        self.mobileNoSelectedBlock = nil;
        [self lt_dismissToLastVC];
    }
}

@end
