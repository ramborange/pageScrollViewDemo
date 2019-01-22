//
//  CMPageControllerManager.m
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import "CMPageHeaderStyle.h"

@implementation CMPageHeaderStyle


+ (CMPageHeaderStyle *)styleWithTitleArray:(NSArray *)titles
                           controllerArray:(NSArray *)viewControllers
                            headerBarColor:(UIColor *)headerBarColor
                                 titleFont:(UIFont *)titleFont
                           textNormalColor:(UIColor *)textNormalColor
                         textSelectedColor:(UIColor *)textSelectedColor
                          headerViewHeight:(CGFloat)headerViewHeight
                        headerButtonMargin:(CGFloat)headerButtonMargin
                            indicatorColor:(UIColor *)indicatorColor
                        headerViewAligment:(HeaderPageScrollAlignmentType)alignmentType {
    
    CMPageHeaderStyle *retStyle = [CMPageHeaderStyle new];
    retStyle.titlesArray = titles;
    retStyle.controllersArray = viewControllers;
    retStyle.headerBarColor = headerBarColor;
    retStyle.titleFont = titleFont;
    retStyle.titleNormalColor = textNormalColor;
    retStyle.titleSelectedColor = textSelectedColor;
    retStyle.headerViewHeight = headerViewHeight;
    retStyle.headerButtonMargin = headerButtonMargin;
    retStyle.indicatorBarColor = indicatorColor;
    retStyle.headerAlignmentType = alignmentType;
    return retStyle;
}


@end
