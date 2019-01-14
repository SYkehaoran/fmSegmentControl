//
//  fmSegmentedControl.m
//  HXHQT
//
//  Created by 柯浩然 on 2017/2/9.
//  Copyright © 2017年 China Asset Management Co., Ltd. All rights reserved.
//

#import "fmSegmentedControl.h"
#import "NSArray+Functional.h"

#define kLineWidth 1 / [[UIScreen mainScreen] scale]
@interface fmSegmentedControl ()

@property(nonatomic, strong) NSArray<UILabel *> *sectionItems;
@property(nonatomic, strong) NSArray<UIView *> *sectionSeparators;

@property(nonatomic, strong) UIView *selectionIndicatorView;

@property(nonatomic, assign) CGRect indicatorViewFrame;
@property(nonatomic, assign) CGFloat segmentHeight;
@property(nonatomic, strong) UILabel *selectedLabel;

@end
@implementation fmSegmentedControl

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame sectionTitles:(NSArray *)sectiontitles {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
        self.sectionTitles = sectiontitles;
    }
    return self;
}

#pragma mark - Index Change

- (void)setSelectedSegmentIndex:(NSInteger)index {
    
    [self setSelectedSegmentIndex:index animated:NO notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    
    [self setSelectedSegmentIndex:index animated:animated notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated notify:(BOOL)notify {
    
    _selectedSegmentIndex = index;
    UILabel *item = self.sectionItems[index];
    
    if (self.selectedLabel != item) {
        
        self.selectedLabel.textColor = _titleColor;
        item.textColor = [self getSelectedItemColor];
        self.selectedLabel = item;
    }
    
    if (animated) {
        
        self.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:0.15f animations:^{
            
            self.selectionIndicatorView.frame = [self getIndicatorViewFrameWithSelectedItem];
        }completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
        
    }else {
        
        self.selectionIndicatorView.frame = [self getIndicatorViewFrameWithSelectedItem];
    }
    
    if (notify) {
        !self.indexChangeBlock ? : self.indexChangeBlock(index,item.text);
    }
}

- (void)commonInit {
    
    self.titleFont = 15;
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleColor = [UIColor blackColor];
    self.shouldAnimateUserSelection = YES;
    self.indicatorPosition = IndicatorPositionBottom;
    self.themeColor = [UIColor redColor];
    self.sepatatorColor = nil;
    self.fillSelectedTextColor = [UIColor whiteColor];
    _indicatorHeight = 3;
    
    self.selectionIndicatorView = [[UIView alloc] init];
    [self insertSubview:self.selectionIndicatorView atIndex:0];
    
}

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles {
    
    _sectionTitles = [sectionTitles filter:^BOOL(NSString *obj) {
        return obj != nil && obj.length != 0;
    }];
    
    if (self.sectionTitles.count == 0) {
        return;
    }
    
    self.sectionItems = [self.sectionItems map:^id(id obj) {
        [obj removeFromSuperview];
        return nil;
    }];
    
    self.sectionSeparators = [self.sectionSeparators map:^id(id obj) {
        [obj removeFromSuperview];
        return nil;
    }];
    
    NSMutableArray<UILabel *> *itemArray = [NSMutableArray array];
    self.sectionItems = itemArray;
    
    NSMutableArray<UIView *> *separatorArray = [NSMutableArray array];
    self.sectionSeparators = separatorArray;
    
    CGFloat separatorCount = _sectionTitles.count - 1;
    
    for (NSInteger i = 0; i < _sectionTitles.count; i++) {
        
        NSString *title = _sectionTitles[i];
        UILabel *item = [[UILabel alloc] init];
        
        item.tag = i;
        item.text = title;
        item.textColor = _titleColor;
        item.textAlignment = NSTextAlignmentCenter;
        item.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTouchUpInside:)];
        [item addGestureRecognizer:tap];
        
        [itemArray addObject:item];
        [self addSubview:item];
    };
    
    for (NSInteger i = 0; i < separatorCount; i++) {
        
        UIView *separatorView = [[UIView alloc] init];
        
        if (self.sepatatorColor != nil) {
            
            separatorView.backgroundColor = self.sepatatorColor;
            [self addSubview:separatorView];
        }
        [separatorArray addObject:separatorView];
    }
}

- (void)layoutItems {
    
    CGFloat separatorCount = _sectionTitles.count - 1;
    
    CGFloat itemWidth = (self.frame.size.width - kLineWidth * separatorCount) / _sectionTitles.count;
    CGFloat itemHeight = self.frame.size.height;
    
    for (NSInteger i = 0; i < _sectionItems.count; i++) {
        
        UILabel *item = _sectionItems[i];
        item.frame = CGRectMake(i *(kLineWidth + itemWidth), 0, itemWidth, itemHeight);
    };
    
    for (NSInteger i = 0; i < self.sectionSeparators.count; i++) {
        
        UIView *separatorView = self.sectionSeparators[i];
        separatorView.frame = CGRectMake(i * kLineWidth + (i + 1) * itemWidth, 0, kLineWidth, itemHeight);
    }
    
    self.selectionIndicatorView.frame = [self getIndicatorViewFrameWithSelectedItem];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self layoutItems];
}

