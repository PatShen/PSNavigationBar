//
//  WCNavigationBar.h
//  NavigationBar
//
//  Created by Shen Wenxin on 2017/8/25.
//  Copyright © 2017年 NanJing HOGE Software Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WCNavVerticalGravity) {
    WCNavVerticalGravityTop = 0,
    WCNavVerticalGravityCenter,
    WCNavVerticalGravityBottom,
};


@interface PSNavigationBar : UIView

/**
 * 导航栏标题配置
 
 * 目前支持：
 * `NSFontAttributeName`
 * `NSForegroundColorAttributeName`
 */
@property (nonatomic, strong) NSDictionary* navTitleTextAttributes UI_APPEARANCE_SELECTOR;

/**
 导航栏背景图片
 */
@property (nonatomic, strong) UIImage* navBackgroundImage UI_APPEARANCE_SELECTOR;

/**
 导航栏底部分隔线色
 */
@property (nonatomic, strong) UIColor* navShadowColor UI_APPEARANCE_SELECTOR;

/**
 标题视图
 */
@property (nonatomic, strong) UIView* titleView;

/**
 左侧按钮数组，从左到右排列
 */
@property (nonatomic, strong) NSArray<UIView*>* leftItems;

/**
 右侧按钮数组，从右到左排列
 */
@property (nonatomic, strong) NSArray<UIView*>* rightItems;

/**
 标题
 */
@property (nonatomic, copy) NSString* title;

/**
 内容对齐方式，默认值：WCNavVerticalGravityBottom
 */
@property (nonatomic, assign) WCNavVerticalGravity vertGravity;

/**
 内边距，默认值：(top:20,left:0,bottom:0,right:0)
 */
@property (nonatomic, assign) UIEdgeInsets navPadding;

@end
