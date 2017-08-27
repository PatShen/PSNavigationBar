//
//  WCNavigationBar.m
//  NavigationBar
//
//  Created by Shen Wenxin on 2017/8/25.
//  Copyright © 2017年 NanJing HOGE Software Co., Ltd. All rights reserved.
//

#import "PSNavigationBar.h"
#import <Masonry/Masonry.h>

// layout constant
static CGFloat const nav_min_item_width = 40.0f;
static CGFloat const nav_max_item_width = 60.0f;

static CGFloat const nav_min_title_width = 40.0f;

#define NAV_MAX_TITLE_WIDTH (NSInteger)([[UIScreen mainScreen] bounds].size.width*0.8f)
#define NAV_MAX_OPERATION_VIEW_WIDTH (NSInteger)([[UIScreen mainScreen] bounds].size.width*0.4f)

static CGFloat const nav_content_height = 44.0f;

static CGFloat const nav_item_space = 2.0f;

static CGFloat const nav_title_horz_margin = 4.0f;

// tag
static NSInteger const tag_nav_left_items = 50000;
static NSInteger const tag_nav_right_items = 50020;



@interface PSNavigationBar () {
    BOOL isInitialLayout_;
}

// control
@property (nonatomic, strong) UIImageView* imgvBackground;
@property (nonatomic, strong) UIView* viewContent;
@property (nonatomic, strong) UIImageView* imgvShadow;
@property (nonatomic, strong) UILabel* lblTitle;

@property (nonatomic, strong) UIView* viewLeft;
@property (nonatomic, strong) UIView* viewRight;

// value
@property (nonatomic, strong) UIImage* shadowImage;

@end

@implementation PSNavigationBar


- (instancetype)init {
    self = [super init];
    if (self) {
        _vertGravity = WCNavVerticalGravityBottom;
        _navPadding = UIEdgeInsetsMake(20, 8, 0, 8);
        
        [self initiaizeComponents];
    }
    return self;
}

- (void)initiaizeComponents {
    isInitialLayout_ = YES;
    // 背景图
    UIImageView* imgv = [UIImageView new];
    [imgv setContentMode:UIViewContentModeScaleAspectFill];
    [imgv setClipsToBounds:YES];
    [self addSubview:imgv];
    _imgvBackground = imgv;
    
    // 分隔线
    imgv = [UIImageView new];
    [self addSubview:imgv];
    _imgvShadow = imgv;
    
    // 内容视图
    UIView* view = [UIView new];
    [self addSubview:view];
    _viewContent = view;
    
    // 标题区域
    view = [UIView new];
    [_viewContent addSubview:view];
    _titleView = view;
    
    UILabel* lbl = [UILabel new];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [_titleView addSubview:lbl];
    _lblTitle = lbl;
    
    // 左侧区域
    view = [UIView new];
    [view setClipsToBounds:YES];
    [_viewContent addSubview:view];
    _viewLeft = view;
    
    // 右侧区域
    view = [UIView new];
    [view setClipsToBounds:YES];
    [_viewContent addSubview:view];
    _viewRight = view;
}

// MARK: Overwrite
- (void)setNavTitleTextAttributes:(NSDictionary *)navTitleTextAttributes {
    _navTitleTextAttributes = navTitleTextAttributes;
    // update title attributes
    [self updateTitleTextAttributes:navTitleTextAttributes];
}

- (void)setNavBackgroundImage:(UIImage *)navBackgroundImage {
    _navBackgroundImage = navBackgroundImage;
    [_imgvBackground setImage:navBackgroundImage];
}

- (void)setNavShadowColor:(UIColor *)navShadowColor {
    _navShadowColor = navShadowColor;
    [_imgvShadow setBackgroundColor:navShadowColor];
}

- (void)setTitleView:(UIView *)titleView {
    if (_titleView != nil &&
        [_titleView superview] != nil) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    
    // addSubview & layout
    [_viewContent addSubview:_titleView];
    [self callUpdateLayout];
}

- (void)setLeftItems:(NSArray<UIView *> *)leftItems {
    if ([_leftItems isKindOfClass:[NSArray class]] &&
        [_leftItems count] > 0) {
        for (UIView* sub in _leftItems) {
            [sub removeFromSuperview];
        }
    }
    _leftItems = leftItems;
    
    // addSubview & layout
    [self updateLeftItems:_leftItems];
    [self callUpdateLayout];
}

