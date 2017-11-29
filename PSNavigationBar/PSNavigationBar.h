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

/**
 导航栏的隐藏模式
 
 - PSNavHiddenModeContent: 隐藏背景图、分隔线、标题
 - PSNavHiddenModeBottomLine: 只隐藏分隔线
 - PSNavHiddenModeAll: 全部隐藏
 */
typedef NS_ENUM(NSUInteger, PSNavHiddenMode) {
    PSNavHiddenModeContent,
    PSNavHiddenModeBottomLine,
    PSNavHiddenModeAll,
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

/**
 A Boolean value indicating whether the title should be displayed in a large format.
 
 设置为YES之后，标题会移动到左侧，左侧按钮消失；否则标题居中显示;
 
 可以通过 +barWithLargeTitle 进行初始化设置
 */
@property (nonatomic, assign) BOOL prefersLargeTitles;

/**
 导航栏的隐藏模式，会在 -updateBackgroundAlpha: 调用时生效
 
 默认值为 PSNavHiddenModeContent
 */
@property (nonatomic, assign) PSNavHiddenMode hiddenMode;


/**
 设置背景部分的透明度，背景部分包括：背景图和底部分隔线（不需要手动设置背景色）
 
 @param alpha 透明度
 */
- (void)updateBackgroundAlpha:(CGFloat)alpha;

/**
 iOS11 之前的版本，使用 topLayoutGuide 约束
 
 @param topAttribute 顶部约束
 */
- (void)updateTopAttribute:(id)topAttribute;

@end




@interface PSNavigationBar (PSNavigationBarCreation)

@end
