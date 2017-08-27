//
//  UIViewController+PSNavigationBar.m
//  NavigationBar
//
//  Created by Shen Wenxin on 2017/8/27.
//  Copyright © 2017年 NanJing HOGE Software Co., Ltd. All rights reserved.
//

#import "UIViewController+PSNavigationBar.h"
#import <objc/runtime.h>
#import "PSNavigationBar.h"

@implementation UIViewController (PSNavigationBar)
@dynamic ps_navigationBar;

- (void)setPs_navigationBar:(PSNavigationBar *)ps_navigationBar {
    objc_setAssociatedObject(self, @selector(ps_navigationBar), ps_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PSNavigationBar *)ps_navigationBar {
    id bar = objc_getAssociatedObject(self, @selector(ps_navigationBar));
    if (bar == nil) {
        bar = [PSNavigationBar new];
    }
    return bar;
}

@end
