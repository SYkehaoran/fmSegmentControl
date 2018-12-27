//
//  ViewController.m
//  fmSegmentControllTest
//
//  Created by 柯浩然 on 2018/12/27.
//  Copyright © 2018 柯浩然. All rights reserved.
//

#import "ViewController.h"
#import "fmSegmentedControl.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fmSegmentedControl *segmentedControl = [[fmSegmentedControl alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 35)];
    [self.view addSubview:segmentedControl];
    //    segmentedControl.sepatatorColor = [UIColor blueColor];
    segmentedControl.sectionTitles = @[@"近1月",@"近3月",@"近6月",@"近1年",@"近3年",@""];
    
    segmentedControl.themeColor = [UIColor redColor];
    
    segmentedControl.indicatorPosition = IndicatorPositionTop;
    segmentedControl.fillSelectedTextColor = [UIColor blackColor];
    //    UIView *topLine = [[UIView alloc] init];
    //    [segmentedControl insertSubview:topLine atIndex:0];
    //    topLine.frame = CGRectMake(0, 0, segmentedControl.frame.size.width, 1);
    //    topLine.backgroundColor = [UIColor blueColor];
}


@end
