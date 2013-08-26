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
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.tintColor = RGBCOLOR(61, 89, 171);
    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    titleLabel.text = @"答案导航";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RoomList:) name:KXRoomListNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CheckUpdate:) name:KXCheckUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestError:) name:KXNetworkManagerDidFailWithErrorNotification object:nil];
    [[KXNetworkManager sharedKXNetworkManager] requestCheckUpdate];
    [[KXNetworkManager sharedKXNetworkManager] requestWithUID:@(100)];
}
- (void)RequestError:(NSNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"连接失败,请检查网络." delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)CheckUpdate:(NSNotification *)notification
{
    CheckUpdateEntity *entity = notification.object;
    if (entity.resultCode == 1 && [entity.isUpdate boolValue]) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:entity.msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    });
    }
}
- (void)RoomList:(NSNotification *)notification
{
    RoomListEntity *entity = notification.object;
    if (entity.resultCode == 1) {
        self.dataSource = entity.Results;
        [self.tableView reloadData];
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.allKeys.count;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = RGBCOLOR(51, 161, 201);
    label.textColor = RGBCOLOR(41, 36, 33);
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = [NSString stringWithFormat:@" %@",self.dataSource.allKeys[section]]; 
    return label;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"left";
    YYLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[YYLeftViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSString *key = self.dataSource.allKeys[indexPath.section];
    NSArray *value = self.dataSource[key];
    
    cell.textLabel.textColor=  RGBCOLOR(128, 42, 42);
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    cell.detailTextLabel.numberOfLines = 0;
    BookInfoEntity *entity = value[indexPath.row];
    
    cell.textLabel.text = entity.BookName;
    NSString *bookinfo = entity.BookIntr;
    if ([bookinfo isEqualToString:@""] || bookinfo==nil) {
        cell.detailTextLabel.text = @"待上线";
        cell.detailTextLabel.textColor=   RGBCOLOR(163, 148, 128);
    }else{
        cell.detailTextLabel.text = bookinfo;
        cell.detailTextLabel.textColor=  RGBCOLOR(178, 34, 34);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(YYLeftViewController:didSelectIndexPath:)]) {
        NSString *key = self.dataSource.allKeys[indexPath.section];
        NSArray *value = self.dataSource[key];
        BookInfoEntity *entity = value[indexPath.row];
        NSString *bookinfo = entity.BookIntr;
        if ([bookinfo isEqualToString:@""] || bookinfo==nil) {
        }else{
            [self.delegate YYLeftViewController:self didSelectIndexPath:indexPath];
        }
       
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.dataSource.allKeys;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
