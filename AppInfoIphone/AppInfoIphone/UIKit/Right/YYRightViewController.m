//
//  YYRightViewController.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYRightViewController.h"
#define kImage @"kImage"
#define kViewController  @"kViewController"

@interface YYRightViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation YYRightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSource = [NSMutableArray arrayWithCapacity:5];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = RGBCOLOR(61, 89, 171);
    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    //=======1
    YYAccountController *account = [[YYAccountController alloc] init];
    account.title = @"我的账号";
    UINavigationController *accountNav = [[UINavigationController alloc] initWithRootViewController:account];
    NSDictionary *dic1 =[NSDictionary dictionaryWithObjectsAndKeys:accountNav,kViewController,@"set_account",kImage, nil];
    [self.dataSource addObject:dic1];
    //=======2
    YYTimeTableController *timeTable = [[YYTimeTableController alloc] init];
    timeTable.title = @"我的课程表";
    UINavigationController *timeTableNav = [[UINavigationController alloc] initWithRootViewController:timeTable];
    NSDictionary *dic2 =[NSDictionary dictionaryWithObjectsAndKeys:timeTableNav,kViewController,@"set_setting",kImage, nil];
    [self.dataSource addObject:dic2];
    //========3
    YYGetAnswerController *getAns = [[YYGetAnswerController alloc] init];
    getAns.title = @"索要答案";
    UINavigationController *getAnsNav = [[UINavigationController alloc] initWithRootViewController:getAns];
    NSDictionary *dic3 =[NSDictionary dictionaryWithObjectsAndKeys:getAnsNav,kViewController,@"set_lib",kImage, nil];
    [self.dataSource addObject:dic3];
    
    YYAboutController *about = [[YYAboutController alloc] init];
    about.title = @"关于我";
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:about];
    NSDictionary *dic4 =[NSDictionary dictionaryWithObjectsAndKeys:aboutNav,kViewController,@"",kImage, nil];
    [self.dataSource addObject:dic4];
    
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = RGBCOLOR(230, 230, 230);
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"userlist";
    YYRightCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell = [[YYRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    UIViewController *controller = dic[kViewController];
    NSString *str = controller.title;
    cell.tagLabel.textColor =  [UIColor grayColor];
    cell.tagLabel.text = str;
    cell.tagImageView.image = [UIImage imageNamed:dic[kImage]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(YYRightViewController:didSelectIndexPath:withController:)]) {
        NSDictionary *dic = self.dataSource[indexPath.row];
        UIViewController *controller = dic[kViewController];
        [self.delegate YYRightViewController:self didSelectIndexPath:indexPath withController:controller];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
