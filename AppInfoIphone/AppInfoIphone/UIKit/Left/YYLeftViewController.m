//
//  YYLeftViewController.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYLeftViewController.h"
NSString * const kViewController = @"kViewController";
NSString * const kViewControllerTitle = @"kViewControllerTitle";
@interface YYLeftViewController ()

@end

@implementation YYLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {

      //  self.dataSource = [NSDictionary dictionary];

    }
    return self;
}

-(void)handleData
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss"];
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新 %@", [formatter stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}
-(void)refreshView:(UIRefreshControl *)refresh
{
    if (refresh.refreshing) {
        refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新中..."];
          [[KXNetworkManager sharedKXNetworkManager] requestWithUID:@(100)]; 
       // [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.tintColor = RGBCOLOR(230, 230, 230);
    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.tintColor = [UIColor lightGrayColor];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"] ;
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RoomList:) name:KXRoomListNotification object:nil];
      [[KXNetworkManager sharedKXNetworkManager] requestWithUID:@(100)];
	// Do any additional setup after loading the view.
}
- (void)RoomList:(NSNotification *)notification
{
    RoomListEntity *entity = notification.object;
    if (entity.resultCode == 1) {
        
        self.dataSource = entity.Results;
      //  [self.tableView reloadData];
        [self performSelector:@selector(handleData) withObject:nil afterDelay:1];
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return   self.dataSource.allKeys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.dataSource.allKeys[section];
    NSArray *value = self.dataSource[key];
    return value.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = RGBCOLOR(220, 220, 220);
    label.textColor = [UIColor grayColor];
    label.text =  self.dataSource.allKeys[section];
    return label;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return self.dataSource.allKeys[section];
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"left";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSString *key = self.dataSource.allKeys[indexPath.section];
    NSArray *value = self.dataSource[key];
    
    cell.textLabel.textColor=  [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    NSDictionary *dic = value[indexPath.row];
    
    cell.textLabel.text = dic[@"Name"];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(YYLeftViewController:didSelectIndexPath:)]) {
       [self.delegate YYLeftViewController:self didSelectIndexPath:indexPath];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