- (void)setRightItems:(NSArray<UIView *> *)rightItems {
    if ([_rightItems isKindOfClass:[NSArray class]] &&
        [_rightItems count] > 0) {
        for (UIView* sub in _rightItems) {
            [sub removeFromSuperview];
        }
    }
    _rightItems = rightItems;
    
    // addSubview & layout
    [self updateRightItems:_rightItems];
    [self callUpdateLayout];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if ([title isKindOfClass:[NSString class]]) {
        [_lblTitle setText:title];
    }
}

- (void)setVertGravity:(WCNavVerticalGravity)vertGravity {
    _vertGravity = vertGravity;
}

- (void)setNavPadding:(UIEdgeInsets)navPadding {
    _navPadding = navPadding;
}

// MARK: - Private
- (void)callUpdateLayout {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)updateTitleTextAttributes:(NSDictionary*)attributes {
    if ([attributes isKindOfClass:[NSDictionary class]]) {
        UIFont* font = attributes[NSFontAttributeName];
        if (![font isKindOfClass:[UIFont class]]) {
            font = [UIFont systemFontOfSize:17.0f];
        }
        [_lblTitle setFont:font];
        
        UIColor* color = attributes[NSForegroundColorAttributeName];
        if (![color isKindOfClass:[UIColor class]]) {
            color = [UIColor blackColor];
        }
        [_lblTitle setTextColor:color];
    }
}

- (void)updateLeftItems:(NSArray*)items {
    for (NSInteger idx = 0; idx < [items count]; idx++) {
        id sub = [items objectAtIndex:idx];
        if (![sub isKindOfClass:[UIView class]]) {
            continue;
        }
        
        NSInteger tag = tag_nav_left_items+idx;
        NSInteger lastTag = tag-1;
        
        [sub setTag:tag];
        [_viewLeft addSubview:sub];
        
        UIView* subView = [_viewLeft viewWithTag:lastTag];
        
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton* button = (UIButton*)sub;
            [button sizeToFit];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.superview);
                make.bottom.equalTo(button.superview);
                make.width.mas_lessThanOrEqualTo(nav_max_item_width);
                make.width.mas_greaterThanOrEqualTo(nav_min_item_width);
                if (subView) {
                    make.leading.equalTo(subView.mas_trailing).with.offset(nav_item_space);
                }
                else {
                    make.leading.equalTo(button.superview);
                }
            }];
        }
    }
}

- (void)updateRightItems:(NSArray*)items {
    for (NSInteger idx = 0; idx < [items count]; idx++) {
        id sub = [items objectAtIndex:idx];
        if (![sub isKindOfClass:[UIView class]]) {
            continue;
        }
        
        NSInteger tag = tag_nav_right_items+idx;
        NSInteger lastTag = tag-1;
        
        [sub setTag:tag];
        [_viewRight addSubview:sub];
        
        UIView* subView = [_viewRight viewWithTag:lastTag];
        
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton* button = (UIButton*)sub;
            [button sizeToFit];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.superview);
                make.bottom.equalTo(button.superview);
                make.width.mas_lessThanOrEqualTo(nav_max_item_width);
                make.width.mas_greaterThanOrEqualTo(nav_min_item_width);
                if (subView) {
                    make.trailing.equalTo(subView.mas_leading).with.offset(-nav_item_space);
                }
                else {
                    make.trailing.equalTo(button.superview).priority(900);
                }
            }];
        }
    }
}

