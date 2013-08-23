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
        self.dataSource = [NSMutableArray array];
        [self initCenterViewControllers];
    }
    return self;
}
- (void)initCenterViewControllers
{
    YYBestViewController *best = [[YYBestViewController alloc] init];
    best.title = @"精品推荐";
    UINavigationController *bestNav = [[UINavigationController alloc] initWithRootViewController:best];
    NSDictionary *bestdic =[NSDictionary dictionaryWithObjectsAndKeys:bestNav,kViewController,@"首页",kViewControllerTitle, nil];
    [self.dataSource addObject:bestdic];
    
    YYBangViewController *bang = [[YYBangViewController alloc] init];
    bang.title = @"排行榜";
    UINavigationController *bangNav = [[UINavigationController alloc] initWithRootViewController:bang];
    NSDictionary *bangdic =[NSDictionary dictionaryWithObjectsAndKeys:bangNav,kViewController,@"排行榜",kViewControllerTitle, nil];
    [self.dataSource addObject:bangdic];
}
-(void)handleData
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm:ss"];
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新 %@", [formatter stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}
-(void)refreshView:(UIRefreshControl *)refresh
{
    if (refresh.refreshing) {
        refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新中..."];
        [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
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

	// Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"left";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSDictionary *controllerDic = self.dataSource[indexPath.row];
    cell.textLabel.textColor=  [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = controllerDic[kViewControllerTitle];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(YYLeftViewController:didSelectIndexPath:withController:)]) {
        NSDictionary *controllerDic = self.dataSource[indexPath.row];
        UIViewController *controller = controllerDic[kViewController];
        [self.delegate YYLeftViewController:self didSelectIndexPath:indexPath withController:controller];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
