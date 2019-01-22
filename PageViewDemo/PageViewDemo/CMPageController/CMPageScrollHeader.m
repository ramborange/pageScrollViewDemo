//
//  CMPageScrollHeader.m
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import "CMPageScrollHeader.h"

#define IndicatorBar_height 2 //选中指示条的高度
#define kHeader_Button_Tag 2000 //顶部按钮tag基值

@interface CMPageScrollHeader ()

/**
 顶部样式数据
 */
@property (nonatomic, strong) CMPageHeaderStyle *headerStyle;

/**
 标题数组
 */
@property (nonatomic, strong) NSArray *titleArray;

/**
 底部选中指示条视图
 */
@property (nonatomic, strong) UIView *bottomLine;

/**
 当前选中的按钮idx
 */
@property (nonatomic, assign) NSInteger seletctedIdx;

@end

@implementation CMPageScrollHeader

- (instancetype)initWithTitleArray:(NSArray *)titleArray
                             frame:(CGRect)frame
                             style:(CMPageHeaderStyle *)headerStyle {
    self = [super init];
    if (self) {
        self.titleArray = titleArray;
        self.frame = frame;
        self.headerStyle = headerStyle;
        //初始化视图
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    if (self.headerStyle.headerBarColor) {
        self.backgroundColor = self.headerStyle.headerBarColor;
    }
    self.seletctedIdx = 0;
    self.showsHorizontalScrollIndicator = NO;
   
    [self.titleArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:(UIControlStateNormal)];
        if (idx == 0) {
            [button setTitleColor:self.headerStyle.titleSelectedColor forState:(UIControlStateNormal)];
        } else {
            [button setTitleColor:self.headerStyle.titleNormalColor forState:(UIControlStateNormal)];
        }
        
        //按钮高度
        CGFloat btnHeight = self.headerStyle.headerViewHeight-IndicatorBar_height;
        //计算当前button的宽度
        CGFloat btnWidth = [obj boundingRectWithSize:CGSizeMake(MAXFLOAT, btnHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.headerStyle.titleFont} context:nil].size.width;
        //按钮之间的间距
        CGFloat btnMargin = self.headerStyle.headerButtonMargin;
        button.titleLabel.font = self.headerStyle.titleFont;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
        button.tag = kHeader_Button_Tag+idx;
        
        //设置button的frame 初始指示器frame
        if (idx) {
            UIButton *lastBtn = [self viewWithTag:kHeader_Button_Tag + idx - 1];
            button.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame) + btnMargin, 0, btnWidth, btnHeight);
        } else {
            button.frame = CGRectMake(btnMargin, 0, btnWidth, btnHeight);
        }
    }];

    //根据最后一个标题按钮计算contentSize和对齐方式改变
    UIButton *topLastBtn = [self viewWithTag:kHeader_Button_Tag + self.titleArray.count - 1];
    CGFloat all_X = CGRectGetMaxX(topLastBtn.frame) + self.headerStyle.headerButtonMargin;
    
    //设置顶部滚动视图-标题的对齐方式
    if (self.headerStyle.headerAlignmentType == HeaderPageScrollAlignmentLeft) {
        //默认的对齐方式 不需要做处理
    } else {
        //整个标题居中对齐 仅仅在contentSize小于scrollview宽度下生效
        if (all_X < self.bounds.size.width) {
            CGFloat gap_x = (self.bounds.size.width - all_X)/2.0;
            //重新设置标题数组frame
            for (int i=0; i<self.titleArray.count; i++) {
                UIButton *btn = [self viewWithTag:(kHeader_Button_Tag + i)];
                CGRect rect = btn.frame;
                if (i) {
                    UIButton *last= [self viewWithTag:kHeader_Button_Tag + i - 1];
                    rect.origin.x = CGRectGetMaxX(last.frame) + self.headerStyle.headerButtonMargin;
                } else {
                    rect.origin.x = gap_x + self.headerStyle.headerButtonMargin;
                }
                btn.frame = rect;
            }
        }
    }
    
    //底部颜色指示条视图
    UIButton *firstBtn = [self viewWithTag:kHeader_Button_Tag];
    CGFloat lineview_width = CGRectGetWidth(firstBtn.frame);
    self.bottomLine.backgroundColor = self.headerStyle.indicatorBarColor;
    self.bottomLine.frame = CGRectMake(CGRectGetMinX(firstBtn.frame), self.headerStyle.headerViewHeight-IndicatorBar_height*2, lineview_width, IndicatorBar_height);
    self.bottomLine.layer.cornerRadius = 1.0;
    self.bottomLine.layer.masksToBounds = YES;
    [self addSubview:self.bottomLine];
    
    //设置顶部滚动菜单视图的contentSize
    self.contentSize = CGSizeMake(all_X, self.headerStyle.headerViewHeight);
}

#pragma mark -- 顶部按钮点击
- (void)buttonClick:(UIButton *)sender{
    // 指示线移动
    NSUInteger clickIdx = sender.tag - kHeader_Button_Tag;
    
    //选中按钮后的回调事件
    self.headerSelectHandler(clickIdx);
    
    //滑动到点击到的按钮
    [self slideHeadWithIndex:clickIdx];
    
}

#pragma mark -- 滑动顶部按钮到第几个
- (void)slideHeadWithIndex:(NSInteger)index{
    CGFloat contentWith = self.contentSize.width;
    CGFloat scrollWith = self.bounds.size.width;
    CGFloat scroll_diff = contentWith - scrollWith;
    //设置滑动动画
    if (scroll_diff > 0) {
        //可以滑动
        UIButton *currentBtn = [self viewWithTag:(kHeader_Button_Tag + index)];
        CGFloat btn_center = CGRectGetMinX(currentBtn.frame) + CGRectGetWidth(currentBtn.frame)/2.0;
        
        CGFloat btn_diff = (btn_center/(contentWith - self.headerStyle.headerButtonMargin*2))*scroll_diff;
        
        btn_diff = MIN(btn_diff, scroll_diff);
        
        [self setContentOffset:CGPointMake(btn_diff, 0) animated:YES];
        
        
    } else {
        //无需滑动
    }
    //设置按钮颜色改变
    UIButton *currentBtn = [self viewWithTag:kHeader_Button_Tag + self.seletctedIdx];
    UIButton *selectedBtn = [self viewWithTag:kHeader_Button_Tag + index];
    
    //这只指示条frame改变
    CGFloat origin_x = CGRectGetMinX(selectedBtn.frame);
    CGFloat line_width = CGRectGetWidth(selectedBtn.frame);
    CGRect lineRect = CGRectMake(origin_x, self.headerStyle.headerViewHeight - IndicatorBar_height*2, line_width, IndicatorBar_height);
    __weak __typeof(self)weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.bottomLine.frame = lineRect;
        [currentBtn setTitleColor:self.headerStyle.titleNormalColor forState:UIControlStateNormal];
        [selectedBtn setTitleColor:self.headerStyle.titleSelectedColor forState:UIControlStateNormal];

    }];
    
    self.seletctedIdx = index;
}

#pragma mark -- 懒加载
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}

@end

