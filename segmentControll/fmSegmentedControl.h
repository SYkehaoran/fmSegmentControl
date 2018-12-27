//
//  fmSegmentedControl.h
//  HXHQT
//
//  Created by 柯浩然 on 2017/2/9.
//  Copyright © 2017年 China Asset Management Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IndicatorPosition) {
    IndicatorPositionNone,
    IndicatorPositionTop,
    IndicatorPositionBottom,
    IndicatorPositionFill,
};
typedef void (^IndexChangeBlock)(NSInteger index);

@interface fmSegmentedControl : UIControl
/// deault is IndicatorPositionTop
@property(nonatomic, assign) IndicatorPosition indicatorPosition;
/// default is 3
@property(nonatomic, assign) CGFloat indicatorHeight;
/// default is 15
@property(nonatomic, assign) CGFloat titleFont;

/**
 Provide a block to be executed when selected index is changed.
 */
@property(nonatomic, copy) IndexChangeBlock indexChangeBlock;

/**
 Index of the currently selected segment.
 Default is 0
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/**
 Default is YES. Set to NO to disable animation during user selection.
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

/**
 Color for the selection indicator box
 
 Default is red
 */
@property(nonatomic, strong) UIColor *themeColor;

/**
 Only IndicatorPosition == IndicatorPositionFill is enabled.
 Defalut is white
 */
@property(nonatomic, strong) UIColor *fillSelectedTextColor;
///defalut is black
@property(nonatomic, strong) UIColor *titleColor;

@property(nonatomic, strong) NSArray<NSString *> *sectionTitles;
///if setup,sepatator will show
@property(nonatomic, strong) UIColor *sepatatorColor;

- (instancetype)initWithFrame:(CGRect)frame sectionTitles:(NSArray *)sectiontitles;

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;
@end
