//
//  PSDetails1ViewController.m
//  NavigationBar
//
//  Created by Shen Wenxin on 2017/11/29.
//  Copyright © 2017年 NanJing HOGE Software Co., Ltd. All rights reserved.
//

#import "PSDetails1ViewController.h"

@interface PSDetails1ViewController ()

@end

@implementation PSDetails1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString* title = @"协同/内容助手/直播互动组";
    self.title = title;
    
    [self prepareSystemNavigationBar];
    [self prepareCustomNavigationBar];
    [self prepareSwitchButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Prepare
- (void)prepareSystemNavigationBar {
    UIBarButtonItem* item = nil;
    
    NSMutableArray* left = [NSMutableArray array];
    item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTouched:)];
    [left addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [left addObject:item];
    
    self.navigationItem.leftBarButtonItems = left;
    
    
    NSMutableArray* right = [NSMutableArray array];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [right addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [right addObject:item];
    
    self.navigationItem.rightBarButtonItems = right;
}

- (void)prepareCustomNavigationBar {
    PSNavigationBar* bar = [PSNavigationBar new];
    [bar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bar];
    [bar setTitle:self.title];
    
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bar.superview).with.offset(0);
        make.leading.equalTo(bar.superview);
        make.trailing.equalTo(bar.superview);
        make.height.mas_equalTo(64);
    }];
    
    NSMutableArray* left = [NSMutableArray array];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backTouched:) forControlEvents:UIControlEventTouchUpInside];
    [left addObject:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [left addObject:button];
    
    [bar setLeftItems:left];
    
    NSMutableArray* right = [NSMutableArray array];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    [right addObject:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"图片" forState:UIControlStateNormal];
    [right addObject:button];
    
    [bar setRightItems:right];
}

- (void)prepareSwitchButton {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"switch" forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(switchButtonTouchedd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.superview).with.offset(-10);
        make.bottom.equalTo(btn.superview).with.offset(-20);
    }];
}

// MARK: Touched Events
- (void)itemTouched:(id)sender {
    
}

- (void)backTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchButtonTouchedd:(id)sender {
    BOOL hidden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:!hidden animated:YES];
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