// MARK: Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    MASAttachKeys(self,_viewContent,_imgvShadow,_imgvBackground);
    if (isInitialLayout_) {
        // 只执行一次
        isInitialLayout_ = NO;
        
        UIEdgeInsets insets = UIEdgeInsetsZero;
        [_imgvBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_imgvBackground.superview).insets(insets);
        }];
        
        CGFloat height = 1.0f/[[UIScreen mainScreen] scale];
        [_imgvShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_imgvShadow.superview);
            make.trailing.equalTo(_imgvShadow.superview);
            make.bottom.equalTo(_imgvShadow.superview);
            make.height.mas_equalTo(height);
        }];
        
        [_viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_viewContent.superview).insets(_navPadding);
        }];
        
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(nav_min_title_width);
            make.width.mas_lessThanOrEqualTo(NAV_MAX_TITLE_WIDTH);
            make.height.equalTo(_titleView.superview);
            make.centerX.equalTo(_titleView.superview);
            make.centerY.equalTo(_titleView.superview);
        }];
        
        
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_lblTitle.superview).insets(insets);
        }];
        
        [_viewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewLeft.superview);
            make.leading.equalTo(_viewLeft.superview);
            make.bottom.equalTo(_viewLeft.superview);
            make.width.mas_lessThanOrEqualTo(NAV_MAX_OPERATION_VIEW_WIDTH);
        }];
        
        [_viewRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewRight.superview);
            make.bottom.equalTo(_viewRight.superview);
            make.trailing.equalTo(_viewRight.superview);
            make.width.mas_lessThanOrEqualTo(NAV_MAX_OPERATION_VIEW_WIDTH);
        }];
    }
    
    // 每次都要刷新
    switch (_vertGravity) {
        case WCNavVerticalGravityTop: {
            [_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_viewContent.superview).with.offset(_navPadding.top);
                make.leading.equalTo(_viewContent.superview).with.offset(_navPadding.left);
                make.bottom.equalTo(_viewContent.superview).with.offset(_navPadding.bottom).priority(900);
                make.trailing.equalTo(_viewContent.superview).with.offset(-_navPadding.right);
                make.height.mas_equalTo(nav_content_height);
            }];
        }
            break;
        case WCNavVerticalGravityCenter: {
            [_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_viewContent.superview);
                make.top.equalTo(_viewContent.superview).with.offset(_navPadding.top).priority(900);
                make.leading.equalTo(_viewContent.superview).with.offset(_navPadding.left);
                make.bottom.equalTo(_viewContent.superview).with.offset(_navPadding.bottom).priority(900);
                make.trailing.equalTo(_viewContent.superview).with.offset(-_navPadding.right);
                make.height.mas_equalTo(nav_content_height);
            }];
        }
            break;
        case WCNavVerticalGravityBottom:
        default: {
            [_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_viewContent.superview).with.offset(_navPadding.top).priority(900);
                make.leading.equalTo(_viewContent.superview).with.offset(_navPadding.left);
                make.bottom.equalTo(_viewContent.superview).with.offset(_navPadding.bottom);
                make.trailing.equalTo(_viewContent.superview).with.offset(-_navPadding.right);
                make.height.mas_equalTo(nav_content_height);
            }];
        }
            break;
    }
    
    CGFloat titleViewMaringLeft = 0.0f;
    CGFloat titleViewMarginRight = 0.0f;
    
    // 刷新布局
    if ([_leftItems count] > 0) {
        // 取最后一个item
        NSInteger tag = tag_nav_left_items;
        UIView* subView = [_viewLeft viewWithTag:tag];
        while (subView) {
            tag++;
            subView = [_viewLeft viewWithTag:tag];
        }
        
        subView = [_viewLeft viewWithTag:tag-1];
        
        [subView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(subView.superview);
        }];
        
        [_viewLeft mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(NAV_MAX_OPERATION_VIEW_WIDTH);
        }];
        
        titleViewMaringLeft = nav_title_horz_margin;
    }
    else {
        [_viewLeft mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(1);
        }];
    }
    
    // 刷新布局
    if ([_rightItems count] > 0) {
        // 取最后一个item
        NSInteger tag = tag_nav_right_items;
        UIView* subView = [_viewRight viewWithTag:tag];
        while (subView) {
            tag++;
            subView = [_viewRight viewWithTag:tag];
        }
        
        subView = [_viewRight viewWithTag:tag-1];
        
        [subView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(subView.superview);
        }];
        
        [_viewRight mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(NAV_MAX_OPERATION_VIEW_WIDTH);
        }];
        
        titleViewMarginRight = nav_title_horz_margin;
    }
    else {
        [_viewRight mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(1);
        }];
    }
    
    // 重新布局 titleView
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (titleViewMaringLeft > 0 || titleViewMarginRight > 0) {
            if (titleViewMaringLeft > 0) {
                make.leading.greaterThanOrEqualTo(_viewLeft.mas_trailing).offset(titleViewMaringLeft);
            }
            if (titleViewMarginRight > 0) {
                make.trailing.lessThanOrEqualTo(_viewRight.mas_leading).offset(-titleViewMarginRight);
            }
        }
        else {
            make.centerX.equalTo(_titleView.superview);
        }
        make.centerY.equalTo(_titleView.superview);
        make.height.equalTo(_titleView.superview);
        make.width.mas_greaterThanOrEqualTo(nav_min_title_width);
        make.width.mas_lessThanOrEqualTo(NAV_MAX_TITLE_WIDTH);
    }];
}

@end
