//
//  CMPageControllerManager.h
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HeaderPageScrollAlignmentLeft = 0,
    HeaderPageScrollAlignmentCenter
} HeaderPageScrollAlignmentType;

@interface CMPageHeaderStyle : NSObject

/** 标题数组 */
@property (nonatomic, strong) NSArray *titlesArray;

/** 控制器数组 */
@property (nonatomic, strong) NSArray *controllersArray;

/** 头部滚动标题背景颜色 */
@property (nonatomic, strong) UIColor *headerBarColor;

/** 顶部滚动视图按钮字体 */
@property (nonatomic, strong) UIFont *titleFont;

/** 正常状态下标题颜色 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/** 标题选中后的颜色 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

/** 顶部滚动视图高度 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/** 顶部视图按钮之间的间距 */
@property (nonatomic, assign) CGFloat headerButtonMargin;

/** 底部指示条的颜色 */
@property (nonatomic, strong) UIColor *indicatorBarColor;

/** 头部滚动视图对齐方式 */
@property (nonatomic, assign) HeaderPageScrollAlignmentType headerAlignmentType;


/**
 构建一个带顶部滚动条的滚动视图控制器的样式

 @param titles 标题数组
 @param viewControllers 控制器
 @param headerBarColor 顶部滚动条目的背景颜色
 @param titleFont 按钮的字体
 @param textNormalColor 顶部滚动视图的字体正常状态颜色
 @param textSelectedColor 顶部滚动视图的字体选中状态颜色
 @param indicatorColor 顶部滚动视图底部指示条的颜色
 @param headerViewHeight 顶部滚动视图高度
 @param alignmentType 顶部标题的整体对齐方式
 @return 返回一个滚动视图控制器样式
 */
+ (CMPageHeaderStyle *)styleWithTitleArray:(NSArray *)titles
                           controllerArray:(NSArray *)viewControllers
                            headerBarColor:(UIColor *)headerBarColor
                                 titleFont:(UIFont *)titleFont
                           textNormalColor:(UIColor *)textNormalColor
                         textSelectedColor:(UIColor *)textSelectedColor
                          headerViewHeight:(CGFloat)headerViewHeight
                        headerButtonMargin:(CGFloat)headerButtonMargin
                            indicatorColor:(UIColor *)indicatorColor
                        headerViewAligment:(HeaderPageScrollAlignmentType)alignmentType;


@end