- (void)itemTouchUpInside:(UIGestureRecognizer *)sender {
    
    [self setSelectedSegmentIndex:sender.view.tag animated:_shouldAnimateUserSelection notify:YES];
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight {
    
    _indicatorHeight = indicatorHeight;
}

- (void)setTitleFont:(CGFloat)titleFont {
    
    _titleFont = titleFont;
    for (UILabel *item in self.sectionItems) {
        
        item.font = [UIFont systemFontOfSize:_titleFont];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    [self.sectionItems map:^id(UILabel *obj) {
        obj.textColor = titleColor;
        return obj;
    }];
}

- (void)setThemeColor:(UIColor *)themeColor {
    
    _themeColor = themeColor;
    
    self.selectionIndicatorView.backgroundColor = themeColor;
}

- (void)setIndicatorPosition:(IndicatorPosition)indicatorPosition {
    
    _indicatorPosition = indicatorPosition;
}

- (UIColor *)getSelectedItemColor {
    return self.indicatorPosition == IndicatorPositionFill ? _fillSelectedTextColor : _themeColor;
}

- (CGRect)getIndicatorViewFrameWithSelectedItem {
    
    if (self.selectedLabel == nil) {
        return CGRectZero;
    }
    
    CGRect indicatorViewFrame = CGRectZero;
    
    indicatorViewFrame.origin.x = self.selectedLabel.frame.origin.x;
    indicatorViewFrame.size.width = self.selectedLabel.frame.size.width;
    
    switch (_indicatorPosition) {
            
        case IndicatorPositionTop:
            indicatorViewFrame.origin.y = 0;
            indicatorViewFrame.size.height = _indicatorHeight;
            break;
        case IndicatorPositionBottom:
            indicatorViewFrame.origin.y = self.selectedLabel.frame.size.height - _indicatorHeight;
            indicatorViewFrame.size.height = _indicatorHeight;
            break;
        case IndicatorPositionFill:
            
            indicatorViewFrame.origin.y = 0;
            indicatorViewFrame.size.height = self.selectedLabel.frame.size.height;
            break;
        case IndicatorPositionNone:
            indicatorViewFrame = CGRectZero;
        default:
            break;
    }
    return indicatorViewFrame;
}

- (void)setSepatatorColor:(UIColor *)sepatatorColor {
    
    _sepatatorColor = sepatatorColor;
    if (self.sectionSeparators.count != 0) {
        [self.sectionSeparators map:^id(UIView *obj) {
            obj.backgroundColor = sepatatorColor;
            [self addSubview:obj];
            return obj;
        }];
    }
}

- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock {
    
    _indexChangeBlock = indexChangeBlock;
}

@end
