//
//  ViewController.m
//  NavigationBar
//
//  Created by Shen Wenxin on 2017/8/25.
//  Copyright © 2017年 NanJing HOGE Software Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "PSNavigationBar.h"
#import "UIViewController+PSNavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f]];
    
    NSString* title = @"协同/内容助手/直播互动组";
    self.title = title;
    UIBarButtonItem* item = nil;
    
    NSMutableArray* left = [NSMutableArray array];
    item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [left addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [left addObject:item];
//
//    item = [[UIBarButtonItem alloc] initWithTitle:@"第3个" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
//    [left addObject:item];
//    
//    item = [[UIBarButtonItem alloc] initWithTitle:@"第4个" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
//    [left addObject:item];
//    
    self.navigationItem.leftBarButtonItems = left;
//
    NSMutableArray* right = [NSMutableArray array];

    
    item = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [right addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
    [right addObject:item];
    
//
//    item = [[UIBarButtonItem alloc] initWithTitle:@"第3个" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
//    [right addObject:item];
//    
//    item = [[UIBarButtonItem alloc] initWithTitle:@"第4个" style:UIBarButtonItemStylePlain target:self action:@selector(itemTouched:)];
//    [right addObject:item];
//    
    self.navigationItem.rightBarButtonItems = right;
    
    PSNavigationBar* bar = [PSNavigationBar new];
//    [bar setBackgroundColor:[UIColor colorWithRed:249/255.0f green:249/255.0f blue:249.0f/255.0f alpha:1.0f]];
    [bar setBackgroundColor:[UIColor whiteColor]];
//    [bar setNavShadowColor:[UIColor clearColor]];
//    [bar setNavTitleTextAttributes:@{NSFontAttributeName:(id)[UIFont boldSystemFontOfSize:17.0f]}];
    [self.view addSubview:bar];
    
    [bar setTitle:title];
    
    
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bar.superview).with.offset(0);
        make.leading.equalTo(bar.superview);
        make.trailing.equalTo(bar.superview);
        make.height.mas_equalTo(64);
    }];
    
    left = [NSMutableArray array];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [left addObject:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [left addObject:button];
    
//    button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setTitle:@"3" forState:UIControlStateNormal];
//    [left addObject:button];
//    
//    button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setTitle:@"4" forState:UIControlStateNormal];
//    [left addObject:button];
    
    [bar setLeftItems:left];
    
    right = [NSMutableArray array];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    [right addObject:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"图片" forState:UIControlStateNormal];
    [right addObject:button];
    
    [bar setRightItems:right];
    
//    UINavigationBar* navBar = [UINavigationBar new];
//    [self.view addSubview:navBar];
//    
//    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bar.mas_bottom).with.offset(80);
//        make.leading.equalTo(navBar.superview);
//        make.trailing.equalTo(navBar.superview);
//        make.height.mas_equalTo(64);
//    }];
    
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

- (void)itemTouched:(id)sender {
    
}

- (void)switchButtonTouchedd:(id)sender {
    BOOL hidden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:!hidden animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
