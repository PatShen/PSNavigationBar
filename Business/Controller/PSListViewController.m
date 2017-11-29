//
//  PSListViewController.m
//  NavigationBar
//
//  Created by Shen Wenxin on 2017/11/29.
//  Copyright © 2017年 NanJing HOGE Software Co., Ltd. All rights reserved.
//

#import "PSListViewController.h"
#import "PSDetails1ViewController.h"
//#import "PSDetails2ViewController.h"
//#import "PSDetails3ViewController.h"
//#import "PSDetails4ViewController.h"

@interface PSListViewController ()
<UITableViewDataSource, UITableViewDelegate>

@end

@implementation PSListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self prepareTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController isNavigationBarHidden]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK:
- (void)prepareTableView {
    UITableView* tbl = [UITableView new];
    [tbl setEstimatedRowHeight:50.0f];
    [tbl setDataSource:self];
    [tbl setDelegate:self];
    [self.view addSubview:tbl];
    
    UIView* superview = tbl.superview;
    [tbl mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(superview.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(superview.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(superview.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(superview.mas_safeAreaLayoutGuideBottom);
        }
        else {
            UIEdgeInsets insets = UIEdgeInsetsZero;
            make.edges.equalTo(superview).insets(insets);
        }
    }];
}

// MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString* text = [NSString stringWithFormat:@"row %@",@(indexPath.row)];
    [cell.textLabel setText:text];
    
    return cell;
}

// MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController* controller = nil;
    if (indexPath.row == 0) {
        controller = [[PSDetails1ViewController alloc] init];
    }
    
    if ([controller isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:controller animated:YES];
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
